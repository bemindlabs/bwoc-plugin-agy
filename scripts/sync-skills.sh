#!/usr/bin/env bash
# Re-export BWOC framework skills as Antigravity skills.
#
# Generic generator — ships NO skill content of its own. It discovers the
# framework skills from a live BWOC workspace and emits a thin Antigravity
# skill per framework skill at skills/fw-<name>/SKILL.md. The generated
# fw-* dirs are gitignored; run this locally to populate them.
#
# Each generated skill is a pointer: it tells the Antigravity agent that the
# named BWOC framework skill exists, what it exposes, and where its SPEC lives.
#
# Requires BWOC_WORKSPACE (no default). `bwoc` and `jq` must be on PATH.
set -euo pipefail

if [ -z "${BWOC_WORKSPACE:-}" ]; then
  echo "ERROR: BWOC_WORKSPACE is required (path to a BWOC workspace/framework root)" >&2
  echo "usage: BWOC_WORKSPACE=/path/to/workspace bash scripts/sync-skills.sh" >&2
  exit 2
fi

command -v bwoc >/dev/null 2>&1 || { echo "ERROR: bwoc not found on PATH" >&2; exit 2; }
command -v jq   >/dev/null 2>&1 || { echo "ERROR: jq not found on PATH"   >&2; exit 2; }

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

list_json="$(bwoc skill list --workspace "$BWOC_WORKSPACE" --json)"
names="$(printf '%s' "$list_json" | jq -r '.skills[].name')"

count=0
while IFS= read -r name; do
  [ -n "$name" ] || continue

  show_json="$(bwoc skill show "$name" --workspace "$BWOC_WORKSPACE" --json)"
  desc="$(printf '%s' "$show_json"  | jq -r '.skill.description // ""')"
  spec="$(printf '%s' "$show_json"  | jq -r '.skill.spec_path  // ""')"
  exposes="$(printf '%s' "$show_json" | jq -r '.skill.exposes // [] | .[]')"

  dir="skills/fw-${name}"
  mkdir -p "$dir"

  {
    echo "---"
    echo "name: bwoc-fw-${name}"
    echo "description: ${desc}"
    echo "---"
    echo
    echo "# bwoc-fw-${name}"
    echo
    echo "Re-exports the BWOC framework skill \`${name}\`."
    echo
    echo "## Purpose"
    echo
    echo "${desc}"
    echo
    if [ -n "$exposes" ]; then
      echo "## Exposes"
      echo
      while IFS= read -r op; do
        [ -n "$op" ] || continue
        echo "- \`${op}\`"
      done <<< "$exposes"
      echo
    fi
    echo "## Reference"
    echo
    echo "Full contract lives in the framework: \`modules/skills/${name}/SPEC.md\`."
    if [ -n "$spec" ]; then
      echo
      echo "Resolved on the generating workspace at: \`${spec}\`."
    fi
  } > "${dir}/SKILL.md"

  count=$((count + 1))
done <<< "$names"

echo "sync-skills: wrote ${count} re-exported skill(s) under skills/fw-*"
