"""
    ProviderStandaloneConfig(; kwargs...)

## Required Keyword Arguments:
- `authorize_endpoint::String`
- `client_id::String`
- `redirect_uri::String`
- `token_endpoint::String`
"""
Base.@kwdef struct ProviderStandaloneConfig
    authorize_endpoint::String
    client_id::String
    redirect_uri::String
    token_endpoint::String
end

Base.@kwdef struct ProviderStandaloneResult
    code::String
    code_is_jwt::Bool = false
    code_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
    access_token::String
    access_token_is_jwt::Bool = false
    access_token_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
    access_token_response::Dict{Symbol, Any}
end

"""
    get_access_token(result::ProviderStandaloneResult)
"""
function get_access_token(result::ProviderStandaloneResult)
    return result.access_token::String
end
