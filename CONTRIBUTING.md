# Contributing

## Setup

The site is plain HTML and CSS with no build step. You need `make`, Node.js
(for `npx`), Go (for `make tools`) and [prek](https://github.com/j178/prek):

```bash
make tools      # gitleaks and fleetlint at the pinned versions
prek install    # git hooks from .pre-commit-config.yaml
```

Preview with `python -m http.server 8080` and open http://localhost:8080.

## Checks

`make check` is the definition of green: html-validate, stylelint, local asset
references, gitleaks and fleetlint. CI runs the same target. `make links`
additionally checks the docs.opencairn.org links (network).

## Commits and pull requests

Use [Conventional Commits](https://www.conventionalcommits.org/) (the
commit-msg hook enforces them). Work on a branch; `main` takes pull requests
only. A pull request should pass `make check`.

## Releases

Add a `CHANGELOG.md` section, then `make release V=vX.Y.Z` and push the tag:
the Gitea workflow deploys the site on `v*` tags.
