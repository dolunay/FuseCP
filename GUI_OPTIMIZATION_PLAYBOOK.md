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

5. Width backlog follow-up phase:
- Additional cleanup batch completed across 8 files.
- Current `width_backlog_hits_excluding_popup`: `0` (verified by `FuseCP/Tools/run-gui-modernization-guards.ps1`).

6. Validation automation phase:
- Added `FuseCP/Tools/run-gui-modernization-guards.ps1`.
- Script reports in one run:
`legacy button/icon patterns`, `actionable old HTML attrs`, `width backlog excluding popup strings`, and `inline script candidate hotspots`.

7. Inline script consolidation phase:
- Added shared helper `DesktopModules/FuseCP/Scripts/email-selection.js` for Exchange email-address selection logic.
- Added shared helper `DesktopModules/FuseCP/Scripts/websites-helicon-ape-folder.js` for Helicon APE page client init logic.
- Added shared helper `DesktopModules/FuseCP/Scripts/exchange-create-mailbox.js` for Exchange create-mailbox page client logic.
- Added shared helper `DesktopModules/FuseCP/Scripts/websites-edit-site.js` for Website edit page confirmations/tab normalization.
- Added shared helper `DesktopModules/FuseCP/Scripts/vps2012-general.js` for VPS2012 general page RDP + warning logic.
- Added shared helper `DesktopModules/FuseCP/Scripts/vps-monitoring.js` for VPS monitoring popup/date-picker logic.
- Added shared helper `DesktopModules/FuseCP/Scripts/proxmox-vps-general.js` for Proxmox general page RDP + thumbnail refresh logic.
- Added shared helper `DesktopModules/FuseCP/Scripts/password-visibility.js` for password mask/reveal focus behavior.
- Added shared helper `DesktopModules/FuseCP/Scripts/tab-progress.js` for tab-click progress dialog behavior.
- Added shared helper `DesktopModules/FuseCP/Scripts/mail-confirmation.js` for mail-page delete confirmation with progress dialog wiring.
- Added shared helper `DesktopModules/FuseCP/Scripts/bulk-action-progress.js` for action-dropdown progress dialogs.
- Added shared helpers `DesktopModules/FuseCP/Scripts/search-users.js`, `DesktopModules/FuseCP/Scripts/search-spaces.js`, and `DesktopModules/FuseCP/Scripts/search-object.js` for search page client initialization.
- Added shared helper `DesktopModules/FuseCP/Scripts/enterprise-storage-drive-map.js` for enterprise storage drive-map form behavior.
- Added shared helper `DesktopModules/FuseCP/Scripts/organization-users.js` for organization users modal-close behavior.
- Added shared helper `DesktopModules/FuseCP/Scripts/overusage-report.js` for overusage report client bootstrap.
- Added shared helper `DesktopModules/FuseCP/Scripts/user-actions.js` for user-action progress handlers.
- Added shared helper `DesktopModules/FuseCP/Scripts/space-import-resources.js` for resource-import tree interaction behavior.
- Added shared helper `DesktopModules/FuseCP/Scripts/rds-servers.js` for RDS servers client bootstrap.
- Added shared helper `DesktopModules/FuseCP/Scripts/terminal-connections.js` for terminal session postback progress closing.
- Applied shared checkbox helper to `ExchangeServer/OrganizationUsers.ascx`.
- Applied shared checkbox helper to `Domains.ascx` and `IPAddresses.ascx`.
- Applied shared checkbox helper to `PhoneNumbers.ascx` and `VLANs.ascx`.
- Applied shared checkbox helper to `UserControls/PackageIPAddresses.ascx`, `UserControls/PackagePhoneNumbers.ascx`, and `UserControls/PackageVLANs.ascx`.
- Applied shared checkbox helper to `UserControls/SpaceServiceItems.ascx` and `ExchangeServer/ExchangeMailboxes.ascx`.
- Applied shared checkbox helper to `ExchangeServer/ExchangeJournalingMailboxes.ascx`.
- Reused shared bulk action progress helper in `UserControls/DomainActions.ascx`, `UserControls/MailAccountActions.ascx`, and `UserControls/WebsiteActions.ascx`.
- Reused shared confirmation helper in `FtpAccountEditAccount.ascx` and `SharedSSLEditFolder.ascx`.
- Replaced inline search scripts with external helpers in `SearchUsers.ascx`, `SearchSpaces.ascx`, and `SearchObject.ascx`.
- Replaced inline drive-map script with external helper in `ExchangeServer/EnterpriseStorageCreateDriveMap.ascx`.
- Replaced inline script in `ExchangeServer/OrganizationUsers.ascx` with shared `organization-users.js`.
- Replaced inline script in `OverusageReport.ascx` with shared `overusage-report.js`.
- Reused shared confirmation helper in `DnsZoneRecords.ascx`.
- Replaced inline script in `UserControls/UserActions.ascx` with shared `user-actions.js`.
- Replaced inline script in `SpaceImportResources.ascx` with shared `space-import-resources.js`.
- Reused shared confirmation helper in `SqlEditUser.ascx`.
- Replaced inline script in `RDSServers.ascx` with shared `rds-servers.js`.
- Replaced inline script in `ServersEditTerminalConnections.ascx` with shared `terminal-connections.js`.
- Reused shared confirmation helper in `SqlEditDatabase.ascx`.
- Reused shared nav-tab helper in `VPS/UserControls/Menu.ascx`, `VPS2012/UserControls/Menu.ascx`, and `VPSForPC/UserControls/Menu.ascx`.
- Reused shared tab-click helper in `ExchangeServer/UserControls/EnterpriseStorageEditFolderTabs.ascx`, `ExchangeServer/UserControls/OrganizationSettingsTabs.ascx`, and `RDS/UserControls/RDSCollectionTabs.ascx`.
- Reused shared mail confirmation helper in `MailAccountsEditAccount.ascx`, `MailDomainsEditDomain.ascx`, `MailForwardingsEditForwarding.ascx`, `MailGroupsEditGroup.ascx`, and `MailListsEditList.ascx`.
- Reduced inline-script candidate count from `100` to `44` in guard output.

8. Accessibility batch:
- Added missing icon alternate text/tooltip improvements in `Domains.ascx`, `UserSpaces.ascx`, `ExchangeServer/ExchangeMailboxEmailAddresses.ascx`, and `RDS/RDSUserSessions.ascx`.

## Next Modernization Queue

1. JS include normalization batch:
- Completed (checkpoint `d144c0e97`).

2. Inline script consolidation batch:
- Extract repeated inline helper blocks from these areas into shared files under `DesktopModules/FuseCP/Scripts/`:
`RDS/*.ascx`, `ExchangeServer/*EmailAddresses.ascx`, `WebSitesEditHeliconApeFolder.ascx`.
- Partially completed for `ExchangeServer/*EmailAddresses.ascx` and `WebSitesEditHeliconApeFolder.ascx`; continue with remaining high-frequency hotspots from guard report.

3. Accessibility batch:
- Add/verify label association and alt/title quality for controls in high-traffic pages:
`Domains.ascx`, `UserSpaces.ascx`, `ExchangeServer/ExchangeMailboxEmailAddresses.ascx`, `RDS/RDSUserSessions.ascx`.

4. Popup behavior hardening batch:
- Add consistent popup-blocked notification/fallback UX for RDP launchers while preserving existing open flow.

5. Validation automation batch:
- Add a repeatable scan script for:
`legacy button/icon patterns`, `actionable old HTML attrs`, `width backlog excluding popup strings`, `inline script duplication candidates`.
- Completed via `FuseCP/Tools/run-gui-modernization-guards.ps1`.
