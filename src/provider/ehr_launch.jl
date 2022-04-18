# Note: The "EHR Launch" workflow is also known as the "Embedded Launch" workflow.

const _default_scope = "launch"

"""
    provider_ehr_launch(
        config::ProviderEHRLaunchConfig,
        uri_string::String;
        kwargs...,
    )

## Optional Keyword Arguments:
- `scope::String`. Default value: `$(_default_scope)`.
"""
function provider_ehr_launch(
        config::ProviderEHRLaunchConfig,
        uri_string::AbstractString;
        kwargs...,
    )
    uri = URIs.URI(uri_string)
    return provider_ehr_launch(config, uri; kwargs...)
end

"""
    provider_ehr_launch(
        config::ProviderEHRLaunchConfig,
        uri::URIs.URI;
        kwargs...,
    )

## Optional Keyword Arguments:
- `scope::String`. Default value: `$(_default_scope)`.
"""
function provider_ehr_launch(
        config::ProviderEHRLaunchConfig,
        uri::URIs.URI;
        kwargs...,
    )
    queryparams = URIs.queryparams(uri)::Dict{String, String}
    return provider_ehr_launch(config, queryparams; kwargs...)
end

"""
    provider_ehr_launch(
        config::ProviderEHRLaunchConfig,
        queryparams::Dict;
        kwargs...,
    )

## Optional Keyword Arguments:
- `scope::String`. Default value: `$(_default_scope)`.
"""
function provider_ehr_launch(
        config::ProviderEHRLaunchConfig,
        queryparams::AbstractDict;
        scope::String = _default_scope,
    )
    iss          = queryparams["iss"]::String
    launch_token = queryparams["launch"]::String
    return provider_ehr_launch(config; iss, launch_token, scope)
end

"""
    provider_ehr_launch(
        config::ProviderEHRLaunchConfig;
        iss::String,
        launch_token::String,
        kwargs...,
    )

## Required Keyword Arguments:
- `iss::String`
- `launch_token::String`

## Optional Keyword Arguments:
- `scope::String`. Default value: `$(_default_scope)`.
"""
function provider_ehr_launch(
        config::ProviderEHRLaunchConfig;
        iss::String,
        launch_token::String,
        scope::String = _default_scope,
    )
    authorize_uri_with_querystring_params = provider_ehr_launch_part_one(
        config;
        iss,
        launch_token,
        scope,
    )
    location_queryparams = provider_ehr_launch_part_two(
        config,
        authorize_uri_with_querystring_params,
    )
    ehr_launch_result = provider_ehr_launch_part_three(
        config,
        location_queryparams;
        launch_token,
    )
    return ehr_launch_result
end

"""
    provider_ehr_launch_part_one(
        config::ProviderEHRLaunchConfig;
        iss::String,
        launch_token::String,
        kwargs...,
    )

## Required Keyword Arguments:
- `iss::String`
- `launch_token::String`

## Optional Keyword Arguments:
- `scope::String`. Default value: `$(_default_scope)`.
- `additional_state::Union{String, Nothing}`. Default value: `nothing`.
"""
function provider_ehr_launch_part_one(
        config::ProviderEHRLaunchConfig;
        iss::String,
        launch_token::String,
        scope::String = _default_scope,
        additional_state::Union{String, Nothing} = nothing,
    )
    iss_metadata_endpoint = "$(iss)/metadata"
    metadata_response = HTTP.request(
        "GET",
        iss_metadata_endpoint;
        headers = Dict(
            "Accept" => "application/fhir+json",
            "Epic-Client-ID" => config.client_id,
        ),
    )
    metadata_response_json = JSON3.read(String(metadata_response.body))
    extension = metadata_response_json.rest[1].security.extension[1].extension
    endpoints = _get_endpoints_from_extension(extension)
    authorize_endpoint = endpoints["authorize"]::String
    token_endpoint     = endpoints["token"]::String

    state_dict = Dict{Symbol, String}()
    state_dict[:token_endpoint] = token_endpoint
    if additional_state !== nothing
        additional_state_stripped = strip(additional_state)
        if !isempty(additional_state_stripped)
            state_dict[:additional_state] = additional_state_stripped
        end
    end
    state_json = JSON3.write(state_dict)
    state = Base64.base64encode(state_json)

    authorize_uri_with_querystring_params = URIs.URI(
        URIs.URI(authorize_endpoint);
        query = Dict(
            "aud"           => iss,
            "client_id"     => config.client_id,
            "launch"        => launch_token,
            "redirect_uri"  => config.redirect_uri,
            "response_type" => "code",
            "scope"         => scope,
            "state"         => state,
        )
    )
    return authorize_uri_with_querystring_params
