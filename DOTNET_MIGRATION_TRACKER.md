# FuseCP .NET Migration Tracker

## Goals

- Migrate per-project in a controlled order: WebPortal + dependencies first, then EnterpriseServer + dependencies.
- Reach a cross-platform control-plane on .NET 10 while retaining Windows-only provider execution where required.
- Keep migration risk low with staged net10-only cutover per slice; do not add new net48 compatibility paths.
- Preserve existing runtime functionality during migration; remove or replace legacy pieces only when equivalent behavior is validated or explicitly approved.

## Baseline (2026-03-12)

- Total projects under `FuseCP/Sources`: `145`
- Projects referencing `net48`: `98`
- Projects referencing `net10.0`: `16`

## Phase Plan

### Phase 0: Foundation (shared by both tracks)

- [ ] Finalize migration policy for target frameworks and package baselines.
- [ ] Create CI/build matrix for `net10.0` migration lanes and legacy-risk reporting.
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
- [x] Open WebPortal task 2: audit/replace remaining net48-only package paths.
- [x] Confirm net10-forward policy: no new net48 compatibility additions in migration changes.

## WebPortal Track Package Baseline (2026-03-12)

Report source:
- `artifacts/dotnet-migration-webportal-report.txt`

Summary:
- `FuseCP.WebPortal` dual-targets `net10.0;net48` with conditional package sets for WebForms compatibility on net10 and legacy optimization/toolkit stack on net48.
- `CPCC` dual-targets and still has split package behavior (`EstrellasDeEsperanza.WebFormsForCore.Web` on non-net48).
- `FuseCP.EnterpriseServer.Base` and `FuseCP.Providers.Base` remain `netstandard2.0` and are shared dependencies.
- `FuseCP.Web.Services` and `FuseCP.Web.Clients` already contain net10-specific CoreWCF/ServiceModel package paths.

Direction update (2026-03-13):
- Migration execution is now net10-forward: touched projects should remove dead net48 compatibility branches instead of preserving dual-target fallback paths unless explicitly required for an isolated legacy lane.

Immediate actions:
- [x] Normalize WebFormsForCore package versions across active WebPortal projects to `1.4.6`.
- [ ] Review `Kestrel.Core 2.3.6` in `FuseCP.Web.Services` net10 path for required upgrade/replacement (future structural change in CoreWCF path; deferred for now).
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

### 2026-03-13

- Synced local `main` to `upstream/main` (`2eacb283f`) and resumed Phase 3/TASK-016 from tracker notes.
- Ran focused build validation for `FuseCP/Sources/FuseCP.Providers.HostedSolution/FuseCP.Providers.HostedSolution.csproj` on `net10.0-windows`.
- Confirmed blocker: generated CRM proxy (`CRMProxy.cs`) depends on legacy `System.Web.Services.Protocols` APIs (`System.Web.Services.*` namespace), which are not directly available through supported modern package references for .NET 10.
- Result: HostedSolution remains blocked on CRM SOAP proxy modernization strategy (regenerate/replace proxy stack or isolate legacy path) before TASK-016 can be marked complete.
- Implemented CRM decommission baseline in data seeds by removing CRM providers, quotas, and resource groups from `FuseCP.EnterpriseServer.Data` configuration seeds (including `Configuration/Sources` mirrors).
- Kept CRM retirement/removal logic in `FuseCP/Database/update_db.sql` for legacy upgrades.
- Removed remaining CRM seed references from install scripts and migration install mirrors (`FuseCP/Database/install.*.sql`, `FuseCP/Sources/FuseCP.EnterpriseServer.Data/Migrations/*/install*.sql`) so fresh installs no longer provision CRM groups/providers/quotas/report-parameter seeds.
- Created WebPortal dependency audit artifact at `artifacts/dotnet-migration-webportal-net48-audit.txt` and identified net48-only dead reference groups in net10-only projects.
- Removed dead net48-only reference blocks from `FuseCP.Web.Services`, `FuseCP.Web.Clients`, and `FuseCP.EnterpriseServer.Client` project files; validated net10 builds for all three projects.
- `FuseCP.Web.Services` still restores transitive `Microsoft.AspNetCore.Server.Kestrel.Core 2.3.0` (NU1904) via dependency graph and remains a targeted dependency-risk follow-up.
- Confirmed root cause in `obj/project.assets.json`: `CoreWCF.NetTcp`/`CoreWCF.NetFramingBase` currently pull ASP.NET Core `2.3.0` packages (including `Microsoft.AspNetCore.Server.Kestrel.Core`).
- Added temporary project-level `NU1904` suppression in `FuseCP.Web.Services.csproj` to keep net10 migration validation signal clean while CoreWCF dependency strategy is resolved.
- Confirmed from NuGet package search that current official `CoreWCF.*` line is `1.8.0`; no newer version currently available to remove the transitive ASP.NET Core `2.3.0` chain.
- Agreed follow-up: keep current workaround and revisit with structural change when CoreWCF dependency options improve.
- Removed dead net48/netstandard conditional branches and direct `Microsoft.AspNetCore.Server.Kestrel.Core` package pin from `FuseCP.EnterpriseServer.Code.csproj`; validated `net10.0` build of `FuseCP.EnterpriseServer.Code` and `FuseCP.WebPortal`.
- Simplified `FuseCP.WebPortal.csproj` for net10-only execution by removing always-true `!= net48` conditions and unreachable net48 fallback copy path; validated `dotnet build ... -f net10.0` succeeds.

## Definition of Done (Per Project)

- [ ] Builds successfully for intended target frameworks.
- [ ] No unsupported API usage for target runtime.
- [ ] Critical tests pass on target runtime.
- [ ] Deployment/packaging path updated and validated.
- [ ] Tracker updated with evidence and remaining risks.
