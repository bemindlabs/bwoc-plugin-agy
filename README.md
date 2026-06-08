# bwoc-plugin-agy

> **BWOC → Antigravity plugin adapter.** Exposes the BWOC agent fleet — coordination CLI, agents-as-subagents, skills, and deep-memory — into **Antigravity** by wrapping the `bwoc` CLI.

**Status:** 🚧 WIP scaffold.
Part of the BWOC **八仙過海・各顯神通** host-adapter set (Eight Immortals crossing the sea — each adapter crosses into a foreign host by its own plugin format).

**Steward:** `agent-zhangguolao` (Zhang Guolao 張果老) — debased to this project ([`bwoc debase`](https://github.com/bemindlabs/BWOC-Framework)).

## What it exposes

| Surface | Wraps |
|---|---|
| Coordination | `bwoc list / status / send / run / chat / task / team` |
| Agents | BWOC `agents/agent-*` re-exported as Antigravity sub-agents |
| Skills | BWOC skills re-exported as Antigravity skills |
| Deep-memory | `bwoc memory` bridge |

Mechanism: **shell-out to the `bwoc` CLI** — no standing server. The host must have `bwoc` on `PATH`.

## Manifest

Host plugin manifest: `plugin.json`

## License

MIT © Bemind Technology
