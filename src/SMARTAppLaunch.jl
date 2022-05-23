module SMARTAppLaunch

using Base64: Base64
using HTTP: HTTP
using HealthBase: HealthBase
using JSON3: JSON3
using JSONWebTokens: JSONWebTokens
using URIs: URIs

const get_fhir_access_token = HealthBase.get_fhir_access_token
const get_fhir_patient_id = HealthBase.get_fhir_patient_id
const has_fhir_patient_id = HealthBase.has_fhir_patient_id

export ProviderEHRLaunchConfig
export ProviderStandaloneConfig
export get_fhir_access_token
export get_fhir_patient_id
export has_fhir_patient_id
export provider_ehr_launch
export provider_standalone_step1
export provider_standalone_step2

include("types.jl")

include("code_to_token.jl")
include("jwt.jl")

include("provider/ehr_launch.jl")
include("provider/iss_allowlist.jl")
include("provider/standalone.jl")

end # module
