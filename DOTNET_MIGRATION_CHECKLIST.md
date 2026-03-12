# .NET Migration Per-Project Checklist

Use this checklist for each project being migrated or hardened for `net10.0`.

## 1) Scope and Dependency Mapping

- [ ] Confirm project role (host, shared library, provider, tooling).
- [ ] List direct `ProjectReference` dependencies.
- [ ] Identify transitive dependencies that are still `net48`-bound.
- [ ] Mark project as one of:
  - [ ] Cross-platform target
  - [ ] Windows-only runtime target

## 2) Target Framework and API Audit

- [ ] Verify intended `TargetFramework` or `TargetFrameworks`.
- [ ] Audit for `System.Web` and other .NET Framework-only APIs.
- [ ] Audit for Windows-only APIs (`Microsoft.Web.Administration`, registry/service APIs, etc.).
- [ ] Replace or isolate unsupported APIs behind abstractions.

## 3) Package and Build Audit

- [ ] Capture package baseline with target-conditional references.
- [ ] Remove obsolete/legacy package paths not needed on `net10.0`.
- [ ] Align shared package versions with adjacent projects.
- [ ] Confirm build scripts still work for all active target frameworks.

## 4) Runtime Validation

- [ ] Build project with `net10.0` target.
- [ ] Run project-level tests.
- [ ] Run smoke/integration tests for critical flows.
- [ ] Validate deployment artifact shape and runtime startup.

## 5) Operational Readiness

- [ ] Update docs and migration tracker with findings.
- [ ] Record known issues and fallback strategy.
- [ ] Confirm monitoring/logging coverage for migrated path.
- [ ] Obtain sign-off to proceed to next project.

## Evidence Template

- Project:
- Date:
- Owner:
- Target frameworks:
- Build result:
- Test result:
- Risks/open issues:
- Next action:
