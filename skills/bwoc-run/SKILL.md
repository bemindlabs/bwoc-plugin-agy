# bwoc-run

Run a single task on a BWOC agent non-interactively and capture the result (headless mode).

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user wants an agent to do one task and return a result you can read back / parse — the standard delegation path.
- Use `bwoc-send` for fire-and-forget inbox drops; `bwoc-chat` for interactive sessions.

## How to run
This **executes the agent's backend** and produces output. Confirm the agent (via `bwoc-list`) and the task first.

```bash
bwoc run <agent> --task "<task prompt>"
```

- `<agent>` — agent by id (`agent-foo`) or bare name (`foo`).
- `--task <TASK>` — the task prompt (required). Pass user text exactly as a single quoted argument.

Useful flags (from `bwoc run --help`):
- `--json` — structured `{ agent, backend, task, exit_code, duration_ms, output }`; prefer this when relaying results.
- `--timeout <SECONDS>` — kill and report timeout if the agent runs longer.
- `--workspace <PATH>` — target a specific workspace root.

## Example
```bash
bwoc run agent-luban --task "Summarize the open issues in the framework repo" --json --timeout 600
```

Relay the captured `output` (and non-zero `exit_code`, if any) back to the user.
