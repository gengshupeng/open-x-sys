# Install OpenXSys

[Chinese](INSTALL.zh-CN.md) · [Back to the README](../README.md)

## Ask your AI

Copy this prompt into your AI. It includes the project address; you can also attach the [complete English skill package](../dist/open-x-sys.zip?raw=true):

```text
Please install OpenXSys Skill from https://github.com/gengshupeng/open-x-sys
Use the installation method for the AI tool you are running in, install the complete English edition, and check that it is available.
Tell me when it is ready. I will then ask my own question.
```

After installation, say:

```text
Use OpenXSys to research the entire artificial intelligence industry.
```

You can also ask your own question, share material, or name a company, project or technology. The Playground, method combinations and learn mode are there when you want to explore further.

<a id="tools"></a>

## The tool you already use

These are entry points for the installer. The AI chooses an installation method using the capabilities of its current tool.

| Tool | Installation entry |
|---|---|
| WorkBuddy | Import the complete package through skill management, or ask an AI with file-installation capabilities to handle it. [Official skill documentation](https://cloud.tencent.com/document/product/1831/134432) |
| Doubao Work | Use conversational installation or local skill import. [Official feature overview](https://www.feishu.cn/content/article/7677519271848610746) |
| DSH / DeepSeek Harness | Use the current environment's skill installation capabilities, or put the complete folder in a skill directory scanned by that instance. [Official entry](https://www.deepseek.com/harness/) |
| Claude Code, Codex | Use the tool's own skill installation capabilities, or run this repository's installer with the current tool explicitly selected. |
| Other AI tools with skill support | Use their skill import, installation or management entry, keeping the complete folder structure. |

The project is in **Alpha Preview**. Installation entry points are collected here; installation and use records live in [evals](../evals/README.md).

## For the AI carrying out installation

### Identify the current environment

Use the current session, tool information and existing configuration to establish which AI tool you are in and how it discovers skills. Several AI tools can be installed on the same computer; the installation target belongs to the one being used now.

### Obtain the complete contents

- The Chinese source is `skills/open-x-sys.zh-CN/`; the English source is `skills/open-x-sys/`.
- The installed folder is named `open-x-sys/`, directly containing `SKILL.md` and the complete method, route, engine, display, system and style directories.
- The repository's Playground is available separately when the person wants to explore it.
- The English ZIP has an `open-x-sys/` root; the Chinese ZIP keeps the original `open-x-sys.zh-CN/` root. Both contain the complete 80-file runtime, release version and license. Select the corresponding ZIP when using a tool's local package importer.

### Use the current tool's installation method

Use native installation or import capabilities when available. In an environment with file access, the complete folder can also be copied into a skill directory actually scanned by the current tool.

The repository installers support Windows, macOS, Linux and custom skill directories. For an installation task already specified, `-Yes` or `--yes` runs it without an interactive terminal prompt; `-Check` or `--check` reports installation state. Options and locked dependencies are described in [DEPENDENCIES.md](../skills/open-x-sys/deps/DEPENDENCIES.md).

<details>
<summary>Script installation: for AIs and developers</summary>

Run these commands from the repository root. Select the current tool; for a custom directory, use the skill directory that tool actually scans.

```powershell
# Windows: Codex example
powershell -NoProfile -ExecutionPolicy Bypass -File skills/open-x-sys/deps/install.ps1 -HostName codex -Yes

# With a confirmed skill directory
powershell -NoProfile -ExecutionPolicy Bypass -File skills/open-x-sys/deps/install.ps1 -Dir '<Skill directory>' -Yes
```

```sh
# macOS / Linux: Claude Code example
sh skills/open-x-sys/deps/install.sh --host claude-code --yes

# With a confirmed skill directory
sh skills/open-x-sys/deps/install.sh --dir '<Skill directory>' --yes
```

</details>

### Check and hand over

Check that the tool discovers `open-x-sys` and can read `SKILL.md` and its supporting documents. Report the actual installation location and language, and tell the person they can now ask their own question.

The text-based core can use the AI capabilities already available. Pages, charts, documents and videos draw on existing tools and installed skills; the current external dependency status is in the [dependency guide](../skills/open-x-sys/deps/DEPENDENCIES.md).

## Update and uninstall

Ask your AI:

```text
Update OpenXSys, keeping my systems, preferences and existing deliverables.
```

```text
Uninstall OpenXSys, keeping my systems and existing deliverables.
```

The skill installation is managed separately from the person's `.openxsys/` directories, working files and deliverables. The installer's `-Uninstall` / `--uninstall` removes the installed skill.

## Maintain the packages

From the repository root, run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/package-skill.ps1` to regenerate both ZIPs. Add `-Check` to compare every packaged file with its current source.
