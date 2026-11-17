# Verification

[Chinese](VALIDATION.zh-CN.md) · [Project introduction](../README.md)

Version: **0.0.1 Alpha Preview** (`0.0.1-alpha.1`).

## Reproducible release checks

Run these from the repository root with PowerShell:

```powershell
./scripts/check-loading.ps1 -SelfTest
./scripts/package-skill.ps1 -Check
./scripts/check-release.ps1
./scripts/test-install.ps1
```

The checks cover both runtime editions and their supporting-document paths, checker fixtures, package contents, version consistency, local links and the public file set. Package verification compares every ZIP entry with its source, including the release version.

`dist/release.json` records package languages, versions, file counts and SHA-256 hashes. `dist/SHA256SUMS` provides the checksums separately.

## Installation and first use

The complete ZIPs are checked through folder import into an isolated directory, replacement with a fresh copy and removal of that copy. These file-operation checks complement the complete-package verification. AI tools discover and run Skills through their own installation mechanisms; see the [installation guide](INSTALL.md).

The [featured industry report](../gallery/ai-industry/README.md) is an actual author-provided run. Its bilingual page, charts, scenarios, copying and card exports have separate interface checks recorded in its run notes.

## Runtime behavior

When recording a run, keep the tool, model, release, request and actual result together. For continued reading, retain raw file-read calls and compare them with the methods used in the output. Include a change of method and a resumed session. For running signals, check what appears during real use.

Static path checks and package checks establish that resources are available. Actual-session records establish how a host and model use them. Share new records through [evaluation contributions](../evals/README.md).
