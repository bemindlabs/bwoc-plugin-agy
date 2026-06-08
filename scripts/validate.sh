#!/usr/bin/env bash
# Validate the Antigravity plugin's JSON manifests.
# Thin checks only — every behavioral surface is a wrapper over the `bwoc` CLI.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0

require_jq() {
  if ! command -v jq >/dev/null 2>&1; then
    echo "ERROR: jq not found on PATH" >&2
    exit 2
  fi
}

check_json() {
  local f="$1"
  if [ ! -f "$f" ]; then
    echo "SKIP  $f (not present)"
    return 0
  fi
  if jq . "$f" >/dev/null 2>&1; then
    echo "OK    $f"
  else
    echo "FAIL  $f (invalid JSON)"
    fail=1
  fi
}

require_jq

# Required marker manifest.
if [ ! -f plugin.json ]; then
  echo "FAIL  plugin.json missing (required plugin marker)"
  fail=1
else
  check_json plugin.json
fi

# Optional JSON manifests.
check_json hooks.json
check_json mcp_config.json

# Every skill must ship a SKILL.md.
for d in skills/*/; do
  [ -d "$d" ] || continue
  if [ -f "${d}SKILL.md" ]; then
    echo "OK    ${d}SKILL.md"
  else
    echo "FAIL  ${d} missing SKILL.md"
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "validate: FAILED" >&2
  exit 1
fi
echo "validate: OK"
