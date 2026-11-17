# Maintaining a release

[Chinese](RELEASING.zh-CN.md) · [Verification](VALIDATION.md)

The release version is recorded in `VERSION`, both Skill entries, both dependency lock files and the installation records. The public label is **0.0.1 Alpha Preview**; the machine-readable version is `0.0.1-alpha.1`.

## Packages

Run `./scripts/package-skill.ps1` after source changes, then `./scripts/check-release.ps1`. Commit the generated ZIPs, checksum file and release metadata together with the source.

## Website

Run `./scripts/build-site.ps1` to produce `_site/`. It includes the website, the actual report, images, documentation and downloadable packages with their relative paths intact. Open the root `index.html` or `site/index.html` locally to preview.

The Pages workflow is started manually after enabling GitHub Pages with GitHub Actions in the repository settings. See [GitHub's workflow guide](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages). Once a public website URL exists, use it for the README's live report links; the downloadable bilingual report is available before hosting.

## Public release

Run the release checks, commit the complete source and tag the release `v0.0.1-alpha.1`. Use the changelog for release notes and attach the two complete Skill ZIPs with their checksums.
