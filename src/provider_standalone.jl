"""
    provider_standalone_step1(config::ProviderStandaloneConfig; kwargs...)

## Optional Keyword Arguments:
- `scope::AbstractString`. Default value: `"launch"`.
"""
function provider_standalone_step1(config::ProviderStandaloneConfig;
                                   scope::AbstractString = "launch")
    uri = URIs.URI(
        URIs.URI(config.authorize_endpoint);
        query = Dict(
            "client_id" => config.client_id,
            "scope" => scope,
            "response_type" => "code",
            "redirect_uri" => config.redirect_uri,
        )
    )
    uristring = URIs.uristring(uri)
    msg = ""
    msg = string(
        "In your web browser, go to \"$(uristring)\" and log in with the EHR/EMR ",
        "credentials. Then, copy the URL that you are redirected to, and run ",
        "`SMARTAppLaunch.standalone2(config, url_to_which_you_are_redirected)`.",
    )
    @info msg
    return uri
end

"""
    provider_standalone_step2(config::ProviderStandaloneConfig, uri_string::AbstractString)
"""
function provider_standalone_step2(config::ProviderStandaloneConfig,
                                   uri_string::AbstractString)
    uri = URIs.URI(uri_string)
    return provider_standalone_step2(config, uri)
end

"""
    provider_standalone_step2(config::ProviderStandaloneConfig, uri::URIs.URI)
"""
function provider_standalone_step2(config::ProviderStandaloneConfig,
                                   uri::URIs.URI)
    queryparams = URIs.queryparams(uri)
    code = queryparams["code"]
    code_is_jwt = is_jwt(code)

    _response = HTTP.request(
        "POST",
        config.token_endpoint;
        headers = Dict("Content-Type" => "application/x-www-form-urlencoded"),
        body = URIs.escapeuri(Dict(
            "client_id" => config.client_id,
            "code" => code,
            "grant_type" => "authorization_code",
            "redirect_uri" => config.redirect_uri,
        )),
    )

    access_token_response = JSON3.read(String(_response.body))
    access_token = access_token_response.access_token
    access_token_is_jwt = is_jwt(access_token)

    if code_is_jwt
        code_jwt_decoded = decode_jwt(code)::Dict{String, Any}
    else
        code_jwt_decoded = Dict{String, Any}()
    end
    if access_token_is_jwt
        access_token_jwt_decoded = decode_jwt(access_token)::Dict{String, Any}
    else
        access_token_jwt_decoded = Dict{String, Any}()
    end

    result = ProviderStandaloneResult(;
        code                     = code,
        code_is_jwt              = code_is_jwt,
        code_jwt_decoded         = code_jwt_decoded,
        access_token             = access_token,
        access_token_is_jwt      = access_token_is_jwt,
        access_token_jwt_decoded = access_token_jwt_decoded,
        access_token_response    = access_token_response,
    )

    return result
end
