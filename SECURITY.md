# Security

[简体中文](SECURITY.zh-CN.md)

## Supported version

The currently supported version is `0.1.0-alpha.1`. Pre-release status keeps the same standard for data, permissions, installation, and supply-chain behavior.

## Reporting a vulnerability

Use GitHub's [private vulnerability reporting](https://github.com/gengshupeng/open-x-sys/security/advisories/new) for an unpatched vulnerability. Include:

- affected version, language edition, and host;
- reproduction conditions and the smallest sequence of steps;
- data, permissions, or files that may be affected;
- any known mitigation.

## Trust boundary

- The core OpenXSys package installs with zero network-fetched dependencies.
- Installers copy only the selected repository Skill; update and removal preserve recoverable timestamped backups.
- User systems, works, and data live outside the Skill installation directory and remain independent of the installer.
- Credentials stay with dedicated security systems; a connection records only the reference and what it makes possible.
- Publishing, spending, contact with others, expansion of private scope, long-running operation, and irreversible effects follow actual user and host authority.
