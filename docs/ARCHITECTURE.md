# Architecture

The Cairn marketing site at https://opencairn.org: one static page, no build
step, no JavaScript, no external requests.

## Components

- `index.html`: the landing page (features, architecture sketch, self-host
  pointers, roadmap, links to docs.opencairn.org and the GitHub repositories).
- `styles.css`: the slate + Summit Teal theme shared with the Cairn web UI.
- `assets/`: self-hosted fonts and the dashboard screenshot.

## Delivery

```
push v* tag ──> Gitea Actions (.gitea/workflows/deploy.yml)
                 check job: asset references, upload repo content as artifact
                 deploy job: johnny/build deploy-static-page (rsync over SSH)
                 ──> web root behind opencairn.org
```

GitHub Actions (`.github/workflows/check.yml`) runs `make check` on pushes and
pull requests; it does not deploy.

## Decisions

1. **Static files, no generator.** One page does not justify a build chain;
   what is in the repository is what is served.
2. **Self-hosted fonts, no third-party requests.** Privacy and no consent
   banner; the page works offline.
3. **Tag-triggered deploy via the shared johnny/build workflow.** Deploy logic
   and SSH secrets live in one place for all static sites.
