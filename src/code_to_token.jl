function authorization_code_to_access_token(authz_code_info::_AuthorizationCodeInformation)
    authorization_code = authz_code_info.authorization_code
    client_id          = authz_code_info.client_id
    redirect_uri       = authz_code_info.redirect_uri
    token_endpoint     = authz_code_info.token_endpoint

    _response = HTTP.request(
        "POST",
        token_endpoint;
        headers = Dict("Content-Type" => "application/x-www-form-urlencoded"),
        body = URIs.escapeuri(Dict(
            "client_id" => client_id,
            "code" => authorization_code,
            "grant_type" => "authorization_code",
            "redirect_uri" => redirect_uri,
        )),
    )
    access_token_response = JSON3.read(String(_response.body))
    access_token = access_token_response.access_token

    authorization_code_is_jwt = is_jwt(authorization_code)
    if authorization_code_is_jwt
        authorization_code_jwt_decoded = decode_jwt(authorization_code)::Dict{String, Any}
    else
        authorization_code_jwt_decoded = Dict{String, Any}()
    end

    access_token_is_jwt = is_jwt(access_token)
    if access_token_is_jwt
        access_token_jwt_decoded = decode_jwt(access_token)::Dict{String, Any}
    else
        access_token_jwt_decoded = Dict{String, Any}()
    end

    access_token_info = _AccessTokenInformation(;
        authorization_code             = authorization_code,
        authorization_code_is_jwt      = authorization_code_is_jwt,
        authorization_code_jwt_decoded = authorization_code_jwt_decoded,
        access_token                   = access_token,
        access_token_is_jwt            = access_token_is_jwt,
        access_token_jwt_decoded       = access_token_jwt_decoded,
        access_token_response          = access_token_response,
    )

    return access_token_info
end
