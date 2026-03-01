# Description

Adds governance, contributor workflow, and local validation streamlining updates with safe build/test optimizations.

Key outcomes:

- Introduces AI governance and contributor guidance (`AI_DIRECTIVES`, `copilot-instructions`, `CONTRIBUTING`, testing environment docs).
- Keeps ordered/orchestrated build as integration-safe default and documents this clearly.
- Adds/updates local prerequisite and validation scripts (`check-test-environment.ps1`, `bootstrap-test-environment.ps1`, `run-local-validation.ps1`).
- Hardens legacy MSI handling in `build.xml` with explicit opt-in gating and clear warnings.
- Adds low-risk local iteration optimizations:
  - `-ChangedOnly`
  - `-JsonOutputPath`
  - `-DisableNuGetAudit`
  - `-SkipIfNoChanges`
  - `-ScopeMapPath` + `validation-scope-map.example.json`

Fixes # (issue)

# Module Scope

- [x] Portal (GUI / web pages)
- [x] Enterprise (database / business logic)
- [x] Server (host execution / providers)

# Validation Commands Run

- `pwsh -File FuseCP/Tools/run-local-validation.ps1 -ChangedOnly -DisableNuGetAudit -JsonOutputPath artifacts/validation/summary-changedonly.json`
- `pwsh -File FuseCP/Tools/run-local-validation.ps1 -Scope Enterprise -DisableNuGetAudit -JsonOutputPath artifacts/validation/summary-enterprise.json`
- `pwsh -File FuseCP/Tools/run-local-validation.ps1 -Scope Enterprise -DisableNuGetAudit -ScopeMapPath FuseCP/Tools/validation-scope-map.example.json -JsonOutputPath artifacts/validation/summary-enterprise-opt.json`

# How Has This Been Tested?

- [x] Built targeted solution scope (`Enterprise`) using streamlined script path.
- [x] Ran changed-only orchestrated path and confirmed successful completion.
- [x] Verified JSON summary output includes resolved scope and full executed commands.
- [x] Verified no-change optimization and scope-map options are documented and script-parsed successfully.
- [x] Built code to ensure it has no errors in touched script files.

# Risk Notes

- Main risk is process/tooling behavior change (not production runtime behavior).
- `build.xml` MSI behavior remains backward compatible: default auto-skip when `devenv.com` is unavailable; explicit `/p:BuildInstallerMsi=true` still supported.
- New script options are additive and opt-in.

# AI Disclosure

AI tools were used to draft documentation and automation scripts. Manual validation was performed via local script execution and output inspection as listed above.

# Checklist

- [x] My code follows the style guidelines of this project
- [x] I have performed a self-review of my own code
- [x] I have commented my code, particularly in hard-to-understand areas
- [x] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [x] Any dependent changes have been merged and published in downstream modules
- [x] I have reviewed and followed the Code of Conduct and AI directives
- [x] If AI tools were materially used, I disclosed usage and validation in this PR
- [x] My branch naming and commit messages follow CONTRIBUTING conventions
