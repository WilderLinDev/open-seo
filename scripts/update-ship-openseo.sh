#!/usr/bin/env bash
set -euo pipefail

# One-command upgrade & redeploy for Ship OpenSEO (zero-upstream-diff workflow).
# Usage: ./scripts/update-ship-openseo.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: working tree has uncommitted changes. Commit or stash them before upgrading." >&2
  exit 1
fi

if [[ ! -f ".env.selfhost" ]]; then
  echo "Error: .env.selfhost not found in $ROOT_DIR." >&2
  exit 1
fi

echo "==> 1/5 Fetching upstream (every-app/open-seo)..."
git fetch upstream

echo "==> 2/5 Merging upstream/main into current branch..."
git merge --no-edit upstream/main

echo "==> 3/5 Installing dependencies..."
pnpm install

echo "==> 4/5 Building & deploying to Cloudflare (Alchemy selfhost)..."
pnpm deploy:selfhost --yes

echo "==> 5/5 Pushing updated branch to origin..."
git push origin HEAD

echo "Done! Verify health at: https://openseo.lotorlabs.com/api/health"
