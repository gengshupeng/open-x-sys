# 安装 OpenXSys

[English](INSTALL.md) · [回到 README](../README.zh-CN.md)

## 交给你的 AI

直接把下面这段提示词复制给你的 AI，里面已包含项目地址；也可以提供[完整中文版技能包](../dist/open-x-sys.zh-CN.zip?raw=true)：

```text
请从项目仓库 https://github.com/gengshupeng/open-x-sys 安装 OpenXSys Skill。
请根据你当前所在的 AI 工具，安装完整中文版并完成可用性检查。
安装完成后告诉我已经准备就绪，我会直接说出自己的问题。
```

安装之后，可以直接说：

```text
用 OpenXSys，帮我研究人工智能这整个产业。
```

也可以直接说自己的问题、发来材料，或者指定一家公司、一个项目、一项技术。试验场、方法组合与学习模式都可以在想进一步探索时使用。

<a id="tools"></a>

## 你正在使用的工具

下面是给安装者查阅的入口。AI 根据当前工具提供的能力选择安装方式。

| 工具 | 安装入口 |
|---|---|
| WorkBuddy | 在技能管理中导入完整技能包；也可交给具备文件安装能力的 AI 处理。[官方技能说明](https://cloud.tencent.com/document/product/1831/134432) |
| 豆包工作 | 使用对话式安装或本地技能导入。[官方功能介绍](https://www.feishu.cn/content/article/7677519271848610746) |
| DSH / DeepSeek Harness | 使用当前环境中的技能安装能力，或把完整目录放到当前实例实际扫描的 Skill 目录。[官方入口](https://www.deepseek.com/harness/zh/) |
| Claude Code、Codex | 使用工具自己的 Skill 安装能力，或调用本仓库安装器，明确指定当前工具。 |
| 其他支持 Skill 的 AI 工具 | 优先使用它的技能导入、安装或管理入口，保持整个技能目录的结构。 |

当前阶段为 **Alpha Preview**。各工具的接入方式在这里汇总，实装与使用记录保存在 [evals](../evals/README.zh-CN.md)。

## 给安装任务中的 AI

### 识别当前环境

从当前会话、工具信息和现有配置确认你所在的 AI 工具，以及它发现 Skill 的方式。多种 AI 工具可以安装在同一台电脑上，安装目标对应当前正在使用的工具。

### 取得完整内容

- 从项目中安装中文时，来源是 `skills/open-x-sys.zh-CN/`；英文是 `skills/open-x-sys/`。
- 安装后的文件夹统一为 `open-x-sys/`，其中直接包含 `SKILL.md`、方法、路线、引擎、展示、系统与风格等完整子目录。
- 试验场材料单独放在仓库中，用户想进一步探索时再使用。
- 英文 ZIP 的根目录是 `open-x-sys/`；中文 ZIP 保留原包的 `open-x-sys.zh-CN/` 根目录。两包均含完整的 80 个运行时文件、版本信息与许可证，可直接选择对应 ZIP 导入。

### 使用当前工具的安装方式

工具有原生安装或导入能力时，直接使用它。可以访问本地文件的环境，也可以将完整目录复制到当前工具实际扫描的 Skill 位置。

本仓库的安装器支持 Windows、macOS、Linux，以及自定义 Skill 目录。给自动化任务调用时，`-Yes` 或 `--yes` 让已指定的安装任务直接执行；`-Check` 或 `--check` 用于查看安装结果。参数说明与锁定依赖见 [DEPENDENCIES.md](../skills/open-x-sys.zh-CN/deps/DEPENDENCIES.md)。

<details>
<summary>脚本方式：给 AI 和开发者</summary>

以下命令在仓库根目录执行。使用当前工具的名字；自定义目录时，把路径设为该工具实际扫描的 Skill 目录。

```powershell
# Windows：以 Codex 为例
powershell -NoProfile -ExecutionPolicy Bypass -File skills/open-x-sys/deps/install.ps1 -HostName codex -Lang zh-CN -Yes

# 已确认具体 Skill 目录时
powershell -NoProfile -ExecutionPolicy Bypass -File skills/open-x-sys/deps/install.ps1 -Dir '<Skill directory>' -Lang zh-CN -Yes
```

```sh
# macOS / Linux：以 Claude Code 为例
sh skills/open-x-sys/deps/install.sh --host claude-code --lang zh-CN --yes

# 已确认具体 Skill 目录时
sh skills/open-x-sys/deps/install.sh --dir '<Skill directory>' --lang zh-CN --yes
```

</details>

### 检查并交接给使用者

确认工具可以发现 `open-x-sys`，能读到 `SKILL.md` 及其支持文档。用本轮实际安装的位置与语言说明结果，告诉使用者现在可以直接提出自己的问题。

OpenXSys 的文本主体可以先使用当前 AI 已有的能力。网页、图表、文档、视频等成果会结合现有工具与已安装技能制作；外部依赖的当前状态见 [依赖说明](../skills/open-x-sys.zh-CN/deps/DEPENDENCIES.md)。

## 更新与卸载

可以直接对 AI 说：

```text
帮我更新 OpenXSys，保留我的系统、个人偏好和已有成果。
```

```text
帮我卸载 OpenXSys，保留我的系统和已有成果。
```

技能目录与使用者自己的 `.openxsys/`、工作文件和成果分别管理。安装器的 `-Uninstall` / `--uninstall` 用于移除安装的 Skill。

## 维护技能包

在仓库根目录运行 `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/package-skill.ps1`，重新生成两种语言的 ZIP；加 `-Check` 逐文件核对包内内容与当前来源。
