# GUI Optimization Playbook

Last updated: 2026-03-05 (extended standards)

This document defines the mandatory workflow for WebPortal GUI modernization work so standards stay consistent across long sessions.

## Scope

Applies to:
- `FuseCP/Sources/FuseCP.WebPortal/DesktopModules/FuseCP/**/*.ascx`
- `FuseCP/Sources/FuseCP.WebPortal/DesktopModules/FuseCP/**/*.aspx`
- `FuseCP/Sources/FuseCP.WebPortal/DesktopModules/FuseCP/**/*.master`

## Non-Negotiable Standards

1. Keep behavior unchanged unless explicitly requested.
2. Use conservative markup modernization only (layout/CSS class/attribute cleanup).
3. No destructive git operations.
4. If unexpected external edits appear in target files, re-read those files before editing.
5. XSS safety is mandatory: do not introduce raw/unencoded user-controlled output.
6. Keep pages responsive where safe in WebForms context (prefer fluid controls, remove hard-coded widths when not behavior-critical).
7. Keep old completed categories clean:
- `Legacy button/control hits (filtered)` must stay `0` for `Button1|Button2|Button3|CPCC button tags`.
- `Actionable old-HTML attr hits (case-sensitive, filtered)` must stay `0` for `align|valign|hspace|vspace|border="N"`.
8. Icons must use Bootstrap Icons (`bi bi-*`) only; no Font Awesome reintroduction.
9. Preserve functionality and event wiring; UI improvements must not alter business behavior.
10. Optimize for ASP.NET Core/WebFormsForCore compatibility where possible (safe markup normalization, avoid legacy-only patterns).
11. Do not "modernize" JavaScript popup dimension strings used by `window.open` (for example `status=0,width=...`); treat them as behavior-critical and exclude them from width-backlog cleanup scans.

## Point 2 (Expanded) Definition of Done Per Page

A page is considered done only when all of these are true:

1. Legacy fixed width patterns removed where safe:
- lowercase HTML `width="..."`
- inline width declarations (`style="...width:..."`)
- `ItemStyle-Width="..."` when not required for behavior

2. Basic GUI consistency improvements are applied where safe:
- normalize legacy input classes (for example `NormalTextBox` -> `form-control`)
- prefer existing project utility classes (`FormLabel150`, `FormLabel200`, Bootstrap spacing/alignment classes)
- remove redundant width attributes where controls are already fluid

3. File-level validation clean:
- no problems reported for the edited page
4. Security sanity check passes for touched pages:
- no newly introduced unencoded inline output patterns
5. Icon sanity check passes for touched pages:
- no `fa fa-` or `FontAwesome` usage introduced

## Batch and Commit Protocol

Use fixed-size batches to control risk and preserve momentum:

1. Select 10 pages.
2. Finish all 10 pages to the Point-2 Definition of Done.
3. Validate batch metrics.
4. Commit exactly those 10 pages as a local checkpoint.
5. Repeat with next 10 pages.
6. Continue to next batch without waiting for confirmation unless user says to pause.
7. Do not push after each batch.
8. Keep local checkpoint commits per batch and push in large milestones (for example after 100+ batches) to avoid excessive CI/GitHub Actions churn.

Commit message format:
- `WebPortal GUI optimization batch <N> (10 pages): responsive + legacy width cleanup`

## Validation Commands

Use these checks after each batch:

1. Fixed-width backlog (DesktopModules/FuseCP)
2. Legacy button/control scan (must remain 0)
3. Actionable old-HTML attr scan (must remain 0)
4. `get_errors` for all edited files in the batch
5. Font Awesome scan (must remain 0)
6. XSS guard scan on touched pages (no newly introduced risky output patterns)

## Current Baseline (after batch 1)

- `Fixed-width hits (DesktopModules/FuseCP)`: `486`
- `Legacy button/control hits (filtered)`: `0`
- `Actionable old-HTML attr hits (case-sensitive, filtered)`: `0`

## Tactic Stability Rules

Do not switch tactics mid-stream unless explicitly requested.

Keep using:
1. Per-page completion standard.
2. 10-page batch size.
3. Local checkpoint commits only (no push unless requested).
4. Conservative GUI optimization focused on responsive/layout modernization.

## Current Progress Snapshot (2026-03-05)

1. Width modernization phase:
- Completed through `WebPortal GUI optimization batch 55` plus residual cleanup commit.
- Remaining width-pattern hits are popup `window.open(...width=...)` strings only and are now explicitly excluded by rule 11.

2. Popup modernization phase:
- Added shared helper `DesktopModules/FuseCP/Scripts/rdp-popup.js`.
- Wired these pages to shared helper with local fallback behavior:
`DesktopModules/FuseCP/VPS/VpsDetailsGeneral.ascx`, `DesktopModules/FuseCP/VPS2012/VpsDetailsGeneral.ascx`, `DesktopModules/FuseCP/VPSForPC/VpsDetailsGeneral.ascx`, `DesktopModules/FuseCP/Proxmox/VpsDetailsGeneral.ascx`.

3. Guard status:
- `Legacy button/control hits (filtered)`: `0`.
- `Actionable old-HTML attr hits (case-sensitive, filtered)`: `0`.

4. JS include normalization phase:
- Completed first normalization checkpoint commit `d144c0e97`.
- Normalized 18 markup files from `/JavaScript/jquery.min.js?v=1.4.4` to `/JavaScript/jquery-1.4.4.min.js`.
- Post-checks passed: `net10` portal modules build, legacy guard, old-HTML guard, and no remaining querystring jQuery includes in module markup scope.

## Next Modernization Queue

1. JS include normalization batch:
- Completed (checkpoint `d144c0e97`).

2. Inline script consolidation batch:
- Extract repeated inline helper blocks from these areas into shared files under `DesktopModules/FuseCP/Scripts/`:
`RDS/*.ascx`, `ExchangeServer/*EmailAddresses.ascx`, `WebSitesEditHeliconApeFolder.ascx`.

3. Accessibility batch:
- Add/verify label association and alt/title quality for controls in high-traffic pages:
`Domains.ascx`, `UserSpaces.ascx`, `ExchangeServer/ExchangeMailboxEmailAddresses.ascx`, `RDS/RDSUserSessions.ascx`.

4. Popup behavior hardening batch:
- Add consistent popup-blocked notification/fallback UX for RDP launchers while preserving existing open flow.

5. Validation automation batch:
- Add a repeatable scan script for:
`legacy button/icon patterns`, `actionable old HTML attrs`, `width backlog excluding popup strings`, `inline script duplication candidates`.
