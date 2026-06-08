# Skills

Antigravity skills for this plugin. Each skill is `skills/<name>/SKILL.md`.

## Committed: `skills/bwoc-*`

Coordination skills that wrap the `bwoc` CLI (`list`, `status`, `send`, `run`,
`chat`, `task`, `team`, `memory`, `fleet`). These are hand-authored and tracked
in git.

## Generated: `skills/fw-*` (gitignored)

The `skills/fw-*` directories are **re-exports of BWOC framework skills**,
generated locally — they are **not** committed (see `.gitignore`).

Generate them by pointing the script at a BWOC workspace:

```bash
BWOC_WORKSPACE=/path/to/bwoc-workspace bash scripts/sync-skills.sh
```

For each framework skill (`bwoc skill list`), this writes
`skills/fw-<name>/SKILL.md` — a thin pointer carrying the skill's name,
description, exposed operations, and a reference to its
`modules/skills/<name>/SPEC.md`. The plugin ships only the generator, never the
generated content, so the connector stays generic and workspace-neutral.
