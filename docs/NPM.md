# npm distribution

[Chinese](NPM.zh-CN.md) · [Installation](INSTALL.md)

The official npm package is `open-x-sys`. Its first version is `0.0.1-alpha.1`, distributed with the `alpha` tag.

The package contains the complete English and Chinese Skills, both importable ZIPs, the license, documentation and the example report. The Skill content is the same as the ZIP distribution.

## Ask your AI to install

Share the npm package page with your AI tool and copy:

```text
Please download open-x-sys@0.0.1-alpha.1 from the official npm registry and install the complete English Skill using this AI tool's installation method. The English Skill folder is skills/open-x-sys, and its importable ZIP is dist/open-x-sys.zip. Check that it is available, then tell me it is ready.
```

For Chinese, use the complete `skills/open-x-sys.zh-CN` folder or `dist/open-x-sys.zh-CN.zip` instead.

## Download with npm

```sh
npm pack open-x-sys@0.0.1-alpha.1
```

Extract the downloaded `.tgz`, then import the appropriate Skill ZIP or complete Skill folder into your AI tool. Downloading an npm package does not register a Skill with an AI tool automatically.

This version distributes Skill files. It has no `npx open-x-sys` command, install hooks or required npm dependencies.

## Maintain the package

From the repository root, review the file list and publish the checked tarball:

```sh
npm pack --dry-run --json --ignore-scripts
npm pack --ignore-scripts
npm publish open-x-sys-0.0.1-alpha.1.tgz --tag alpha --access public --ignore-scripts
```

The publish command is for maintainers after npm login and the registry's required account verification. Keep package versions aligned with `VERSION`; use a new version for later changes.
