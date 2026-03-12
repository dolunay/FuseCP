# FuseCP .NET Migration Tracker

## Goals

- Migrate per-project in a controlled order: WebPortal + dependencies first, then EnterpriseServer + dependencies.
- Reach a cross-platform control-plane on .NET 10 while retaining Windows-only provider execution where required.
- Keep compatibility and reduce risk with staged dual-targeting until each slice is validated.

## Baseline (2026-03-12)

- Total projects under `FuseCP/Sources`: `145`
- Projects referencing `net48`: `98`
- Projects referencing `net10.0`: `16`

## Phase Plan

### Phase 0: Foundation (shared by both tracks)

- [ ] Finalize migration policy for target frameworks and package baselines.
- [ ] Create CI matrix for `net48` and `net10.0` lanes.
- [ ] Add project-level migration checklist template.
- [ ] Identify and isolate Windows-only APIs in shared code.

### Phase 1: WebPortal Track

Host project:
- `FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj`

Direct project references:
- `FuseCP/Sources/CPCC/CPCC.csproj`
- `FuseCP/Sources/FuseCP.EnterpriseServer.Base/FuseCP.EnterpriseServer.Base.csproj`
- `FuseCP/Sources/FuseCP.EnterpriseServer/WebServices/FuseCP.Build/FuseCP.EnterpriseServer.Client.csproj`
- `FuseCP/Sources/FuseCP.Providers.Base/FuseCP.Providers.Base.csproj`
- `FuseCP/Sources/FuseCP.Web.Clients/FuseCP.Web.Clients.csproj`
- `FuseCP/Sources/FuseCP.Web.Services/FuseCP.Web.Services.csproj`

Work items:
- [ ] Lock WebPortal dependency versions for deterministic migration.
- [ ] Validate WebForms compatibility surfaces on `net10.0` for core login/navigation/pages.
- [ ] Remove/replace remaining `System.Web` assumptions in WebPortal dependency graph.
- [ ] Add smoke tests for key user journeys (auth, package pages, service pages).

### Phase 2: EnterpriseServer Track

Host project:
- `FuseCP/Sources/FuseCP.EnterpriseServer/FuseCP.EnterpriseServer.csproj`

Direct project references:
- `FuseCP/Sources/FuseCP.Build/FuseCP.Build.csproj`
- `FuseCP/Sources/FuseCP.EnterpriseServer.Base/FuseCP.EnterpriseServer.Base.csproj`
- `FuseCP/Sources/FuseCP.EnterpriseServer.Code/FuseCP.EnterpriseServer.Code.csproj`
- `FuseCP/Sources/FuseCP.EnterpriseServer.Data/FuseCP.EnterpriseServer.Data.csproj`
- `FuseCP/Sources/FuseCP.Providers.Base/FuseCP.Providers.Base.csproj`
- `FuseCP/Sources/FuseCP.Server/WebServices/FuseCP.Build/FuseCP.Server.Client.csproj`
- `FuseCP/Sources/FuseCP.Web.Clients/FuseCP.Web.Clients.csproj`
- `FuseCP/Sources/FuseCP.Web.Services/FuseCP.Web.Services.csproj`

Work items:
- [ ] Validate net10 runtime behavior for API/service endpoints.
- [ ] Separate portable provider contracts from Windows-only provider implementations.
- [ ] Ensure DB/migration pipeline parity on net10.
- [ ] Add provisioning API regression tests per service family.

## Current Sprint (Kickoff)

- [x] Create long-term migration tracker.
- [x] Capture baseline inventory and host dependency lists.
- [x] Start WebPortal Track task 1: lock dependency versions and produce a package delta report.
- [ ] Define and apply per-project migration checklist.
- [ ] Open WebPortal task 2: audit/replace remaining net48-only package paths.

## WebPortal Track Package Baseline (2026-03-12)

Report source:
- `artifacts/dotnet-migration-webportal-report.txt`

Summary:
- `FuseCP.WebPortal` dual-targets `net10.0;net48` with conditional package sets for WebForms compatibility on net10 and legacy optimization/toolkit stack on net48.
- `CPCC` dual-targets and still has split package behavior (`EstrellasDeEsperanza.WebFormsForCore.Web` on non-net48).
- `FuseCP.EnterpriseServer.Base` and `FuseCP.Providers.Base` remain `netstandard2.0` and are shared dependencies.
- `FuseCP.Web.Services` and `FuseCP.Web.Clients` already contain net10-specific CoreWCF/ServiceModel package paths.

Immediate actions:
- [ ] Normalize WebFormsForCore package versions across `FuseCP.WebPortal` and `CPCC`.
- [ ] Review `Kestrel.Core 2.3.6` in `FuseCP.Web.Services` net10 path for required upgrade/replacement.
- [x] Build WebPortal dependency chain on net10 and capture first failure list.
- [x] Resolve first warning backlog from WebPortal net10 build.

First net10 build output highlights:
- `dotnet build FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj -c Debug -f net10.0` succeeded.
- Warning backlog to resolve next:
	- `NU1902` vulnerability warning for `MimeKit` in WebPortal path.
	- `MSB3568` duplicate resource name `ResourceGroup.MsSQL2025` in `App_GlobalResources/FuseCP_SharedResources.ascx.resx`.

Remediation result (2026-03-12):
- Updated `MailKit`/`MimeKit` to `4.15.1` in:
	- `FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj`
	- `FuseCP/Sources/FuseCP.EnterpriseServer.Code/FuseCP.EnterpriseServer.Code.csproj`
	- `FuseCP/Sources/Tools/FuseCP.Import.Enterprise/FuseCP.Import.Enterprise.csproj`
- Removed duplicate `ResourceGroup.MsSQL2025` entry from:
	- `FuseCP/Sources/FuseCP.WebPortal/App_GlobalResources/FuseCP_SharedResources.ascx.resx`
- Rebuild validation: `dotnet build FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj -c Debug -f net10.0` succeeded with zero warnings.

## Session Log

### 2026-03-12

- Established phased execution model: WebPortal track first, EnterpriseServer track second.
- Captured baseline: 145 projects, 98 with net48, 16 with net10.
- Recorded direct project dependencies for both host projects.
- Installed `ripgrep` via Chocolatey for faster migration/search workflow.
- Generated WebPortal track package baseline report at `artifacts/dotnet-migration-webportal-report.txt`.
- Ran first WebPortal net10 build successfully and captured warning backlog.
- Resolved WebPortal warning backlog and validated clean net10 build.

## Definition of Done (Per Project)

- [ ] Builds successfully for intended target frameworks.
- [ ] No unsupported API usage for target runtime.
- [ ] Critical tests pass on target runtime.
- [ ] Deployment/packaging path updated and validated.
- [ ] Tracker updated with evidence and remaining risks.
