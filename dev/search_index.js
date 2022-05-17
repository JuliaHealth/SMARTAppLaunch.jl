var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API","title":"API","text":"CurrentModule = SMARTAppLaunch","category":"page"},{"location":"api/#API","page":"API","title":"API","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"","category":"page"},{"location":"api/","page":"API","title":"API","text":"Modules = [SMARTAppLaunch]","category":"page"},{"location":"api/#SMARTAppLaunch.ProviderEHRLaunchConfig","page":"API","title":"SMARTAppLaunch.ProviderEHRLaunchConfig","text":"ProviderEHRLaunchConfig(; kwargs...)\n\nRequired Keyword Arguments:\n\nclient_id::String\nredirect_uri::String\n\n\n\n\n\n","category":"type"},{"location":"api/#SMARTAppLaunch.ProviderStandaloneConfig","page":"API","title":"SMARTAppLaunch.ProviderStandaloneConfig","text":"ProviderStandaloneConfig(; kwargs...)\n\nRequired Keyword Arguments:\n\nauthorize_endpoint::String\nclient_id::String\nredirect_uri::String\ntoken_endpoint::String\n\n\n\n\n\n","category":"type"},{"location":"api/#HealthBase.get_fhir_access_token-Tuple{SMARTAppLaunch.ProviderEHRLaunchResult}","page":"API","title":"HealthBase.get_fhir_access_token","text":"HealthBase.get_fhir_access_token(result::ProviderEHRLaunchResult)\n\n\n\n\n\n","category":"method"},{"location":"api/#HealthBase.get_fhir_access_token-Tuple{SMARTAppLaunch.ProviderStandaloneResult}","page":"API","title":"HealthBase.get_fhir_access_token","text":"HealthBase.get_fhir_access_token(result::ProviderStandaloneResult)\n\n\n\n\n\n","category":"method"},{"location":"api/#HealthBase.get_fhir_patient_id-Tuple{SMARTAppLaunch.ProviderEHRLaunchResult}","page":"API","title":"HealthBase.get_fhir_patient_id","text":"HealthBase.get_fhir_patient_id(result::ProviderEHRLaunchResult)\n\n\n\n\n\n","category":"method"},{"location":"api/#HealthBase.has_fhir_patient_id-Tuple{SMARTAppLaunch.ProviderEHRLaunchResult}","page":"API","title":"HealthBase.has_fhir_patient_id","text":"HealthBase.has_fhir_patient_id(result::ProviderEHRLaunchResult)\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch-Tuple{ProviderEHRLaunchConfig, AbstractDict}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch","text":"provider_ehr_launch(\n    config::ProviderEHRLaunchConfig,\n    queryparams::Dict;\n    kwargs...,\n)\n\nOptional Keyword Arguments:\n\nscope::String. Default value: launch.\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch-Tuple{ProviderEHRLaunchConfig, AbstractString}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch","text":"provider_ehr_launch(\n    config::ProviderEHRLaunchConfig,\n    uri_string::String;\n    kwargs...,\n)\n\nOptional Keyword Arguments:\n\nscope::String. Default value: launch.\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch-Tuple{ProviderEHRLaunchConfig, URIs.URI}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch","text":"provider_ehr_launch(\n    config::ProviderEHRLaunchConfig,\n    uri::URIs.URI;\n    kwargs...,\n)\n\nOptional Keyword Arguments:\n\nscope::String. Default value: launch.\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch-Tuple{ProviderEHRLaunchConfig}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch","text":"provider_ehr_launch(\n    config::ProviderEHRLaunchConfig;\n    iss::String,\n    launch_token::String,\n    kwargs...,\n)\n\nRequired Keyword Arguments:\n\niss::String\nlaunch_token::String\n\nOptional Keyword Arguments:\n\nscope::String. Default value: launch.\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch_part_one-Tuple{ProviderEHRLaunchConfig}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch_part_one","text":"provider_ehr_launch_part_one(\n    config::ProviderEHRLaunchConfig;\n    iss::String,\n    launch_token::String,\n    kwargs...,\n)\n\nRequired Keyword Arguments:\n\niss::String\nlaunch_token::String\n\nOptional Keyword Arguments:\n\nscope::String. Default value: launch.\nadditional_state::Union{Dict, Nothing}. Default value: nothing.\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch_part_three-Tuple{ProviderEHRLaunchConfig, AbstractDict}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch_part_three","text":"provider_ehr_launch_part_three(\n    config::ProviderEHRLaunchConfig,\n    location_queryparams::Dict;\n    kwargs...,\n)\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_ehr_launch_part_two-Tuple{ProviderEHRLaunchConfig, URIs.URI}","page":"API","title":"SMARTAppLaunch.provider_ehr_launch_part_two","text":"provider_ehr_launch_part_two(\n    config::ProviderEHRLaunchConfig,\n    authorize_uri_with_querystring_params::URIs.URI,\n)\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_standalone_step1-Tuple{ProviderStandaloneConfig}","page":"API","title":"SMARTAppLaunch.provider_standalone_step1","text":"provider_standalone_step1(config::ProviderStandaloneConfig; kwargs...)\n\nOptional Keyword Arguments:\n\nscope::AbstractString. Default value: \"launch\".\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_standalone_step2-Tuple{ProviderStandaloneConfig, AbstractString}","page":"API","title":"SMARTAppLaunch.provider_standalone_step2","text":"provider_standalone_step2(config::ProviderStandaloneConfig, uri_string::AbstractString)\n\n\n\n\n\n","category":"method"},{"location":"api/#SMARTAppLaunch.provider_standalone_step2-Tuple{ProviderStandaloneConfig, URIs.URI}","page":"API","title":"SMARTAppLaunch.provider_standalone_step2","text":"provider_standalone_step2(config::ProviderStandaloneConfig, uri::URIs.URI)\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = SMARTAppLaunch","category":"page"},{"location":"#SMARTAppLaunch","page":"Home","title":"SMARTAppLaunch","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package implements the SMART App Launch Framework for building SMART-on-FHIR applications.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The source code for this package is available in the GitHub repository.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The following tables show the mapping between Julia packages and standards/specifications:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Julia Package Standard/Specification Description\nFHIRClient.jl FHIR Fast Healthcare Interoperability Resources. Web standard for health interop.\nSMARTAppLaunch.jl SMART App Launch User-facing apps that connect to EHRs and health portals.\nSMARTBackendServices.jl SMART Backend Services Server-to-server FHIR connections.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"We currently do not implement the following; however, we plan to implement them in the future:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Standard/Specification Description\nFHIR Bulk Data Access (Flat FHIR) FHIR export API for large-scale data access.","category":"page"},{"location":"","page":"Home","title":"Home","text":"These descriptions are taken from the SMART on FHIR technical documentation.","category":"page"}]
}
