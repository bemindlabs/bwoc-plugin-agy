<h1 align="center">bwoc-plugin-agy</h1>

<p align="center">
  <strong>BWOC → Antigravity</strong> plugin adapter — bring the BWOC agent fleet into <a href="https://antigravity.google">Google Antigravity</a>.
</p>

<p align="center">
  <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg">
  <img alt="Status" src="https://img.shields.io/badge/status-WIP-orange">
  <img alt="Host" src="https://img.shields.io/badge/host-Antigravity-4285f4">
  <img alt="Part of BWOC" src="https://img.shields.io/badge/part%20of-BWOC%20%E5%85%AB%E4%BB%99-6f42c1">
  <img alt="Mechanism" src="https://img.shields.io/badge/mechanism-wraps%20bwoc%20CLI-informational">
</p>

---

## ✨ Overview

`bwoc-plugin-agy` packages the [**BWOC**](https://github.com/bemindlabs/BWOC-Framework) agent fleet as a **Google Antigravity plugin** — skills, rules, hooks, and (optionally) MCP servers that let Antigravity's agent drive your BWOC workspace: list agents, send work, run headless tasks, coordinate teams, and read shared memory.

It is **declarative + shell-out**: every skill wraps the `bwoc` CLI. No background server, no daemon.

> [!NOTE]
> **Status: WIP.** Manifest and layout are in place; skill/rule bodies are landing incrementally. See the [roadmap](#️-roadmap).

## 🧩 What it exposes

| Surface | BWOC capability | Wraps |
|---|---|---|
| **Skills** | Coordinate the fleet | `bwoc list` · `status` · `send` · `run` · `chat` · `task` · `team` |
| **Rules** | Always-on guidance | how/when to delegate to the fleet |
| **Skills** | Reuse BWOC skills | BWOC skills re-exported as `skills/<name>/SKILL.md` |
| **Memory** | Shared deep-memory | `bwoc memory` bridge |

## 🏗️ How it works

```
Antigravity  ──skill──▶  skill instructions  ──exec──▶  bwoc CLI  ──▶  BWOC workspace
                                                                       (agents, teams,
                                                                        tasks, memory)
```

Every surface is a thin wrapper over a `bwoc` subcommand. Works in both the Antigravity IDE and CLI.

## 📋 Prerequisites

- [Google Antigravity](https://antigravity.google) (IDE or CLI)
- The [`bwoc` CLI](https://github.com/bemindlabs/BWOC-Framework) installed and on `PATH`
- A BWOC workspace (`bwoc init`) reachable from where Antigravity runs

## 📦 Installation

Antigravity loads plugins from a `plugin.json`-marked directory. Drop this repo in at workspace or global scope:

```bash
# workspace scope
git clone https://github.com/bemindlabs/bwoc-plugin-agy .agents/plugins/bwoc

# global scope
git clone https://github.com/bemindlabs/bwoc-plugin-agy ~/.gemini/config/plugins/bwoc
```

## 🚀 Usage

```text
"List the BWOC agents"                    # routed via the bwoc skill
"Send <agent> a task to build X"      # bwoc send
"Run <agent> headless and report"     # bwoc run
```

## 🗂️ Repository layout

```
bwoc-plugin-agy/
├── plugin.json              # marker manifest (name optional; defaults to dir)
├── skills/                  # skills wrapping `bwoc` (skills/<name>/SKILL.md)
├── rules/                   # always-on rules (rules/<name>.md)
├── mcp_config.json          # optional MCP server definitions
├── hooks.json               # optional hooks
└── scripts/                 # validate.sh / build.sh
```

## 🛠️ Development

```bash
bash scripts/validate.sh     # validate plugin.json
bash scripts/build.sh        # regenerate the host tree from the live workspace
prettier --check .           # lint
```

## 🗺️ Roadmap

- [x] Scaffold: manifest, README, license
- [ ] Coordination skills (`list/status/send/run/chat/task/team`)
- [ ] Delegation rule (`rules/bwoc-delegation.md`)
- [ ] Skill re-export from BWOC skills
- [ ] Deep-memory skill
- [ ] Smoke test in Antigravity IDE + CLI

## 🌊 The Eight Immortals host-adapter set

One of five BWOC → host adapters — **八仙過海・各顯神通** (the Eight Immortals cross the sea, each by their own power):

| Host | Repo | Steward |
|---|---|---|
| Claude Code | [bwoc-plugin-claude](https://github.com/bemindlabs/bwoc-plugin-claude) | 呂洞賓 Lü Dongbin |
| OpenAI Codex | [bwoc-plugin-codex](https://github.com/bemindlabs/bwoc-plugin-codex) | 曹國舅 Cao Guojiu |
| **Antigravity** | [bwoc-plugin-agy](https://github.com/bemindlabs/bwoc-plugin-agy) | 張果老 Zhang Guolao |
| OpenClaw | [bwoc-plugin-openclaw](https://github.com/bemindlabs/bwoc-plugin-openclaw) | 鐵拐李 Li Tieguai |
| Hermes | [bwoc-plugin-hermes](https://github.com/bemindlabs/bwoc-plugin-hermes) | 漢鍾離 Han Zhongli |

## 🙏 Maintainer

Maintained by **Bemind Technology**, part of the BWOC host-adapter set. This connector is **generic**: it ships no agents, teams, or workspace identities of its own — it discovers your fleet from the local `bwoc` workspace at runtime.

## 🤝 Contributing

Issues and PRs welcome. Keep the plugin a **thin wrapper over the `bwoc` CLI** — logic belongs in the framework, not here.

## 📄 License

[MIT](LICENSE) © Bemind Technology
