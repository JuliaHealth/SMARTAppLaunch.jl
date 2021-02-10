"""
struct SMARTStandaloneConfig

Fields:
- authorize_endpoint::String
- client_id::String
- oauth2_endpoint::String
- redirect_uri::String

"""
Base.@kwdef struct SMARTStandaloneConfig
    authorize_endpoint::String # required
    client_id::String          # required
    oauth2_endpoint::String    # required
    redirect_uri::String       # required
end

"""
struct SMARTStandaloneResult

Fields:
- code::String
- code_is_jwt::Bool
- code_jwt_decoded::Dict{String, Any}
- access_token::String
- access_token_is_jwt::Bool
- access_token_jwt_decoded::Dict{String, Any}
- access_token_response::Dict{Symbol, Any}
"""
Base.@kwdef struct SMARTStandaloneResult
    code::String                                                      # required
    code_is_jwt::Bool = false                                         # optional
    code_jwt_decoded::Dict{String, Any} = Dict{String, Any}()         # optional
    access_token::String                                              # required
    access_token_is_jwt::Bool = false                                 # optional
    access_token_jwt_decoded::Dict{String, Any} = Dict{String, Any}() # optional
    access_token_response::Dict{Symbol, Any}                          # required
end
