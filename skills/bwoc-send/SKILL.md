# bwoc-send

Append a message to a BWOC agent's inbox (`.bwoc/inbox.jsonl`).

Thin wrapper over the `bwoc` CLI. `bwoc` must be on `PATH`.

## When to use
- The user wants to hand an agent a message/task asynchronously (fire-and-forget into its inbox), or do agent → agent messaging.
- For a blocking, captured result use `bwoc-run` instead; for an interactive session use `bwoc-chat`.

## How to run
This is a **mutating** command (writes to the recipient's inbox). Confirm intent and the recipient first (use `bwoc-list`).

```bash
bwoc send <to> "<message>"
```

- `<to>` — recipient agent, by id (`agent-foo`) or bare name (`foo`).
- `<message>` — message text; quote multi-word. Pass user-provided text exactly as a single quoted argument.

Useful flags (from `bwoc send --help`):
- `--file <FILE>` — read the message body from a file (mutually exclusive with the inline message).
- `--from <FROM>` — sender identity (default `user`); pass an agent id for agent → agent messaging.
- `--reply-to <MESSAGE_ID>` — thread this as a reply to a prior envelope (`msg-<slug>-<hex>`).
- `--no-wakeup` — skip the tmux send-keys wakeup ping.
- `--workspace <PATH>` — target a specific workspace root.

## Example
```bash
bwoc send agent-luban "Build the export pipeline and open a PR"
bwoc send agent-yanluo --file ./brief.md --from agent-luban
```
