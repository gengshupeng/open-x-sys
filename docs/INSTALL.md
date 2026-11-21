# Install OpenXSys

[简体中文](INSTALL.zh-CN.md) · [Back to README](../README.md)

OpenXSys ships as two complete language editions with one runtime architecture:

- English: `skills/open-x-sys/`
- Chinese: `skills/open-x-sys.zh-CN/`

The installed Skill is always named `open-x-sys`. The core requires no Node.js, Python, MCP service, or third-party web library. Capabilities already present in the host connect when real work needs them.

## Option 1: import a release package

Import the edition you want into an AI tool that supports Skills:

- [English package](../dist/open-x-sys-0.1.0-alpha.1-en-US.zip)
- [Chinese package](../dist/open-x-sys-0.1.0-alpha.1-zh-CN.zip)

Each archive has `open-x-sys/` at its root, with `SKILL.md` and the complete runtime inside.

After import, confirm that the tool discovers `open-x-sys`, then say:

```text
Use OpenXSys to open a system for what I am working on.
```

## Option 2: use the installer

The installer copies the selected Skill from this repository. It fetches no dependency and reads no credential. When a same-name Skill already exists, installation reports it. Update preserves the previous directory as a timestamped backup.

### macOS / Linux

```sh
# Detect the host; install English
sh scripts/install.sh

# Install Chinese
sh scripts/install.sh --language zh-CN

# Select a host
sh scripts/install.sh --host claude-code

# Select any Skill directory
sh scripts/install.sh --destination '/path/to/skills'
```

### Windows

```powershell
# Detect Codex, Claude Code, or a general Agent directory; install English
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1

# Install Chinese
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Language zh-CN

# Select a host
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -HostName codex

# Select any Skill directory
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Destination 'D:\path\to\skills'
```

Supported host names are `codex`, `claude-code`, and `agents`. When no host directory exists yet, automatic detection uses `~/.agents/skills`.

## Option 3: copy manually

Copy the complete edition into the Skill directory scanned by the AI tool. Keep its installed folder name as `open-x-sys`.

| Host | Common user Skill directory |
| --- | --- |
| Codex | `~/.codex/skills/` |
| Claude Code | `~/.claude/skills/` |
| General Agent | `~/.agents/skills/` |

Host versions may also support project-level or custom directories. Use the host's current discovery behavior.

## Check

```sh
sh scripts/install.sh --check
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Check
```

The check reports the target location, installed version, and language edition without modifying files.

## Update

```sh
sh scripts/install.sh --update
sh scripts/install.sh --language zh-CN --update
```

```powershell
# Preserve the installed edition
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Update

# Switch to or update Chinese
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Language zh-CN -Update
```

Update replaces only the installed Skill and preserves the prior directory beside it as `open-x-sys.backup-<timestamp>`. User-owned `~/.openxsys/`, project `.openxsys/`, works, and data live elsewhere.

## Remove

```sh
sh scripts/install.sh --uninstall
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Uninstall
```

Removal moves `open-x-sys` to `open-x-sys.removed-<timestamp>` so it can be restored. User systems and works remain where their owners placed them.

## Verify downloads

[`SHA256SUMS`](../dist/SHA256SUMS) lists both packages. On macOS or Linux, run:

```sh
cd dist
shasum -a 256 -c SHA256SUMS
```

On Windows, run:

```powershell
Get-FileHash -Algorithm SHA256 dist\open-x-sys-0.1.0-alpha.1-en-US.zip
Get-FileHash -Algorithm SHA256 dist\open-x-sys-0.1.0-alpha.1-zh-CN.zip
```

Compare the results with `dist/SHA256SUMS` to confirm that the downloaded packages match the release.
