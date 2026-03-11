## CI: Stabilize CodeQL JS/TS SARIF Fingerprints on Windows

### Summary
- Fixes recurring CodeQL SARIF post-processing warning for inconsistent line-1 fingerprint in PermaLink.js.
- Normalizes JS extraction input so GitHub code scanning computes stable fingerprints.

### Why
- CodeQL reported inconsistent fingerprints for the same file and line:
	- Calculated: 9d480c4e67267b56:1
	- Existing: 6d3cff055d17204f:1
- Root cause was content normalization drift at line 1 (BOM and line-ending variance during analysis/post-processing).

### Changes
- Updated checkout behavior in CodeQL workflow to force LF content materialization:
	- .github/workflows/codeql.yml
	- Added: checkout with eol: lf
- Added path-specific EOL policy for WebFormsForCore JS assets:
	- .gitattributes
	- Added: FuseCP/Lib/WebFormsForCore/src/WebFormsForCore.Web.Extensions/Script/**/*.js text eol=lf
- Normalized target file encoding to UTF-8 without BOM:
	- FuseCP/Lib/WebFormsForCore/src/WebFormsForCore.Web.Extensions/Script/Sys/UI/Controls/PermaLink.js

### Risk
- Low. No runtime logic changes in product code.
- Scope limited to CI checkout normalization and text-file normalization for deterministic hashing.

### Validation
- Confirmed PermaLink.js no longer has UTF-8 BOM locally.
- Confirmed no errors in touched files.
- Workflow re-run required in GitHub Actions to fully verify warning is gone from javascript.sarif post-processing.

### Suggested Reviewer Checks
- Re-run CodeQL workflow and inspect Analyze (javascript-typescript / none).
- Confirm no repeated inconsistent fingerprint warnings for PermaLink.js line 1.

### Follow-up (Root-Cause Fix)
- Implemented the normalization fix in the WebFormsForCore submodule itself (real source fix):
	- FuseCP/Lib/WebFormsForCore/src/WebFormsForCore.Web.Extensions/Script/Sys/UI/Controls/PermaLink.js
	- UTF-8 without BOM, LF line endings
- Updated this repository's submodule pointer to the new WebFormsForCore commit.
- Removed temporary CodeQL `paths-ignore` suppression from workflow after source fix was available.

