# cairn-site

The marketing / showcase site for [Cairn](https://github.com/johnnycube/cairn-core)
— a self-hosted, multi-source activity tracker. Served at https://opencairn.org;
docs live at https://docs.opencairn.org.

It's a **static site** (plain HTML + CSS, no build step), themed with the same
slate + Summit Teal palette as the Cairn web UI. Charts shown in the dashboard
screenshot keep their own series colors.

## Develop / preview

Just open `index.html`, or serve the folder:

```bash
python -m http.server 8080   # then open http://localhost:8080
```

## Deploy

Copy the folder to any static host (Caddy/nginx, object storage + CDN, Pages,
etc.). There is nothing to compile.

```
index.html      the landing page
styles.css      slate + Summit Teal theme
assets/         screenshots (dashboard.png rendered from the real teal UI)
```

The dashboard screenshot is regenerated from the live web UI — replace
`assets/dashboard.png` with a fresh capture when the UI changes.

## License

AGPL-3.0, matching Cairn core. See [LICENSE](LICENSE).
