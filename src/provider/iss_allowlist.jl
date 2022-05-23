function check_iss_against_allowlist(config::ProviderEHRLaunchConfig, iss::AbstractString)
    if config.enforce_iss_allowlist
        iss_string = convert(String, iss)::String
        if iss_string in config.iss_allowlist
            return nothing
        else
            msg = "The iss allowlist does not contain the following iss: $(iss_string)"
            throw(ErrorException(msg))
        end
    else
        if isempty(config.iss_allowlist)
            return nothing
        else
            msg = "If `iss_allowlist` is nonempty, you must set `enforce_iss_allowlist` to `true`"
            throw(ErrorException(msg))
        end
    end
end
