# BWOC fleet delegation

Always-on guidance for delegating work to the BWOC agent fleet from Antigravity.

## Prerequisite
The `bwoc` CLI **must be installed and on `PATH`**, with a BWOC workspace reachable (cwd / ancestor walk / `BWOC_WORKSPACE` / `--workspace <PATH>`). If `bwoc list` fails, tell the user the CLI or workspace is unavailable instead of guessing.

## When to delegate
Prefer delegating to a BWOC agent when:
- The task maps to a specialist already in the fleet (run `bwoc list` to see who exists and on which backend).
- The user explicitly names an agent or team ("ask <agent>…", "have the <team> team…").
- The work is better run headless and reported back, or run async into an agent's inbox.

Do **not** delegate trivial local edits you can do directly; delegation is for fleet-appropriate work.

## How to delegate (thin wrappers over `bwoc`)
1. Discover: `bwoc list` (add `--json` to parse). Confirm health with `bwoc status <agent>`.
2. Choose the verb:
   - **Capture a result** → `bwoc run <agent> --task "<prompt>" --json` (the standard path).
   - **Async / fire-and-forget** → `bwoc send <agent> "<message>"`.
   - **Interactive** → `bwoc chat <agent>`.
   - **Team coordination** → `bwoc team …` to form/list teams, `bwoc task …` to add/claim/complete shared work.
   - **Shared context** → `bwoc memory …` to recall or persist.
3. Relay the agent's output back to the user faithfully; surface non-zero exit codes.

## Safety
- Never invent agent or team ids — only use ids returned by `bwoc list` / `bwoc team list`.
- Confirm intent before mutating verbs (`send`, `run`, `chat`, `task add/claim/complete`, `team create/retire`, `memory put/rm`).
- Pass user-provided text as a single quoted argument; never interpolate it into shell in a way that could re-tokenize.
- This plugin holds **no business logic** — it only shells out to `bwoc`. Logic belongs in the framework.
- When unsure of a flag, run `bwoc <verb> --help` rather than guessing.
