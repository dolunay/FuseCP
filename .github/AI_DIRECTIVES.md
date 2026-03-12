# AI Directives for FuseCP

This document defines minimum standards for AI-assisted work in the FuseCP
repository. It applies to maintainers, contributors, and any automation
submitting content.

## 1. Accountability

All AI-assisted output must be reviewed and approved by a human contributor
before merge. The person opening the PR is responsible for correctness,
security, licensing, and production impact.

## 2. Transparency

If a change is materially AI-assisted, disclose it in the PR description with:

* Which AI tool(s) were used
* Which parts were generated, summarized, or transformed
* What manual validation was performed

## 3. Security and Privacy

Do not share secrets or sensitive operational data with third-party AI systems,
including:

* Credentials, keys, connection strings, and tokens
* Customer or tenant data
* Internal infrastructure details not required for the task

Use sanitized examples whenever possible.

## 4. Code Quality and Testing

AI-generated changes must meet the same quality standard as human-authored code:

* Compile and pass relevant tests
* Prefer repository build orchestrators (`build.xml`, `build-*.bat`, `deploy-*.bat`) over independently building isolated solution files when validating broad changes
* Prefer streamlined local validation entrypoint `FuseCP/Tools/run-local-validation.ps1` for repeatable local checks
* Use `run-local-validation.ps1 -ChangedOnly` for fast local loops when scope can be derived from changed files
* Prefer `-JsonOutputPath` for machine-readable validation evidence in PR workflows
* Use `-DisableNuGetAudit` only for local iteration noise reduction; do not treat it as a security fix
* Use `-SkipIfNoChanges` with `-ChangedOnly` when you want no-op runs to complete without full builds
* Use `-ScopeMapPath` to extend path-to-scope routing without editing the script
* Before adding/removing/changing any `ProjectReference`, check all relevant solution files under `FuseCP/Sources/*.sln` (at minimum Portal/Enterprise/Server paths) and validate the affected solution builds to avoid cross-solution breakage
* Keep `FuseCP.sln` synchronized with `FuseCP/Sources/FuseCP.WebPortal.sln`, `FuseCP/Sources/FuseCP.EnterpriseServer.sln`, and `FuseCP/Sources/FuseCP.Server.sln` for project add/remove/rename changes when those projects are part of build scope
* Treat project/solution graph updates as a required validation gate: project file changes (`*.csproj`, `*.vbproj`, `*.vcxproj`, `*.shproj`, `*.sln`) must include explicit solution-sync verification notes in PR validation output
* Treat FuseCP as a migrated codebase: if implementation intent is unclear, consult project origins in branch `origin/SolidCPv1` (typically under `SolidCP/Sources/...`) to recover legacy behavior and architecture context before changing contracts or build wiring
* For package/dependency/CVE updates, require compatibility validation across affected target frameworks (`net48`, `net10.0`, `netstandard2.0` where applicable) and affected solution scopes (Portal/Enterprise/Server)
* For package/dependency/CVE updates, update related validation scripts/docs/PR notes whenever requirements, tooling assumptions, or recommended commands change
* Follow existing project patterns and style
* Include documentation updates when behavior changes
* Avoid introducing unused dependencies or broad refactors unrelated to the task
* If changes touch legacy installer `.vdproj` packaging, explicitly validate legacy MSI prerequisites (`check-test-environment.ps1 -Profile Package -RequireLegacyMsi`)
* When prerequisite checks fail, report each missing dependency explicitly (for example: SQLExpress instance, WSL distro, WiX MSBuild targets) and provide the concrete install/enable command used for local remediation
* For local integration tooling that starts background services (IIS websites, SQLExpress, WSL), prefer documented start/stop scripts so contributors can reduce idle system usage
* For first-time environment setup guidance, prefer the bootstrap installer workflow (`FuseCP/Tools/bootstrap-test-environment.ps1`) with explicit flags needed for the contributor scenario (integration, packaging, legacy installer)
* When asked to create an upstream PR, use `FuseCP/Tools/Create-Upstream-PR.ps1` so `PR_DRAFT.md` is cleared only after successful PR creation
* For GitHub Actions artifact publishing, never use raw commit/PR text directly as `actions/upload-artifact` name; sanitize dynamic names to remove/replace invalid characters (`"`, `:`, `<`, `>`, `|`, `*`, `?`, `\r`, `\n`, `\\`, `/`) before upload

