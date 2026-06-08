# bwoc-list

List the BWOC agent fleet registered in the enclosing workspace's `agents.toml`.

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user asks "what agents are there", "list the fleet", "who can I delegate to", or you need agent ids before `send`/`run`/`chat`.

## How to run
Read-only. Run:

```bash
bwoc list
```

Useful flags (from `bwoc list --help`):
- `--json` — machine-readable output (prefer this when parsing).
- `--status <STATUS>` — filter by status (`active`, `stopped`, `retired`).
- `--backend <BACKEND>` — filter by backend (`claude`, `antigravity`, `codex`, `kimi`, `copilot`, `ollama`, `openai-compatible`).
- `--running` — only agents whose daemon is actually running.
- `--inbox-pending` — only agents with pending inbox envelopes.
- `--names-only` — bare agent ids, one per line (good for loops).
- `--count` — just the count.
- `--sort <id|inbox|incarnated|backend>` — sort key.
- `--workspace <PATH>` — target a specific workspace root.

## Example
```bash
bwoc list --json --status active
bwoc list --names-only --backend claude
```

Report the agent ids/status back to the user; do not invent agents that are not listed.
