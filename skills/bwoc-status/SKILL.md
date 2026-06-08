# bwoc-status

Show a per-agent health + identity snapshot for the BWOC fleet (read-only).

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user asks "is agent-X healthy", "what's the status of the fleet", or before sending heavy work to an agent.

## How to run
Read-only. Run:

```bash
bwoc status            # per-agent table summary
bwoc status <name>     # full detail block for one agent (id "agent-foo" or bare "foo")
```

Useful flags (from `bwoc status --help`):
- `--all` — full detail block for every agent (mutually exclusive with `<name>` and `--banner`).
- `--banner` — replay a named agent's startup liveness banner (requires a named agent).
- `--json` — machine-readable output.
- `--workspace <PATH>` — target a specific workspace root.

## Example
```bash
bwoc status <agent> --json
bwoc status --all
```