end

"""
    provider_ehr_launch_part_two(
        config::ProviderEHRLaunchConfig,
        authorize_uri_with_querystring_params::URIs.URI,
    )
"""
function provider_ehr_launch_part_two(
        config::ProviderEHRLaunchConfig,
        authorize_uri_with_querystring_params::URIs.URI,
    )
    authorize_response = HTTP.request(
        "GET",
        authorize_uri_with_querystring_params;
        redirect = false,
    )
    headers = Dict(authorize_response.headers)
    let
        error_msg = string(
            "Something when wrong when authenticating to the EHR. ",
            "One possible explanation is that your `redirect_uri` value does not exactly ",
            "match any of the `redirect_uri` values that are on file with the EHR.",
        )
        haskey(headers, "Location") || throw(ErrorException(error_msg))
    end
    location = headers["Location"]
    location_uri = URIs.URI(location)
    location_queryparams = URIs.queryparams(location_uri)
    return location_queryparams
end

"""
    provider_ehr_launch_part_three(
        config::ProviderEHRLaunchConfig,
        location_queryparams::Dict;
        kwargs...,
    )
"""
function provider_ehr_launch_part_three(
        config::ProviderEHRLaunchConfig,
        location_queryparams::AbstractDict;
        launch_token::String = "", #used for debugging in case ehr provides it, might not be present in all ehrs
    )
    let
        error_msg = "Encountered an error while trying to authenticate to the EHR."
        haskey(location_queryparams, "error")             && @error "Error: $(location_queryparams["error"])"
        haskey(location_queryparams, "error_description") && @error "Error description: $(location_queryparams["error_description"])"
        haskey(location_queryparams, "code")              || throw(ErrorException(error_msg))
    end
    authorization_code = location_queryparams["code"]::String
    state = location_queryparams["state"]::String
    @static if Base.VERSION < v"1.9-"
        # padding is needed for `base64decode` to work on older versions of Julia
        # https://github.com/JuliaLang/julia/pull/44503
        state = state * "=="
    end
    state_json = Base64.base64decode(state)
    state_dict = JSON3.read(state_json)
    token_endpoint_original = state_dict[:token_endpoint]::String
    token_endpoint_stripped = strip(token_endpoint_original)
    if isempty(token_endpoint_stripped)
        msg = "Could not extract the `token_endpoint` from the `state`"
        throw(ErrorException(msg))
    end
    authz_code_info = _AuthorizationCodeInformation(;
        authorization_code,
        client_id      = config.client_id,
        redirect_uri   = config.redirect_uri,
        token_endpoint = token_endpoint_stripped,
    )
    access_token_info = authorization_code_to_access_token(authz_code_info)
    launch_token_is_jwt, launch_token_jwt_decoded = try_decode_jwt(launch_token)
    ehr_launch_result = ProviderEHRLaunchResult(;
        authorization_code             = access_token_info.authorization_code,
        authorization_code_is_jwt      = access_token_info.authorization_code_is_jwt,
        authorization_code_jwt_decoded = access_token_info.authorization_code_jwt_decoded,
        access_token                   = access_token_info.access_token,
        access_token_is_jwt            = access_token_info.access_token_is_jwt,
        access_token_jwt_decoded       = access_token_info.access_token_jwt_decoded,
        access_token_response          = access_token_info.access_token_response,
        launch_token                   = launch_token,
        launch_token_is_jwt            = launch_token_is_jwt,
        launch_token_jwt_decoded       = launch_token_jwt_decoded,
    )
    return ehr_launch_result
end

function _get_endpoints_from_extension(extension)
    endpoints = Dict{String, String}()
    for e ∈ extension
        value_uri = e.valueUri
        url = e.url
        endpoints[url] = value_uri
    end
    return endpoints
end
