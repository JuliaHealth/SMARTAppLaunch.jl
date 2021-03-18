"""
    ProviderEHRLaunchConfig(; kwargs...)

## Required Keyword Arguments:
- `client_id::String`
- `redirect_uri::String`
"""
Base.@kwdef struct ProviderEHRLaunchConfig
    client_id::String
    redirect_uri::String
end

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

Base.@kwdef struct _AuthorizationCodeInformation
    authorization_code::String
    client_id::String
    redirect_uri::String
    token_endpoint::String
end

Base.@kwdef struct _AccessTokenInformation
    access_token::String
    access_token_is_jwt::Bool = false
    access_token_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
    access_token_response::Dict{Symbol, Any}
    authorization_code::String
    authorization_code_is_jwt::Bool = false
    authorization_code_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
end

Base.@kwdef struct ProviderEHRLaunchResult
    access_token::String
    access_token_is_jwt::Bool = false
    access_token_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
    access_token_response::Dict{Symbol, Any}
    authorization_code::String
    authorization_code_is_jwt::Bool = false
    authorization_code_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
    launch_token::String
    launch_token_is_jwt::Bool = false
    launch_token_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
end

Base.@kwdef struct ProviderStandaloneResult
    access_token::String
    access_token_is_jwt::Bool = false
    access_token_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
    access_token_response::Dict{Symbol, Any}
    authorization_code::String
    authorization_code_is_jwt::Bool = false
    authorization_code_jwt_decoded::Dict{String, Any} = Dict{String, Any}()
end

"""
    HealthBase.get_fhir_access_token(result::ProviderEHRLaunchResult)
"""
function HealthBase.get_fhir_access_token(result::ProviderEHRLaunchResult)
    return result.access_token
end

"""
    HealthBase.has_fhir_patient_id(result::ProviderEHRLaunchResult)
"""
function HealthBase.has_fhir_patient_id(result::ProviderEHRLaunchResult)
    return haskey(result.access_token_response, :patient)
end

"""
    HealthBase.get_fhir_patient_id(result::ProviderEHRLaunchResult)
"""
function HealthBase.get_fhir_patient_id(result::ProviderEHRLaunchResult)
    return result.access_token_response[:patient]
end

"""
    HealthBase.get_fhir_access_token(result::ProviderStandaloneResult)
"""
function HealthBase.get_fhir_access_token(result::ProviderStandaloneResult)
    return result.access_token
end
