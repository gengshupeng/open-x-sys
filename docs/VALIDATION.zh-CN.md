# 验证说明

[English](VALIDATION.md) · [项目介绍](../README.zh-CN.md)

版本：**0.0.1 Alpha Preview**（`0.0.1-alpha.1`）。

## 可复现的发布检查

在仓库根目录使用 PowerShell 运行：

```powershell
./scripts/check-loading.ps1 -SelfTest
./scripts/package-skill.ps1 -Check
./scripts/check-release.ps1
./scripts/test-install.ps1
```

检查覆盖两版运行时与支持文档路径、检查器用例、技能包内容、版本一致性、本地链接与公开文件范围。技能包逐条比较 ZIP 内容与源码，包括发布版本文件。

`dist/release.json` 记录技能包语言、版本、文件数与 SHA-256；`dist/SHA256SUMS` 单独提供校验值。

## 安装与首次使用

发布检查会在隔离目录完成 ZIP 文件夹导入、替换更新和移除，与完整技能包核对配合使用。各 AI 工具通过自己的安装机制发现和运行 Skill，具体入口见[安装说明](INSTALL.zh-CN.md)。

[精选产业报告](../gallery/ai-industry/README.zh-CN.md)来自作者提供的真实运行。双语网页、图表、情景、复制与发现卡导出的界面检查，记录在案例说明中。

## 运行行为

记录真实运行时，一起保留工具、模型、版本、请求与实际成果。持续读取检查需要保留原始文件读取调用，与成果采用的方法逐项对照，并覆盖方法替换和新会话接续。运行提示以实际使用时出现的内容为准。

静态路径和技能包检查说明资源是否齐全，真实会话记录说明具体工具和模型怎样运用它们。新的记录可以通过[评估贡献](../evals/README.zh-CN.md)提交。
