# bwoc-chat

Chat interactively with a BWOC agent — execs the agent's backend CLI with its manifest-driven model.

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user wants a back-and-forth interactive session with a specific agent.
- For one-shot captured results use `bwoc-run`; for async inbox drops use `bwoc-send`.

## How to run
This **execs an interactive backend session** (it replaces the current process / opens a terminal). Confirm the agent first via `bwoc-list`.

```bash
bwoc chat <name>
```

- `<name>` — agent by id (`agent-foo`) or bare name (`foo`).

Useful flags (from `bwoc chat --help`):
- `--tmux` — run under tmux (adds a window if already inside tmux, else starts a `bwoc-<id>` session).
- `--ghostty` — open a new Ghostty terminal window (macOS only).
- `--tui` — full-screen ratatui chat client (harness backends only: `ollama` / `openai-compatible`).
- `--team <TEAM>` — join a team's shared chat channel (requires `--tui` + harness backend; agent must be a team member).
- `--workspace <PATH>` — target a specific workspace root.

## Note for the Antigravity host
Because `bwoc chat` is interactive/exec-style, it is best launched in an attached terminal. TODO: confirm whether the Antigravity host can spawn an interactive PTY for a skill, or whether `--tmux` / `--ghostty` is the right launch path in this host — see the Antigravity plugins docs (https://antigravity.google/docs/plugins). For non-interactive delegation prefer `bwoc-run`.

## Example
```bash
bwoc chat agent-laojun --tmux
```
