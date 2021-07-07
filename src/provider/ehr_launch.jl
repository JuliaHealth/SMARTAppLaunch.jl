# Note: The "EHR Launch" workflow is also known as the "Embedded Launch" workflow.

function _get_endpoints_from_extension(extension)
    endpoints = Dict{String, String}()
    for e ∈ extension
        value_uri = e.valueUri
        url = e.url
        endpoints[url] = value_uri
    end
    return endpoints
end

"""
    provider_ehr_launch(config::ProviderEHRLaunchConfig, uri_string::AbstractString; kwargs...)

## Optional Keyword Arguments:
- `scope::AbstractString`. Default value: `"launch"`.
"""
function provider_ehr_launch(config::ProviderEHRLaunchConfig,
                             uri_string::AbstractString;
                             kwargs...)
    uri = URIs.URI(uri_string)
    return provider_ehr_launch(config, URIs.queryparams(uri); kwargs...)
end

"""
    provider_ehr_launch(config::ProviderEHRLaunchConfig, uri::URIs.URI; kwargs...)

## Optional Keyword Arguments:
- `scope::AbstractString`. Default value: `"launch"`.
"""
function provider_ehr_launch(config::ProviderEHRLaunchConfig,
                             uri::URIs.URI;
                             scope::AbstractString = "launch")
    return provider_ehr_launch(config, URIs.queryparams(uri); kwargs...)
end
"""
    provider_ehr_launch(config::ProviderEHRLaunchConfig, queryparams::Dict; kwargs...)

## Optional Keyword Arguments:
- `scope::AbstractString`. Default value: `"launch"`.
"""
function provider_ehr_launch(config::ProviderEHRLaunchConfig,
                             queryparams::Dict;
                             scope::AbstractString = "launch")
    iss          = queryparams["iss"]
    launch_token = queryparams["launch"]
    iss_metadata_endpoint = "$(iss)/Metadata"
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
    authorize_endpoint = endpoints["authorize"]
    token_endpoint = endpoints["token"]
    authorize_uri_with_querystring_params = URIs.URI(
        URIs.URI(authorize_endpoint);
        query = Dict(
            "client_id" => config.client_id,
            "launch" => launch_token,
            "redirect_uri" => config.redirect_uri,
            "response_type" => "code",
            "scope" => scope,
        )
    )
    authorize_response = HTTP.request(
        "GET",
        authorize_uri_with_querystring_params;
        redirect = false,
    )
    headers = Dict(authorize_response.headers)
    location = headers["Location"]
    location_uri = URIs.URI(location)
    location_queryparams = URIs.queryparams(location_uri)
    authorization_code = location_queryparams["code"]

    authz_code_info = _AuthorizationCodeInformation(;
        authorization_code = authorization_code,
        client_id          = config.client_id,
        redirect_uri       = config.redirect_uri,
        token_endpoint     = token_endpoint,
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
