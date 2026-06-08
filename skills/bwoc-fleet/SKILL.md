# bwoc-fleet

Coordination overview for driving the BWOC agent fleet from Antigravity.

This is the umbrella skill: it explains *which* `bwoc` verb to reach for. Every surface here is a thin wrapper over the `bwoc` CLI — no business logic lives in this plugin. `bwoc` must be installed and on `PATH`, with a BWOC workspace reachable (via cwd, ancestor walk, `BWOC_WORKSPACE`, or `--workspace <PATH>`).

## The fleet at a glance

```
Antigravity ──skill──▶ skill instructions ──exec──▶ bwoc CLI ──▶ BWOC workspace
                                                                 (agents, teams,
                                                                  tasks, memory)
```

Verify the fleet is reachable before delegating:
```bash
bwoc list
```

## Verb map — pick the right skill

| Intent | Skill | Wraps | Mutating? |
|---|---|---|---|
| See the fleet / get agent ids | `bwoc-list` | `bwoc list` | no |
| Check agent/fleet health | `bwoc-status` | `bwoc status` | no |
| Drop an async message in an inbox | `bwoc-send` | `bwoc send` | yes |
| One-shot delegate, capture result | `bwoc-run` | `bwoc run --task` | yes (runs backend) |
| Interactive session with an agent | `bwoc-chat` | `bwoc chat` | yes (execs backend) |
| Drive a team's shared task list | `bwoc-task` | `bwoc task` | mixed |
| Form / list / retire teams | `bwoc-team` | `bwoc team` | mixed |
| Read/write shared deep memory | `bwoc-memory` | `bwoc memory` | mixed |

## Recommended flow
1. `bwoc-list` to discover agents (and their backends/status).
2. `bwoc-status <agent>` to confirm health before heavy work.
3. Delegate:
   - need a result back → `bwoc-run <agent> --task "..." --json`
   - fire-and-forget → `bwoc-send <agent> "..."`
   - interactive → `bwoc-chat <agent>`
4. For multi-agent efforts: `bwoc-team` to form the team, `bwoc-task` to add/claim/complete work.
5. `bwoc-memory` to persist or recall shared context.

## Safety
- Prefer `--json` when you will parse or relay output.
- Confirm intent before any mutating verb (`send`, `run`, `chat`, `task add/claim/complete`, `team create/retire`, `memory put/rm`).
- Never invent agent ids — only use ids returned by `bwoc list`.
- Discover exact flags any time with `bwoc <verb> --help`.
