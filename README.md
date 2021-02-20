# SMARTAppLaunch

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaHealth.github.io/SMARTAppLaunch.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaHealth.github.io/SMARTAppLaunch.jl/dev)
[![Build Status](https://github.com/JuliaHealth/SMARTAppLaunch.jl/workflows/CI/badge.svg)](https://github.com/JuliaHealth/SMARTAppLaunch.jl/actions)
[![Coverage](https://codecov.io/gh/JuliaHealth/SMARTAppLaunch.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaHealth/SMARTAppLaunch.jl)

This package implements the
[SMART App Launch Framework](https://www.hl7.org/fhir/smart-app-launch/)
for building SMART-on-FHIR applications.

Please see the
[documentation](https://juliahealth.org/SMARTAppLaunch.jl/stable/).

The following tables show the mapping between Julia packages and
standards/specifications:

| Julia Package | Standard/Specification | Description |
| ------------- | ---------------------- | ----------- |
| [FHIRClient.jl](https://github.com/JuliaHealth/FHIRClient.jl) | [FHIR](https://hl7.org/fhir/) | Fast Healthcare Interoperability Resources. Web standard for health interop. |
| [SMARTAppLaunch.jl](https://github.com/JuliaHealth/SMARTAppLaunch.jl) | [SMART App Launch](https://hl7.org/fhir/smart-app-launch/) | User-facing apps that connect to EHRs and health portals. |
| [SMARTBackendServices.jl](https://github.com/JuliaHealth/SMARTBackendServices.jl) | [SMART Backend Services](https://hl7.org/fhir/uv/bulkdata/authorization/) | Server-to-server FHIR connections. |

---

We currently do not implement the following; however, we plan to implement them
in the future:

| Standard/Specification | Description |
| ---------------------- | ----------- |
| [CDS Hooks](https://cds-hooks.hl7.org/) | Clinical Decision Support Hooks. Web standard for CDS in the EHR workflow. |
| [FHIR Bulk Data Access (Flat FHIR)](https://hl7.org/fhir/uv/bulkdata/) | FHIR export API for large-scale data access. |

These descriptions are taken from the
[SMART on FHIR technical documentation](https://docs.smarthealthit.org/).
