# 维护发布版本

[English](RELEASING.md) · [验证说明](VALIDATION.zh-CN.md)

版本记在 `VERSION`、两版 Skill 入口、两份依赖锁定文件与安装记录中。展示名称为 **0.0.1 Alpha Preview**，机器可读版本为 `0.0.1-alpha.1`。

## 技能包

源码变化后运行 `./scripts/package-skill.ps1`，再运行 `./scripts/check-release.ps1`。将生成的 ZIP、校验文件与发布信息连同源码一起提交。

## 官网

运行 `./scripts/build-site.ps1`，生成 `_site/`。其中保留官网、真实报告、图片、文档和下载包的相对路径。可以在本地打开根目录的 `index.html` 或 `site/index.html` 预览。

在 GitHub 仓库设置中选择用 GitHub Actions 发布 Pages 后，手动运行 Pages 工作流。参见 [GitHub 工作流说明](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)。获得公开网址后，将 README 的在线报告入口指向该网址；部署之前仍可下载完整双语报告查看。

## 公开发布

完成检查、提交完整源码，再建立 `v0.0.1-alpha.1` 标签。更新记录可用于 Release 说明，附件包含两个完整 Skill ZIP 与校验值。
