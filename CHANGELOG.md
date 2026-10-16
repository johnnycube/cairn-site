# Changelog

All notable changes to the Cairn marketing site are documented here. The
format follows [Keep a Changelog](https://keepachangelog.com/). Dates are
ISO-8601. The site version tracks the Cairn release it presents.

## [Unreleased]

### Added
- Code of conduct (Contributor Covenant), issue and pull-request templates.

## [0.2.3] — 2026-10-15

### Changed
- The footer credits "The Cairn authors" instead of a person.

## [0.2.2] — 2026-10-15

### Changed
- "Who's behind Cairn" no longer names the author.

## [0.2.1] — 2026-10-15

Site unchanged; repository and deploy tooling only.

### Changed
- Deploys run through the shared `johnny/build` static-page workflow (v11)
  with SSH key auth; the workflow's actions are pinned by commit and keep no
  credentials on disk. Repository docs are no longer uploaded with the site.
- `make check` gates every change: HTML and CSS validation, local asset
  links, gitleaks and fleetlint. Renovate keeps the tool pins current.

## [0.2.0] — 2026-07-16

**First public release** of the site (static HTML + CSS, served at
https://opencairn.org), presenting Cairn v0.2.0.

### Added
- Landing page: why self-host, feature overview, architecture sketch,
  self-host pointers, roadmap, and links to the docs site and GitHub repos.
- Summit Teal theme matching the Cairn web UI; self-hosted fonts; no external
  requests.

[0.2.3]: https://github.com/johnnycube/cairn-site/releases/tag/v0.2.3
[0.2.2]: https://github.com/johnnycube/cairn-site/releases/tag/v0.2.2
[0.2.1]: https://github.com/johnnycube/cairn-site/releases/tag/v0.2.1
[0.2.0]: https://github.com/johnnycube/cairn-site/releases/tag/v0.2.0
