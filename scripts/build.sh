#!/usr/bin/env bash
# Regenerate per-verb skill stubs from a template.
#
# This plugin is declarative: there is nothing to compile. "Build" means
# (re)generating a baseline skills/<name>/SKILL.md for each bwoc verb so the set
# stays in sync. Each generated stub is a THIN wrapper that points the host agent
# at the corresponding `bwoc` command; exact flags should be confirmed with
# `bwoc <verb> --help`.
#
# Usage:
#   bash scripts/build.sh           # only create stubs that are missing
#   bash scripts/build.sh --force   # overwrite every per-verb SKILL.md
#
# NOTE: the rich, hand-authored skills (already committed) are preferred. This
# generator exists so a new verb can be scaffolded in one line; run it, then flesh
# out the stub with the real flags from `bwoc <verb> --help`.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

# verb -> wrapped bwoc command (one line per verb).
VERBS=(
  "list|bwoc list|List the BWOC agent fleet (read-only)."
  "status|bwoc status|Per-agent health + identity snapshot (read-only)."
  "send|bwoc send|Append a message to an agent's inbox (mutating)."
  "run|bwoc run|Run a task headless and capture the result (runs the agent backend)."
  "chat|bwoc chat|Chat interactively with an agent (execs the backend)."
  "task|bwoc task|Manage a team's shared task list (add / list / claim / complete)."
  "team|bwoc team|Manage Saṅgha teams (create / list / retire)."
  "memory|bwoc memory|Read/write workspace-level deep memory."
)

gen_one() {
  local name="$1" cmd="$2" desc="$3"
  local dir="skills/bwoc-${name}"
  local out="${dir}/SKILL.md"
  mkdir -p "$dir"
  if [ -f "$out" ] && [ "$FORCE" -ne 1 ]; then
    echo "keep  $out (exists; use --force to overwrite)"
    return 0
  fi
  cat > "$out" <<EOF
# bwoc-${name}

${desc}

Thin wrapper over the \`bwoc\` CLI. \`bwoc\` must be on \`PATH\`.

## How to run
Discover exact flags with \`bwoc ${name} --help\`, then run:

\`\`\`bash
${cmd}
\`\`\`

Pass any user-provided text as a single quoted argument. Prefer \`--json\` when
you will parse or relay the output. Never invent agent/team ids — only use ids
returned by \`bwoc list\` / \`bwoc team list\`.
EOF
  echo "wrote $out"
}

for row in "${VERBS[@]}"; do
  IFS='|' read -r name cmd desc <<<"$row"
  gen_one "$name" "$cmd" "$desc"
done

echo "build: declarative plugin — skill stubs regenerated (no compile step)"
