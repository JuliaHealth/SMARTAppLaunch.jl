"""
    provider_standalone_step1(config::ProviderStandaloneConfig; kwargs...)

## Optional Keyword Arguments:
- `scope::AbstractString`. Default value: `"launch"`.
"""
function provider_standalone_step1(
    config::ProviderStandaloneConfig; scope::AbstractString="launch"
)
    uri = URIs.URI(
        URIs.URI(config.authorize_endpoint);
        query=Dict(
            "client_id" => config.client_id,
            "scope" => scope,
            "response_type" => "code",
            "redirect_uri" => config.redirect_uri,
        ),
    )
    return uri
end

"""
    provider_standalone_step2(config::ProviderStandaloneConfig, uri_string::AbstractString)
"""
function provider_standalone_step2(
    config::ProviderStandaloneConfig, uri_string::AbstractString
)
    uri = URIs.URI(uri_string)
    return provider_standalone_step2(config, uri)
end

"""
    provider_standalone_step2(config::ProviderStandaloneConfig, uri::URIs.URI)
"""
function provider_standalone_step2(config::ProviderStandaloneConfig, uri::URIs.URI)
    queryparams = URIs.queryparams(uri)
    authorization_code = queryparams["code"]

    authz_code_info = _AuthorizationCodeInformation(;
        authorization_code=authorization_code,
        client_id=config.client_id,
        redirect_uri=config.redirect_uri,
        token_endpoint=config.token_endpoint,
    )

    access_token_info = authorization_code_to_access_token(authz_code_info)

    standalone_result = ProviderStandaloneResult(;
        authorization_code=access_token_info.authorization_code,
        authorization_code_is_jwt=access_token_info.authorization_code_is_jwt,
        authorization_code_jwt_decoded=access_token_info.authorization_code_jwt_decoded,
        access_token=access_token_info.access_token,
        access_token_is_jwt=access_token_info.access_token_is_jwt,
        access_token_jwt_decoded=access_token_info.access_token_jwt_decoded,
        access_token_response=access_token_info.access_token_response,
    )

    return standalone_result
end
