# FuseCP Testing Environment

This page describes what is needed to run local builds, tests, and packaging
reliably.

## 1) Baseline Requirements

* Windows development environment
* .NET SDK (CI currently uses .NET 10)
* Visual Studio / MSBuild tooling (include Web Build Tools workload)
* Repository submodules initialized:
  * `git submodule update --init --recursive`

## 2) Required by Scenario

### Unit and solution tests

* `dotnet` CLI available
* Build/test solutions under `FuseCP/Sources`

### Legacy integration-style local test setup (`FuseCP/Tools/*.bat`)

* IIS + PowerShell `WebAdministration` module
* Local SQL Server instance reachable as `(local)\SQLExpress`
* SQL command-line tooling (repo-bundled at `tools/sqlcmd/SQLCMD.EXE`)
* Microsoft ODBC Driver for SQL Server (required by `SQLCMD.EXE`)
* Run terminal as Administrator for setup tasks (IIS site creation/scripts)

Note: `WebAdministration` is a Windows PowerShell module; the checker validates
it through `powershell.exe` even when invoked from `pwsh`.

Note: `Administrator shell` is reported as warning-only during checks; it is
required when executing setup actions that modify IIS/system configuration.

### Full deploy/package build

* WiX tooling (repo-bundled at `tools/WIX`)
* Web Deploy tooling (repo-bundled at `tools/WebDeploy/msdeploy.exe`)
* 7-Zip tooling (repo-bundled at `tools/7-Zip/7z.exe`)
* SQL command-line tooling (repo-bundled at `tools/sqlcmd/SQLCMD.EXE`)
* MSBuild web targets (`Microsoft.WebApplication.targets`) via Visual Studio
  Web Build Tools workload
* Full Visual Studio + Installer Projects extension only if building legacy
  `.vdproj` MSI output

### Linux package generation (optional but enabled in release build defaults)

* WSL2
* Linux distro with `rpmbuild`

If WSL/rpm is not available locally, you can disable Linux package creation by
setting `BuildLinuxInstallPackages=false` in your build invocation.

## 3) Quick Verification Commands

From repo root:

* `dotnet --info`
* `cd FuseCP/Sources`
* `dotnet build FuseCP.Server.sln`
* `dotnet build FuseCP.EnterpriseServer.sln`
* `dotnet build FuseCP.Tests.sln`
* `dotnet test FuseCP.Tests.sln --configuration Release --no-build -v n`

From `FuseCP` folder for full build/package flow:

* `build-release.bat`

## 4) Environment Check Script

Run the helper script to check common prerequisites:

* `pwsh -File FuseCP/Tools/check-test-environment.ps1`
* `pwsh -File FuseCP/Tools/check-test-environment.ps1 -Profile Integration`
* `pwsh -File FuseCP/Tools/check-test-environment.ps1 -Profile Package`
* `pwsh -File FuseCP/Tools/check-test-environment.ps1 -Profile Full`
* `pwsh -File FuseCP/Tools/check-test-environment.ps1 -Profile Package -RequireLegacyMsi`

Profiles:

* `Unit`: dotnet + msbuild
* `Integration`: Unit + IIS/WebAdministration + SQLExpress reachability
* `Package`: Unit + bundled WiX/WebDeploy/7-Zip/sqlcmd + WSL check
* `Full`: Integration + Package

`-RequireLegacyMsi` adds a hard check for full Visual Studio (`devenv.com`) for
legacy `.vdproj` MSI packaging.

## 5) Streamlined Local Validation

Use a single command wrapper for local validation:

* `pwsh -File FuseCP/Tools/run-local-validation.ps1`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -Scope Portal,Enterprise`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -Scope Server -IncludeTests`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -JsonOutputPath artifacts/validation/summary.json`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -DisableNuGetAudit`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -SkipIfNoChanges`
* `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -ScopeMapPath FuseCP/Tools/validation-scope-map.json`

Notes:

* Default scope is `Shared`, which runs orchestrated `build.xml`.
* `-ChangedOnly` derives scope from changed files (via git) and selects the
  smallest safe validation set.
* `-JsonOutputPath` writes a machine-readable run summary (status, scope,
  changed files, and executed commands).
* `-DisableNuGetAudit` reduces noisy `NU190x` audit warnings for local loops
  without changing project files.
* `-SkipIfNoChanges` exits successfully without building when `-ChangedOnly`
  finds no touched files.
* `-ScopeMapPath` optionally extends scope routing from a JSON file.
  See `FuseCP/Tools/validation-scope-map.example.json` for schema and examples.
* Add `-UseOrchestratedBuild` to force ordered build for any scope.
* For broad changes, prefer the orchestrated path.

## 6) Bootstrap Script (Install + Check)

Use this when setting up a fresh machine.

Check-only (no installs):

* `pwsh -File FuseCP/Tools/bootstrap-test-environment.ps1`
* `pwsh -File FuseCP/Tools/bootstrap-test-environment.ps1 -RunAllProfiles`

Install + check (run elevated PowerShell):

* `pwsh -File FuseCP/Tools/bootstrap-test-environment.ps1 -Install -RunAllProfiles`
* `pwsh -File FuseCP/Tools/bootstrap-test-environment.ps1 -Install -RunAllProfiles -InstallSqlExpress`
* `pwsh -File FuseCP/Tools/bootstrap-test-environment.ps1 -Install -RunAllProfiles -InstallSqlExpress -InstallIIS`

Optional flags:

* `-SkipDotNet` skips `.NET SDK` installation
* `-SkipBuildTools` skips `Visual Studio Build Tools` installation
* `-SkipSqlOdbc` skips `Microsoft ODBC Driver for SQL Server`
* `-InstallSqlExpress` includes local SQL Server 2022 Express install
* `-InstallIIS` enables IIS Web Server role + IIS Management Scripting Tools
* `-SqlExpressOverride` sets custom SQL Express installer arguments
* `-Profiles Unit,Package` selects specific profiles

Notes:

* SQL Server Express installation can invoke an interactive installer and may be
  cancelled if the session cannot present installer prompts.
* Bootstrap now retries SQL Express installation with a direct ENU installer
  fallback if winget returns language error `1009`.
* Bootstrap also repairs/re-caches `msodbcsql.msi` before SQL Express install to
  avoid MSI source error `1706`.
* You can still customize arguments with `-SqlExpressOverride "/ENU /Q /IACCEPTSQLSERVERLICENSETERMS"`.
* Integration profile expects instance `(local)\SQLExpress` to be reachable.
* If orchestrated build fails with missing
  `Microsoft.WebApplication.targets`, modify Build Tools installation to include
  `Microsoft.VisualStudio.Workload.WebBuildTools`.
* If you are on Build Tools only, legacy MSI packaging is skipped automatically.
  To force MSI build, use `/p:BuildInstallerMsi=true` and ensure `devenv.com`
  plus Installer Projects are installed.
