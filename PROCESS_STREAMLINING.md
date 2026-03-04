# FuseCP Process Streamlining Outline

This outline defines a practical path to make local validation and contribution
flow faster while preserving build correctness.

## Phase 0 (Completed Baseline)

* Ordered build (`FuseCP/build.xml`) is the integration-safe default.
* Legacy `.vdproj` MSI packaging is gated behind full Visual Studio tooling.
* Prerequisite checks are scriptable (`check-test-environment.ps1`).
* A single local validation entrypoint now exists (`run-local-validation.ps1`).

## Phase 1 (Immediate Efficiency)

* Adopt `run-local-validation.ps1` in daily contributor workflow.
* Keep scope-based runs (`Portal`, `Enterprise`, `Server`) as the default loop.
* Use orchestrated builds for shared or cross-module changes.
* Standardize PR command reporting to include one validation command block.

## Phase 2 (Selective Automation)

* Add changed-file awareness (map touched paths to required validation scope).
* Add optional `-ChangedOnly` mode for faster targeted checks.
* Emit machine-readable summary (JSON) for CI annotation and PR templates.

## Phase 3 (CI Optimization)

* Reuse the same scope mapping in CI to reduce unnecessary full runs on small PRs.
* Keep a required integration-safe orchestrated build lane for merge protection.
* Publish a per-scope duration baseline and optimize highest-cost lanes first.

## Guardrails

* Never replace ordered integration validation for broad/shared changes.
* Keep legacy MSI validation explicit and opt-in when `.vdproj` output changes.
* Prefer deterministic script entrypoints over ad-hoc command sequences.

## Next Suggested Implementation Slice

1. ✅ Add `-ChangedOnly` to `run-local-validation.ps1`.
2. ✅ Add path-to-scope map (for example, `FuseCP.WebPortal` -> `Portal`).
3. ✅ Print final scope decision + executed command list for PR copy/paste.

## Current Focus

* ✅ Add optional scope map overrides from config to reduce hardcoded routing.
* ✅ Add JSON output mode for CI and PR automation.
* ✅ Add no-change fast-exit option for changed-only validation loops.

## Next Focus

* Add optional preflight restore-only mode for dependency warmup.
* Add per-scope timing summary to improve optimization prioritization.
