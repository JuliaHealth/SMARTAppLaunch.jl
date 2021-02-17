```@meta
CurrentModule = SMARTAppLaunch
```

# SMARTAppLaunch

This package implements the
[SMART App Launch Framework](https://www.hl7.org/fhir/smart-app-launch/)
for building SMART-on-FHIR applications.

The source code for this package is available in the
[GitHub repository](https://github.com/JuliaHealth/SMARTAppLaunch.jl).

The following tables show the mapping between Julia packages and
standards/specifications:

| Julia Package | Standard/Specification | Description |
| ------------- | ---------------------- | ----------- |
| [FHIRClient.jl](https://github.com/JuliaHealth/FHIRClient.jl) | [FHIR](https://hl7.org/fhir/) | Fast Healthcare Interoperability Resources. Web standard for health interop. |
| [SMARTAppLaunch.jl](https://github.com/JuliaHealth/SMARTAppLaunch.jl) | [SMART App Launch](https://hl7.org/fhir/smart-app-launch/) | User-facing apps that connect to EHRs and health portals. |

---

We currently do not implement the following; however, we plan to implement them
in the future:

| Standard/Specification | Description |
| ---------------------- | ----------- |
| [CDS Hooks](https://cds-hooks.hl7.org/) | Clinical Decision Support Hooks. Web standard for CDS in the EHR workflow. |
| [FHIR Bulk Data API](https://hl7.org/fhir/uv/bulkdata/) | FHIR export API for large-scale data access. |
| [SMART Backend Services](https://hl7.org/fhir/uv/bulkdata/authorization/) | Server-to-server FHIR connections. |

These descriptions are taken from
[https://docs.smarthealthit.org/](https://docs.smarthealthit.org/).
