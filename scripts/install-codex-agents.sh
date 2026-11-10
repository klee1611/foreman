#!/usr/bin/env bash
# Copies Foreman's Codex subagents into ~/.codex/agents/.
# Codex plugins ship skills; custom agents live as TOML files in that folder.
set -euo pipefail

SRC="$(cd "$(dirname "$0")/.." && pwd)/codex/agents"
DEST="${CODEX_HOME:-$HOME/.codex}/agents"

mkdir -p "$DEST"
for f in "$SRC"/*.toml; do
  name="$(basename "$f")"
  if [ -e "$DEST/$name" ] && [ "${1:-}" != "--force" ]; then
    echo "skip   $DEST/$name (exists; rerun with --force to overwrite)"
  else
    cp "$f" "$DEST/$name"
    echo "copied $DEST/$name"
  fi
done

echo
echo "Done. Start a new Codex session so the agents are loaded."
