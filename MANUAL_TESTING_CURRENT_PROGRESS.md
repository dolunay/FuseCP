# Manual Testing Checklist - Current Progress (2026-03-01)

## Baseline

- Branch: `shared/validation-streamlining`
- Parent repo HEAD: `03d9a7d75`
- noVNC submodule pointer updated by: `03d9a7d75`
- noVNC submodule commit (FuseCP-noVNC): `533c66b`

## Commits Included In This Test Window

1. `fa2ede996` - TLS legacy mode + Kestrel CVE pin
2. `7a45f4764` - `Microsoft.Build.Tasks.Core` pin for NU1903 remediation (core projects)
3. `03d9a7d75` - noVNC submodule pointer update for NU1903 remediation

## Files Changed (Functional Scope)

- `FuseCP/Sources/FuseCP.EnterpriseServer.Code/Common/MailHelper.cs`
- `FuseCP/Sources/FuseCP.WebPortal/Code/PortalUtils.cs`
- `FuseCP/Sources/FuseCP.Web.Services/FuseCP.Web.Services.csproj`
- `FuseCP/Sources/CPCC/CPCC.csproj`
- `FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj`
- `FuseCP/Sources/FuseCP.WebPortal/DesktopModules/FuseCP/FuseCP.Portal.Modules.csproj`
- `FuseCP/Lib/novnc-fusecp` (submodule pointer)

## Objective Of Manual Test Pass

Validate that the current branch state:

- Removes critical/high package vulnerabilities addressed in recent commits.
- Preserves expected behavior in portal, enterprise-server, and noVNC paths.
- Introduces no obvious runtime regressions in TLS-dependent flows.

## Pre-Test Setup

From repo root (`C:\FuseCP\FuseCP`):

```powershell
git submodule update --init --recursive
```

Optional clean build artifacts if needed:

```powershell
# Use only if stale binaries/locks are suspected
git clean -xdf -e .vs -e packages
```

## 1) Security Package Verification (Must Pass)

Run:

```powershell
dotnet list ./FuseCP/Sources/CPCC/CPCC.csproj package --vulnerable --include-transitive
dotnet list ./FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj package --vulnerable --include-transitive
dotnet list ./FuseCP/Lib/novnc-fusecp/FuseCP.Providers.Virtualization.NoVNC.csproj package --vulnerable --include-transitive
```

Expected:

- No vulnerable packages reported for these three project checks.
- Existing migration compatibility warnings (for example `NU1701`) may still appear.

## 2) Compile Validation (Project-Level)

Run:

```powershell
dotnet build ./FuseCP/Sources/CPCC/CPCC.csproj -c Release /nologo
dotnet build ./FuseCP/Sources/FuseCP.WebPortal/FuseCP.WebPortal.csproj -c Release /nologo
dotnet build ./FuseCP/Lib/novnc-fusecp/FuseCP.Providers.Virtualization.NoVNC.csproj -c Release /nologo
```

Expected:

- Builds complete successfully.
- Warnings may remain from legacy migration scope.
- If file-lock errors appear (MSB3021/MSB3027/MSB3061), close running hosts/processes and re-run.

## 3) TLS Behavior Smoke Test (Manual)

### 3.1 Portal/Enterprise flows using mail/TLS

Focus areas touched by TLS changes:

- `MailHelper` path in EnterpriseServer code
- `PortalUtils` path in WebPortal code

Manual checks:

1. Trigger mail-related UI/workflow that uses existing SMTP configuration.
2. Validate operation succeeds with same credentials/config previously known-good.
3. Confirm no new handshake/protocol errors are surfaced in logs/UI.

Expected:

- No regression in successful mail operations.
- No immediate TLS protocol negotiation failures introduced by the update.

## 4) Web.Services Dependency Override Smoke

Change included explicit Kestrel.Core pin in:

- `FuseCP/Sources/FuseCP.Web.Services/FuseCP.Web.Services.csproj`

Manual checks:

1. Start/host the service in your normal local method.
2. Execute one or two known-good API/service calls.
3. Verify startup and request handling are normal.

Expected:

- Service starts and handles basic requests without new errors.

## 5) noVNC Integration Smoke

Because noVNC is in a submodule and pointer changed, verify:

1. Submodule commit is present locally:

```powershell
cd .\FuseCP\Lib\novnc-fusecp
git rev-parse --short HEAD
```

Expected: `533c66b` (or descendant containing same package pin).

2. Build noVNC project (already in section 2).
3. Perform a basic portal path smoke where noVNC assets are expected/served.

Expected:

- noVNC-related page/assets resolve as before.

## Known Non-Blocking Items For This Pass

- Existing migration-era warnings (`NU1701`, selected analyzer warnings) are expected and not newly introduced in this pass.
- Environment file locks from antivirus or running dotnet hosts can cause transient copy failures.

## Suggested Evidence To Record

- Terminal output snippets for each of the three vulnerability checks.
- Terminal output summary for three build commands.
- Brief notes for each manual smoke section (pass/fail + any observed error).
- If failure occurs, include exact command, timestamp, and first error line.

## Fast Revert Pointer (If Needed)

If you need to return to pre-remediation baseline for comparison:

- Before TLS/CVE pin: `e6e315233`
- Before NU1903 pin set: `fa2ede996`

(Do not reset shared branch unless coordinated.)
