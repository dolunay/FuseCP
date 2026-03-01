# FuseCP

[![Build](https://github.com/FuseCP/FuseCP/actions/workflows/deploy-release.yaml/badge.svg)](https://github.com/FuseCP/FuseCP/actions/workflows/deploy-release.yaml)
[![Test](https://github.com/FuseCP/FuseCP/actions/workflows/test-release.yaml/badge.svg)](https://github.com/FuseCP/FuseCP/actions/workflows/test-release.yaml)

FuseCP is a complete management portal for Cloud Computing Companies and IT Providers to automate the provisioning of a full suite of Multi-Tenant services on servers. The powerful, flexible and fully open source FuseCP platform gives users simple point-and-click control over Server applications including IIS 10, Microsoft SQL Server 2022, MySQL, MariaDB, Active Directory, Microsoft Exchange 2019, Microsoft Sharepoint 2019, Microsoft RemoteApp/ RDS, Hyper-V and Proxmox Deployments.

To download the latest Binaries or find more information visit our website at: 

[fusecp.com](https://fusecp.com)

## Build Guidance

For reliable local validation, prefer orchestrated repository build entrypoints
in `FuseCP/` (`build-debug.bat`, `build-release.bat`, `build.xml`) because
independent solution builds under `FuseCP/Sources` can be order-dependent.

For faster repeatable local checks, use:

* `pwsh -File FuseCP/Tools/run-local-validation.ps1`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -JsonOutputPath artifacts/validation/summary.json`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -SkipIfNoChanges`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -ScopeMapPath FuseCP/Tools/validation-scope-map.example.json`

## Governance

* [Code of Conduct](CODE_OF_CONDUCT.md)
* [AI Directives](.github/AI_DIRECTIVES.md)
* [Contributing Guide](CONTRIBUTING.md)
* [Testing Environment](TESTING_ENVIRONMENT.md)
* [Process Streamlining Outline](PROCESS_STREAMLINING.md)
