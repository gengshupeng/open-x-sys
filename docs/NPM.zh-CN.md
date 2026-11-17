# npm 分发

[English](NPM.md) · [安装说明](INSTALL.zh-CN.md)

官方 npm 包名为 `open-x-sys`。首个版本是 `0.0.1-alpha.1`，使用 `alpha` 标签分发。

包中包含完整中英文 Skill、两份可导入的 ZIP、许可证、文档与示例报告。Skill 内容与 ZIP 发行版一致。

## 让你的 AI 安装

把 npm 包页面发给你的 AI 工具，再复制：

```text
项目仓库：https://github.com/gengshupeng/open-x-sys
请从官方 npm 注册表下载 open-x-sys@0.0.1-alpha.1，按你所在 AI 工具的安装方式安装完整中文版 Skill。中文版目录是 skills/open-x-sys.zh-CN，可导入的 ZIP 是 dist/open-x-sys.zh-CN.zip。检查它是否可用，准备好后告诉我。
```

英文版使用完整的 `skills/open-x-sys` 目录，或 `dist/open-x-sys.zip`。

## 使用 npm 下载

```sh
npm pack open-x-sys@0.0.1-alpha.1
```

解压下载的 `.tgz`，再把对应语言的 Skill ZIP 或完整目录导入你的 AI 工具。下载 npm 包后，还需要按工具的安装方式启用 Skill。

本版本分发 Skill 文件，没有 `npx open-x-sys` 命令、自动安装钩子或必需的 npm 依赖。

## 维护 npm 包

在仓库根目录审阅文件清单，再发布已经检查过的包：

```sh
npm pack --dry-run --json --ignore-scripts
npm pack --ignore-scripts
npm publish open-x-sys-0.0.1-alpha.1.tgz --tag alpha --access public --ignore-scripts
```

发布命令供维护者在完成 npm 登录和注册表要求的账号验证后使用。包版本与 `VERSION` 保持一致，后续修改使用新版本号。
