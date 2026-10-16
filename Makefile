# Task-runner contract (https://fleetlint.org/baseline/#task-runner-contract). `make check` is the definition of green.
SHELL := bash
.SHELLFLAGS := -euo pipefail -c
.ONESHELL:
.DEFAULT_GOAL := check-fast
MAIN_BRANCH ?= main
# Each pin carries a `# renovate:` comment so Renovate bumps it (customManagers in renovate.json).
# renovate: datasource=npm depName=html-validate
HTML_VALIDATE_VERSION ?= 11.16.2
# renovate: datasource=npm depName=stylelint
STYLELINT_VERSION     ?= 17.16.0
# renovate: datasource=go depName=github.com/zricethezav/gitleaks/v8
GITLEAKS_VERSION      ?= v8.30.1
# renovate: datasource=go depName=github.com/fleetlint/fleetlint
FLEETLINT_VERSION     ?= v0.5.1
NPX := npx --yes

.PHONY: help tools fmt lint test cover audit links check-fast check release

help: ## list targets
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | awk -F':.*##' '{printf "  %-12s %s\n", $$1, $$2}'

tools: ## install gitleaks and fleetlint (needs Go); html-validate and stylelint run via npx at the pinned versions
	go install github.com/zricethezav/gitleaks/v8@$(GITLEAKS_VERSION)
	go install github.com/fleetlint/fleetlint/cmd/fleetlint@$(FLEETLINT_VERSION)

# Hand-formatted HTML/CSS: whitespace and line endings only, no reflowing formatter
fmt: ## fix whitespace, final newlines and line endings
	prek run --all-files trailing-whitespace end-of-file-fixer mixed-line-ending

lint: ## validate HTML and CSS
	$(NPX) html-validate@$(HTML_VALIDATE_VERSION) index.html
	$(NPX) stylelint@$(STYLELINT_VERSION) styles.css

test: ## every local href/src in index.html exists
	missing=0
	for ref in $$(grep -oE '(href|src)="[^"]+"' index.html | sed -E 's/^(href|src)="//; s/"$$//; s/#.*$$//'); do
	  case "$$ref" in
	    ''|/|http:*|https:*|mailto:*) ;;
	    *) [ -f "$$ref" ] || { echo "missing asset: $$ref"; missing=1; } ;;
	  esac
	done
	exit $$missing

cover: test ## no program code to measure; same as test

audit: ## secrets in the history
	gitleaks git --no-banner --redact .

links: ## external docs links resolve (network; not part of check)
	for url in $$(grep -oE 'https://docs\.opencairn\.org[^"]*' index.html | sort -u); do
	  curl -fsSIL -o /dev/null "$$url" || { echo "broken link: $$url"; exit 1; }
	done

check-fast: lint test ## before every commit (< 30 s)

check: lint test audit ## definition of green
	fleetlint check --fail-on error

release: ## refuse dirty/non-main -> check -> signed tag V (needs a CHANGELOG.md section); pushing the tag deploys
	@test -n "$(V)" || { echo "usage: make release V=vX.Y.Z"; exit 1; }
	@test -z "$$(git status --porcelain)" || { echo "dirty tree"; exit 1; }
	@test "$$(git branch --show-current)" = "$(MAIN_BRANCH)" || { echo "not on $(MAIN_BRANCH)"; exit 1; }
	@grep -q "^## \[$(V:v%=%)\]" CHANGELOG.md || { echo "CHANGELOG.md has no '## [$(V:v%=%)]' section"; exit 1; }
	$(MAKE) check
	git tag -s "$(V)" -m "$(V)"
	@echo "tagged $(V); push with: git push origin $(V)"
