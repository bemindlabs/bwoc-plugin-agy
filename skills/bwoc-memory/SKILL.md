# bwoc-memory

Read and write workspace-level deep memory (`.bwoc/memory/`).

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user asks "what do we know about X", "remember this", or you want shared context that persists across agents/sessions.

## How to run

Read-only:
```bash
bwoc memory list
bwoc memory show <name>        # one entry; or --all for every entry concatenated
bwoc memory search "<query>"   # case-insensitive substring search
```

Mutating (confirm intent first):
```bash
bwoc memory put <name> "<content>"   # inline content > --file > stdin
bwoc memory rm <name>                # prompts on TTY unless --yes
```

Arguments + flags (from `bwoc memory <sub> --help`):
- `list` — `--json` · `--count` · `--names-only` · `--sort <name|size|modified>`.
- `show [name]` — `--all` (concatenate every entry) · `--json` (only meaningful with `--all`).
- `search <query>` — `--json`.
- `put <name> [content]` — `--file <FILE>` · `--force` (overwrite) · `--append` (append, newline-separated).
- `rm <name>` — `--yes` to skip the prompt.
- Tier-2 deep memory: `wake-up` (emit prior context at session start), `t2-search "<query>"`, `mine <path> --mode <mode>`.
- Subcommands accept `--workspace <PATH>`.

## Example
```bash
bwoc memory search "export pipeline" --json
bwoc memory put decisions-2026 "Chose Wan2.2 for i2v" --append
```
