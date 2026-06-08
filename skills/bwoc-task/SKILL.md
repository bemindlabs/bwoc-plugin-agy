# bwoc-task

Manage a BWOC team's shared task list (add / list / claim / complete).

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user wants to add work to a team's shared backlog, see what's pending, or have an agent claim/complete a task.
- Teams come from `bwoc-team` (see `bwoc team list`).

## How to run

Read-only:
```bash
bwoc task list <team>
```

Mutating (confirm intent first):
```bash
bwoc task add <team> "<title>"
bwoc task claim <team> <task> --as <agent>
bwoc task complete <team> <task> --as <agent>
```

Arguments + flags (from `bwoc task <sub> --help`):
- `add <team> <title>` — `--deps <a,b>` gate on other task ids · `--id <ID>` explicit id (default `t<N>`) · `--requires-plan` gate completion on lead plan approval (Pavāraṇā).
- `list <team>` — `--json` for machine output.
- `claim <team> <task> --as <agent>` — claiming agent must be a team member.
- `complete <team> <task> --as <agent>` — completing agent must be the claimant.
- Also available: `plan`, `approve`, `reject` (Pavāraṇā plan-approval flow). Run `bwoc task --help` for details.
- Most subcommands accept `--workspace <PATH>` and `--json`.

## Example
```bash
bwoc task list saturn-six --json
bwoc task add saturn-six "Draft the API spec" --deps t1,t2
bwoc task claim saturn-six t3 --as agent-luban
```