## 5. UI Styling — LESS/CSS Workflow

The portal theme is authored in LESS source files, not directly in the compiled CSS output.

* **Source files** (edit these):
  * `FuseCP/Sources/FuseCP.WebPortal/App_Themes/Default/Styles/main.less` — all main theme rules
  * `FuseCP/Sources/FuseCP.WebPortal/App_Themes/Default/Styles/Menus.less` — navigation and menu rules
  * `FuseCP/Sources/FuseCP.WebPortal/App_Themes/Default/Styles/defaultVariables.less` — shared LESS variables
  * `FuseCP/Sources/FuseCP.WebPortal/App_Themes/Default/Styles/defaultTheme.less` — root entry point that imports the above
* **Compiled output** (never edit directly): `main.css`
* **Recompile command** (run from the Styles directory):
  ```
  cd FuseCP/Sources/FuseCP.WebPortal/App_Themes/Default/Styles
  npm run build:css
  ```
* Every CSS change must start in the relevant `.less` source file. Direct edits to `main.css` will be overwritten on the next recompile and must not be committed.
* When recompiling, verify that the output contains your expected rule before committing both files together.

## 6. Database Schema Changes — Entity Framework Workflow

FuseCP uses Entity Framework (EF Core 8 on .NET 10, EF 6 on .NET Framework) for database access. Schema changes must follow this workflow:

### Updating the schema

1. Edit Entity classes in `FuseCP/Sources/FuseCP.EnterpriseServer.Data/Entities/` (e.g. add/remove properties).
2. Update the corresponding Fluent API configuration in `FuseCP/Sources/FuseCP.EnterpriseServer.Data/Configuration/` if needed for cross-DB type mapping.
3. Create a migration:
   ```
   cd FuseCP/Sources/FuseCP.EnterpriseServer.Data
   MigrationAdd.bat   # or run individual lines for a single DB flavor
   ```
4. Verify the generated migration files under `Migrations/` look correct.
5. For raw SQL-based changes (legacy path via `FuseCP/Database/update_db.sql`), also apply `update_db.sql` to a fresh DB, re-scaffold, diff the `Entities/Sources/` output against `Entities/`, and manually port changes to the Entity and Configuration classes before raising a migration.

### Rules

* Never modify `main.css` directly — same discipline applies: never alter auto-generated EF model snapshot files by hand; let `dotnet ef` maintain them.
* EF migrations are executed with EF Core only (NET 10); the installer applies SQL scripts for .NET Framework environments.
* Squash development-only intermediate migrations into one before a release using the `MigrationRemove.bat` / snapshot-revert approach documented in `FuseCP/Sources/FuseCP.EnterpriseServer.Data/README.md`.
* Always update `FuseCP/Database/update_db.sql` when a schema migration is added so the legacy SQL path stays in sync.
* Reference: `FuseCP/Sources/FuseCP.EnterpriseServer.Data/README.md` for scaffolding, connection strings, and multi-DB type-mapping patterns.

## 7. Legal and Licensing

Contributions must comply with repository licensing and third-party license
requirements. Do not submit generated code or content if you cannot verify legal
use or attribution obligations.

Copyright header policy:

* For source/project files that use copyright headers/metadata, enforce exact text format: `Copyright (C) 2026 FuseCP`
* Keep the year current when annual updates occur, including generator inputs and generated outputs (notably `FuseCP/build.xml`, `FuseCP/Sources/VersionInfo.cs`, `FuseCP/Sources/VersionInfo.vb`, and installer `VersionInfo.cs` files)

## 8. Disallowed Uses

AI tools must not be used to:

* Generate abusive, discriminatory, or harassing project content
* Fabricate test results, benchmarks, incident data, or release notes
* Bypass review, approval, or security controls

## 9. Maintainer Enforcement

Maintainers may request edits, additional testing, provenance details, or reject
changes that do not comply with these directives.

These directives supplement (and do not replace) the project Code of Conduct.