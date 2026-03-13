# SmarterStats Modernization Plan

## Goal
Introduce a transport abstraction so the provider can move from legacy ASMX SOAP to a modern client without changing business behavior.

## Current State
- Provider logic is in `SmarterStats.cs` and now depends on `ISmarterStatsAutomationClient`.
- Default implementation is `SmarterStatsSoapAutomationClient` (legacy-compatible).
- Existing provider remains build-compatible while modernization proceeds incrementally.
- Provider setting `AutomationTransport` is now recognized. Supported values: `Soap` and `Modern`.
- Provider setting `ModernAutomationEndpoint` is recognized for the modern transport path (falls back to `SmarterUrl`).
- `SmarterStatsModernAutomationClient` is scaffolded and intentionally throws `NotImplementedException` until live contract mapping is completed.

## Parity Matrix

| FuseCP operation | Current client call | Notes for modern client |
| --- | --- | --- |
| GetServers | GetServers | Required for server selection/reporting. |
| GetSiteId | GetAllSites | Resolves site id by domain name. |
| GetSites | GetAllSites | Returns site domain list. |
| GetSite | GetSite + GetUsers | Includes URL token replacement behavior in provider. |
| AddSite | AddSite + AddUser | Owner user created with site, then additional users. |
| UpdateSite | GetSite + UpdateSite + GetUsers + AddUser/UpdateUser/DeleteUser | Preserves owner user. |
| DeleteSite | DeleteSite | Deletes reports with site (`deleteReports=true`). |

## Migration Steps
1. Capture live service contract from SmarterStats instance (Settings -> Web Services).
2. Confirm auth model and method signatures against parity matrix.
3. Implement a second client class (e.g. `SmarterStatsModernAutomationClient`) behind `ISmarterStatsAutomationClient`.
4. Add a provider setting to choose transport (`Soap` vs `Modern`) and default to `Soap`.
5. Add integration tests for lifecycle parity:
   - Create site with owner + extra users
   - Update site and user set
   - Delete site
6. Roll out modern transport in staged environments and compare operation results.

## Validation Checklist
- Build success for `FuseCP.Server.sln`.
- No behavior regressions in existing SOAP path.
- Same error handling and messages where practical.
- Same site/user ownership semantics.
