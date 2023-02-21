function check_iss_https(config::ProviderEHRLaunchConfig, iss::AbstractString)
    this_iss_uses_https = startswith(lowercase(strip(iss)), "https://")
    if this_iss_uses_https
        # This `iss` uses HTTPS.
        return nothing
    end
    # This `iss` does not use HTTPS.
    msg = "The following iss does not use HTTPS: $(iss)"
    if config.enforce_iss_https
        throw(ErrorException(msg))
    else
        @warn "`enforce_iss_https` is `false` - we strongly recommend that you set it to `true`" maxlog=1
        @warn msg
    end
end
