# Security Policy

FuseCP takes security reports seriously and follows coordinated disclosure.

## Supported Versions

Security fixes are provided for the following code lines:

| Version / Branch | Supported |
| --- | --- |
| `main` | Yes |
| Latest `release/*` branch | Yes |
| Older release branches | Best effort only |

If you are running an older version, upgrade to a supported branch before requesting a fix.

## Reporting A Vulnerability

Please do not report security vulnerabilities in public issues.

Use one of these private channels:

1. GitHub Security Advisory draft for this repository (preferred).
2. Project team private contact form: https://solidcp.com/contact/

Include as much detail as possible:

- Affected component, version, and branch.
- Reproduction steps or proof-of-concept.
- Impact assessment (confidentiality, integrity, availability).
- Any mitigations already tested.
- Logs or traces with secrets and tenant data removed.

## Response Targets

FuseCP maintainers target the following response windows:

- Acknowledgement: within 2 business days.
- Initial triage and severity: within 5 business days.
- Remediation target:
  - Critical: within 7 days.
  - High: within 14 days.
  - Medium: within 30 days.
  - Low: next planned release.

These are targets, not guarantees. Complex fixes may require phased mitigations.

## Disclosure Process

- Reports are handled as coordinated disclosure.
- Public disclosure is requested only after a fix or mitigation is available.
- Advisory notes should include affected versions, remediation guidance, and credit (unless anonymity is requested).

## Security Requirements For Contributions

All contributors (human or AI-assisted) must follow these rules:

- Never commit secrets, keys, tokens, or connection strings.
- Never include customer or tenant data in examples, logs, commits, or AI prompts.
- Flag security-sensitive changes for explicit maintainer review.
- Validate dependency and vulnerability impact for package updates.
- Keep secure defaults; do not weaken auth, permission, TLS, or input validation behavior without approved rationale.

For FuseCP changes that affect runtime or dependencies:

- Validate the narrowest relevant scope first, then broaden as needed.
- Validate affected solutions/scopes (`Portal`, `Enterprise`, `Server`).
- Validate affected target frameworks (`net48`, `net10.0`, `netstandard2.0`) where applicable.
- Use repository validation entrypoints (for example `FuseCP/Tools/run-local-validation.ps1`) and capture command evidence in PR notes.

## Out Of Scope

The following are generally not treated as security vulnerabilities:

- Reports requiring unrealistic attacker prerequisites.
- Denial of service caused only by local development misconfiguration.
- Vulnerabilities in unsupported versions with no practical upgrade path provided.

## Policy Updates

This policy may be updated as FuseCP architecture, release process, and support windows evolve.