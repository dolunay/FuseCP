# FuseCP.Server Solution .NET 10.0 Upgrade Tasks

## Overview

This document tracks the bottom-up incremental upgrade of the FuseCP.Server solution from .NET Framework 4.8 / .NET Standard 2.0/2.1 to .NET 10.0. The upgrade proceeds through dependency tiers, with each tier fully validated before advancing to the next.

**Progress**: 0/20 tasks complete (0%) ![0%](https://progress-bar.xyz/0)

---

## Tasks

### [▶] TASK-001: Verify prerequisites
**References**: Plan §Migration Strategy

- [▶] (1) Verify .NET 10.0 SDK installed and available
- [ ] (2) SDK version meets minimum requirements (**Verify**)
- [ ] (3) Verify required Windows Server versions available for testing (2016, 2019, 2022, 2025)
- [ ] (4) Test environments provisioned per Plan §Testing Environment Setup (**Verify**)

---

### [ ] TASK-002: Phase 1 - Upgrade foundation libraries
**References**: Plan §Phase 1: Foundation Projects, Plan §Level 0-1

- [ ] (1) Update target framework in all Level 0-1 projects per Plan §Phase 1 (7 projects: FuseCP.Build, FuseCP.Providers.Base, FuseCP.Providers.Web.LetsEncrypt, FuseCP.Providers.Web.Apache, FuseCP.Server.Utils, FuseCP.Web.Clients, FuseCP.Web.Services)
- [ ] (2) All project files updated to net10.0 or net10.0-windows as appropriate (**Verify**)
- [ ] (3) Update NuGet packages per Plan §Phase 1 (focus: remove redundant packages per NuGet.0003, upgrade versions per NuGet.0002)
- [ ] (4) All packages updated and compatible (**Verify**)
- [ ] (5) Restore all dependencies
- [ ] (6) All dependencies restored successfully (**Verify**)
- [ ] (7) Build all Phase 1 projects and address compilation errors per Plan §API Compatibility Fixes
- [ ] (8) All Phase 1 projects build with 0 errors (**Verify**)

---

### [ ] TASK-003: Phase 1 - Test and validate foundation
**References**: Plan §Testing & Validation Strategy §Layer 2, Plan §Success Criteria

- [ ] (1) Run unit tests for all Phase 1 projects
- [ ] (2) Fix any test failures (reference Plan §API Behavioral Changes for common issues)
- [ ] (3) Re-run tests after fixes
- [ ] (4) All unit tests pass with 0 failures (**Verify**)
- [ ] (5) Verify no breaking API changes in FuseCP.Providers.Base and FuseCP.Server.Utils (85+ consumers depend on these)
- [ ] (6) API surface remains compatible (**Verify**)
- [ ] (7) Commit Phase 1 changes with message: "TASK-003: Complete Phase 1 foundation upgrade to .NET 10.0"

---

### [ ] TASK-004: Phase 2a+2b - Upgrade database and clean providers
**References**: Plan §Phase 2 §Sub-Phase 2a, Plan §Phase 2 §Sub-Phase 2b

- [ ] (1) Update target framework in database providers per Plan §Sub-Phase 2a (SqlServer, MySQL, MariaDB)
- [ ] (2) Update target framework in clean providers per Plan §Sub-Phase 2b (15 projects: DNS Bind/PowerDNS, FTP VsFtp/ServU/FileZilla/Gene6, Mail VB.NET providers, OS Unix)
- [ ] (3) All project files updated to net10.0 (**Verify**)
- [ ] (4) Update NuGet packages per Plan §Sub-Phase 2a+2b (focus: database client libraries, remove framework-included packages)
- [ ] (5) All packages updated (**Verify**)
- [ ] (6) Build all Phase 2a+2b projects and fix compilation errors
- [ ] (7) All projects build with 0 errors (**Verify**)

---

### [ ] TASK-005: Phase 2a+2b - Test and validate
**References**: Plan §Testing & Validation Strategy §Layer 3

- [ ] (1) Run component tests for database providers per Plan §Testing Strategy (verify SQL Server, MySQL, MariaDB connectivity and operations)
- [ ] (2) Run component tests for clean providers (verify DNS, FTP, Mail, OS provider operations)
- [ ] (3) Fix any test failures
- [ ] (4) Re-run tests after fixes
- [ ] (5) All component tests pass with 0 failures (**Verify**)
- [ ] (6) Commit Phase 2a+2b changes with message: "TASK-005: Complete database and clean providers upgrade"

---

### [ ] TASK-006: Phase 2c - Upgrade Windows integration providers
**References**: Plan §Phase 2 §Sub-Phase 2c

- [ ] (1) Update target framework in Windows integration providers per Plan §Sub-Phase 2c (Windows2016, IIS60/70/80/100, RDS.Windows2012 and variants) to net10.0-windows
- [ ] (2) All project files updated to net10.0-windows (**Verify**)
- [ ] (3) Update System.Management and related packages for WMI API changes
- [ ] (4) All packages updated (**Verify**)
- [ ] (5) Build all Windows integration projects and fix compilation errors per Plan §WMI API Migration and Plan §IIS Management API Migration
- [ ] (6) All projects build with 0 errors (**Verify**)

---

### [ ] TASK-007: Phase 2c - Test Windows integration
**References**: Plan §Testing & Validation Strategy §Component Testing §OS Provider Tests, §Web Provider Tests

- [ ] (1) Run component tests for Windows OS providers (verify WMI queries, Windows feature management on Server 2016-2025)
- [ ] (2) Run component tests for IIS providers (verify IIS configuration operations for versions 6.0-10.0)
- [ ] (3) Run component tests for RDS providers (verify Remote Desktop Services management)
- [ ] (4) Fix any test failures (reference Plan §Windows Management API Updates)
- [ ] (5) Re-run tests after fixes
- [ ] (6) All tests pass with 0 failures (**Verify**)
- [ ] (7) Commit Phase 2c changes with message: "TASK-007: Complete Windows integration providers upgrade"

---

### [ ] TASK-008: Phase 2d - Upgrade virtualization providers
**References**: Plan §Phase 2 §Sub-Phase 2d

- [ ] (1) Update target framework in virtualization providers per Plan §Sub-Phase 2d (HyperV, Proxmox) to net10.0-windows
- [ ] (2) All project files updated to net10.0-windows (**Verify**)
- [ ] (3) Update System.Management packages for Hyper-V WMI APIs
- [ ] (4) Update Proxmox API client libraries
- [ ] (5) All packages updated (**Verify**)
- [ ] (6) Build virtualization projects and fix compilation errors per Plan §Hyper-V Management API Migration
- [ ] (7) All projects build with 0 errors (**Verify**)

---

### [ ] TASK-009: Phase 2d - Test virtualization providers
**References**: Plan §Testing & Validation Strategy §Virtualization Provider Tests

- [ ] (1) Run component tests for HyperV provider (verify VM listing, creation, snapshot operations)
- [ ] (2) Run component tests for Proxmox provider (verify Proxmox VE integration)
- [ ] (3) Fix any test failures
- [ ] (4) Re-run tests after fixes
- [ ] (5) All tests pass with 0 failures (**Verify**)
- [ ] (6) Commit Phase 2d changes with message: "TASK-009: Complete virtualization providers upgrade"

---

### [ ] TASK-010: Phase 2e - Upgrade statistics providers
**References**: Plan §Phase 2 §Sub-Phase 2e

- [ ] (1) Update target framework in AWStats provider to net10.0
- [ ] (2) Investigate SmarterStats SDK compatibility with .NET 10 per Plan §Sub-Phase 2e (138 binary incompatibilities)
- [ ] (3) Update target framework in SmarterStats provider based on investigation results (direct upgrade if SDK available, alternative approach if not)
- [ ] (4) All project files updated (**Verify**)
- [ ] (5) Update packages and address compatibility issues
- [ ] (6) Build statistics projects and fix compilation errors
- [ ] (7) All projects build with 0 errors (**Verify**)

---

### [ ] TASK-011: Phase 2e - Test statistics providers
**References**: Plan §Testing & Validation Strategy

- [ ] (1) Run component tests for AWStats provider
- [ ] (2) Run component tests for SmarterStats provider (or alternative implementation)
- [ ] (3) Fix any test failures
- [ ] (4) Re-run tests after fixes
- [ ] (5) All tests pass with 0 failures (**Verify**)
- [ ] (6) Commit Phase 2e changes with message: "TASK-011: Complete statistics providers upgrade"

---

### [ ] TASK-012: Phase 2f - Investigate and upgrade SmarterMail providers
**References**: Plan §Phase 2 §Sub-Phase 2f

- [ ] (1) Conduct investigation phase per Plan §High-Risk Mail Providers (identify SDK versions, check for .NET 10-compatible SDKs, evaluate REST API alternatives)
- [ ] (2) Investigation complete and migration path determined (**Verify**)
- [ ] (3) Update target framework in SmarterMail100 provider (cleanest version, use as template)
- [ ] (4) Based on investigation, upgrade other SmarterMail providers (2, 3, 5, 6, 7, 9, 10) using appropriate approach (SDK upgrade, REST API migration, or multi-targeting)
- [ ] (5) All SmarterMail project files updated (**Verify**)
- [ ] (6) Update packages and implement chosen integration method
- [ ] (7) Build all SmarterMail projects and fix compilation errors
- [ ] (8) All projects build with 0 errors (**Verify**)

---

### [ ] TASK-013: Phase 2f - Test SmarterMail providers
**References**: Plan §Testing & Validation Strategy §Mail Provider Tests

- [ ] (1) Run component tests for all SmarterMail providers (verify mail operations: create mailbox, domain management, mail filtering)
- [ ] (2) Fix any test failures
- [ ] (3) Re-run tests after fixes
- [ ] (4) All tests pass with 0 failures (**Verify**)
- [ ] (5) Commit Phase 2f changes with message: "TASK-013: Complete SmarterMail providers upgrade"

---

### [ ] TASK-014: Phase 2g - Investigate and upgrade CerberusFTP6 provider
**References**: Plan §Phase 2 §Sub-Phase 2g

- [ ] (1) Investigate Cerberus FTP SDK compatibility per Plan §Sub-Phase 2g (363 binary incompatibilities, check for updated SDK or alternative approaches)
- [ ] (2) Investigation complete and migration path determined (**Verify**)
- [ ] (3) Update target framework in CerberusFTP6 provider based on investigation results
- [ ] (4) Project file updated (**Verify**)
- [ ] (5) Implement chosen integration method (SDK upgrade, direct API/config file manipulation, or interop bridge)
- [ ] (6) Build CerberusFTP6 project and fix compilation errors
- [ ] (7) Project builds with 0 errors (**Verify**)

---

### [ ] TASK-015: Phase 2g - Test CerberusFTP6 provider
**References**: Plan §Testing & Validation Strategy

- [ ] (1) Run component tests for CerberusFTP6 provider (verify FTP operations)
- [ ] (2) Fix any test failures
- [ ] (3) Re-run tests after fixes
- [ ] (4) All tests pass with 0 failures (**Verify**)
- [ ] (5) Commit Phase 2g changes with message: "TASK-015: Complete CerberusFTP6 provider upgrade"

---

### [ ] TASK-016: Phase 3 - Upgrade specialized providers
**References**: Plan §Phase 3: Specialized Providers

- [ ] (1) Update target framework in HostedSolution base provider to net10.0-windows per Plan §Sub-Phase 3a (critical: 17 providers depend on this)
- [ ] (2) Install Directory Services NuGet packages (System.DirectoryServices, System.DirectoryServices.AccountManagement, System.DirectoryServices.Protocols)
- [ ] (3) Address 677 issues in HostedSolution base per Plan §HostedSolution Base & Extensions (focus: AD/LDAP, IdentityModel, GDI+)
- [ ] (4) HostedSolution base builds with 0 errors (**Verify**)
- [ ] (5) Update target framework in Exchange, SharePoint, Lync/SfB, CRM providers per Plan §Phase 3
- [ ] (6) Update management SDKs (Exchange EWS, SharePoint CSOM, Lync/SfB SDK, Dynamics CRM SDK)
- [ ] (7) Update target framework in DNS/Mail/OS extension providers (SimpleDNS variants, MsDNS2016, Windows 2019/2022/2025, RDS variants)
- [ ] (8) Update target framework in WebDav and EnterpriseStorage providers
- [ ] (9) All Phase 3 project files updated (**Verify**)
- [ ] (10) Build all Phase 3 projects and fix compilation errors
- [ ] (11) All projects build with 0 errors (**Verify**)

---

### [ ] TASK-017: Phase 3 - Test specialized providers
**References**: Plan §Testing & Validation Strategy §HostedSolution Integration

- [ ] (1) Run component tests for HostedSolution base (verify AD operations, user/group management)
- [ ] (2) Run component tests for Exchange providers (verify mailbox operations, distribution lists)
- [ ] (3) Run component tests for SharePoint providers (verify site collection/site/list operations)
- [ ] (4) Run component tests for Lync/SfB providers (verify user provisioning and policies)
- [ ] (5) Run component tests for CRM providers (verify organization/user management)
- [ ] (6) Run component tests for remaining specialized providers
- [ ] (7) Fix any test failures
- [ ] (8) Re-run tests after fixes
- [ ] (9) All tests pass with 0 failures (**Verify**)
- [ ] (10) Commit Phase 3 changes with message: "TASK-017: Complete specialized providers upgrade"

---

### [ ] TASK-018: Phase 4 - Upgrade main applications
**References**: Plan §Phase 5: Main Applications

- [ ] (1) Fix .NET 10-specific issues in FuseCP.Server per Plan §Phase 5 (9 issues)
- [ ] (2) Migrate remaining ASP.NET Framework dependencies to ASP.NET Core per Plan §ASP.NET Core Migration (if not already complete)
- [ ] (3) Update authentication middleware and configuration
- [ ] (4) Fix .NET 10-specific issues in FuseCP.Server.Client per Plan §Phase 5 (3,401 issues - many inherited from dependencies)
- [ ] (5) Update WCF client proxies to use CoreWCF services per Plan §WCF to CoreWCF Migration
- [ ] (6) Build both application projects
- [ ] (7) Both projects build with 0 errors (**Verify**)

---

### [ ] TASK-019: Phase 4 - Test main applications
**References**: Plan §Testing & Validation Strategy §Integration Testing

- [ ] (1) Run integration tests per Plan §Service Layer Integration (verify service endpoints respond)
- [ ] (2) Run integration tests per Plan §Database → Service → Provider Flow (verify full stack operations)
- [ ] (3) Run integration tests per Plan §CoreWCF Communication (verify client-server communication)
- [ ] (4) Fix any test failures
- [ ] (5) Re-run tests after fixes
- [ ] (6) All integration tests pass with 0 failures (**Verify**)
- [ ] (7) Verify server application starts and serves requests
- [ ] (8) Server is functional (**Verify**)
- [ ] (9) Commit Phase 4 changes with message: "TASK-019: Complete main applications upgrade"

---

### [ ] TASK-020: Phase 5 - End-to-end validation and final commit
**References**: Plan §Testing & Validation Strategy §Layer 5, Plan §Success Criteria

- [ ] (1) Run end-to-end tests per Plan §E2E Testing (all critical workflows: web hosting, email hosting, hosted Exchange, VM hosting)
- [ ] (2) Fix any E2E test failures
- [ ] (3) Re-run E2E tests after fixes
- [ ] (4) All E2E tests pass with 0 failures (**Verify**)
- [ ] (5) Run performance validation per Plan §Performance & Load Testing (verify response times, throughput, resource usage within targets)
- [ ] (6) Performance metrics within acceptable range (**Verify**)
- [ ] (7) Run security validation per Plan §Security Testing (vulnerability scan, authentication/authorization, dependency check)
- [ ] (8) Security validation passes with no critical issues (**Verify**)
- [ ] (9) Verify all Success Criteria met per Plan §Success Criteria (build success, tests passing, performance acceptable, security validated, documentation updated)
- [ ] (10) All Success Criteria verified (**Verify**)
- [ ] (11) Commit final changes with message: "TASK-020: Complete .NET 10.0 upgrade - all 93 projects migrated and validated"

---
