# 安装 OpenXSys

[English](INSTALL.md) · [返回中文 README](../README.zh-CN.md)

OpenXSys 提供中英文两个完整语言版本，拥有同一套运行架构。英文源目录是 `skills/open-x-sys/`，中文源目录是 `skills/open-x-sys.zh-CN/`；安装后的名字始终是 `open-x-sys`。核心不依赖 Node.js、Python、MCP 服务或第三方网页库；宿主已有的能力会在实际任务中按需接入。

## 方式一：导入发行包

把[中文发行包](../dist/open-x-sys-0.1.0-alpha.1-zh-CN.zip)导入支持 Skill 的 AI 工具；英文用户可以选择[英文发行包](../dist/open-x-sys-0.1.0-alpha.1-en-US.zip)。压缩包根目录都是 `open-x-sys/`，其中直接包含 `SKILL.md` 与全部运行资料。

导入后确认工具能发现 `open-x-sys`，然后直接说：

```text
用 OpenXSys，给我正在处理的这件事开启一个系统。
```

## 方式二：使用安装器

安装器只复制本仓库的 Skill，不联网、不下载依赖、不读取密钥。目标目录中已有同名 Skill 时，默认停止；显式使用更新参数时，旧目录会先被改名保存，便于恢复。

### macOS / Linux

```sh
# 自动识别宿主，安装中文版
sh scripts/install.sh --language zh-CN

# 安装英文版
sh scripts/install.sh --language en-US

# 指定宿主
sh scripts/install.sh --host claude-code

# 指定任意 Skill 目录
sh scripts/install.sh --destination '/path/to/skills'
```

### Windows

```powershell
# 自动识别用户级 Codex、Claude Code 或通用 Agent 目录，安装中文版
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Language zh-CN

# 安装英文版
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Language en-US

# 指定宿主
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -HostName codex

# 指定任意 Skill 目录
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Destination 'D:\path\to\skills'
```

支持的宿主名：`codex`、`claude-code`、`agents`。自动识别不到时使用通用的 `~/.agents/skills`。

## 方式三：手动复制

将中文目录 [`skills/open-x-sys.zh-CN/`](../skills/open-x-sys.zh-CN/) 完整复制到 AI 工具实际扫描的 Skill 目录，并把安装目录命名为 `open-x-sys`。英文版位于 [`skills/open-x-sys/`](../skills/open-x-sys/)。方法、引擎、系统模型、试验场和参考资料共同构成完整能力。

常见用户级目录：

| 宿主 | Skill 目录 |
| --- | --- |
| Codex | `~/.codex/skills/` |
| Claude Code | `~/.claude/skills/` |
| 通用 Agent | `~/.agents/skills/` |

不同版本的宿主可能允许项目级目录或自定义目录，以宿主当前文档和实际发现结果为准。

## 检查

```sh
sh scripts/install.sh --check
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Check
```

检查会报告目标位置、安装版本与语言版本，并保持现有文件原样。

## 更新

```sh
# 保持当前已安装的语言版本
sh scripts/install.sh --update

# 明确切换到中文版
sh scripts/install.sh --language zh-CN --update
```

```powershell
# 保持当前已安装的语言版本
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Update

# 明确切换到中文版
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Language zh-CN -Update
```

更新只替换 Skill 本身。原 Skill 会保存在同级的时间戳备份目录中。用户自己的 `~/.openxsys/`、项目 `.openxsys/`、作品与数据不属于安装目录，永远不会被更新器覆盖。

## 卸载

```sh
sh scripts/install.sh --uninstall
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/install.ps1 -Uninstall
```

卸载采用可恢复方式：把 `open-x-sys` 移到同级的时间戳备份目录，而不是永久删除。用户系统与成果保持原样。

## 校验下载

[`SHA256SUMS`](../dist/SHA256SUMS) 给出当前安装包的 SHA-256。macOS / Linux：

```sh
cd dist
shasum -a 256 -c SHA256SUMS
```

Windows：

```powershell
Get-FileHash -Algorithm SHA256 dist\open-x-sys-0.1.0-alpha.1-zh-CN.zip
Get-FileHash -Algorithm SHA256 dist\open-x-sys-0.1.0-alpha.1-en-US.zip
```

将结果与 `dist/SHA256SUMS` 对照，即可确认下载的安装包与正式发布一致。
