---
status: accepted
---

# Keep zero upstream code diff and use native password auth

We deploy `WilderLinDev/open-seo` to `openseo.lotorlabs.com` with zero modifications to upstream `every-app/open-seo` files: Cloudflare resources keep upstream's default `open-seo-selfhost` names and authentication uses native `AUTH_MODE=password`.

## Considered Options

- **Patch upstream Alchemy naming and enable Google OAuth in password mode**: rejected because upstream hardcodes `WORKER_PREFIX = "open-seo"` and restricts Better Auth Google sign-in to `hosted` mode, so patching either creates ongoing merge risk whenever upstream updates.
- **Cloudflare Access (`AUTH_MODE=cloudflare_access`) with Google IdP**: rejected because it adds Zero Trust setup and requires extra Managed OAuth configuration for MCP clients, whereas `AUTH_MODE=password` works out of the box with MCP clients.

## Consequences

- `git fetch upstream && git merge upstream/main` stays conflict-free because our fork only adds untracked-by-upstream operational files (`scripts/update-open-seo.sh`, `GLOSSARY.md`, `docs/adr/`).
- In the Cloudflare dashboard, resources appear under `open-seo-selfhost*` while end users and MCP clients only interact with `https://openseo.lotorlabs.com`.
- Changing `AUTH_MODE` or `CUSTOM_DOMAIN` later is disruptive (separate user records / invalidated sessions), so both are fixed before first deployment.
