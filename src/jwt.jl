function try_decode_jwt(contents::AbstractString)
    try
        jwt_decoded = JSONWebTokens.decode(JSONWebTokens.None(), contents)
        return true, jwt_decoded
    catch
    end
    return false, Dict{String,Any}()
end
