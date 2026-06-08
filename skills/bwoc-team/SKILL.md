# bwoc-team

Manage Saṅgha teams — a named subset of BWOC agents sharing a task list.

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user asks "what teams exist", or wants to form / retire a team for a coordinated effort.
- Pair with `bwoc-task` to drive the team's shared task list.

## How to run

Read-only:
```bash
bwoc team list
```

Mutating (confirm intent first):
```bash
bwoc team create <id> --members <a,b,c>
bwoc team retire <id>
```

Arguments + flags (from `bwoc team <sub> --help`):
- `list` — members + task counts. `--json` for machine output.
- `create <id>` — `<id>` kebab-case by convention · `--members <a,b,c>` comma-separated agent ids · `--json`.
- `retire <id>` — removes the membership file + task list.
- Subcommands accept `--workspace <PATH>`.

## Example
```bash
bwoc team list --json
bwoc team create <team> --members <agent>,<agent>,<agent>
```

Note: add/remove individual members by editing `.bwoc/teams/<team>.toml` directly — there is no member-add subcommand.
