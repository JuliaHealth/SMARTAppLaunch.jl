function is_jwt(contents::AbstractString)
    try
        JSONWebTokens.decode(JSONWebTokens.None(), contents)
        return true
    catch
    end
    return false
end

function decode_jwt(contents::AbstractString)
    return JSONWebTokens.decode(JSONWebTokens.None(), contents)::Dict{String, Any}
end
