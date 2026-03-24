# mason-skills

> Public `mason-*` skill warehouse for Codex / Claude Code style workflows.

English | [中文](./README.md)

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Skills](https://img.shields.io/badge/skills-3-blue.svg)
![Status](https://img.shields.io/badge/status-active-orange.svg)

## ✨ Features

- 🧭 **Router vs Wrench**: decide whether a skill is a router or an execution wrench before writing it
- ⚔️ **A/B first for router skills**: compress complexity into one dominant contradiction before execution
- 🖥️ **Terminal supervision**: manage long-running tasks with `tmux + status.json + inbox.jsonl`
- 🔍 **Explicit config checks**: each public skill documents a configuration checklist and usage path
- 🚫 **No fake acceptance**: only real artifacts and real runtime evidence count

## 📦 Public skills in the first release

### 1. `mason-claudeception-ab`
Turns real session learnings into reusable `mason-*` skills.
Its first job is classification:
- Router
- Wrench

Only router skills get an internal A/B split. Wrench skills stay linear.

### 2. `mason-article-router`
Routes vague “write it in Mason style” requests into:
- Route A / Opinion
- Route B / Explainer

This prevents mixed first drafts that are neither sharp nor clear.

### 3. `mason-terminal-supervisor`
Scripted supervision for long-running terminal work using:
- `start.sh`
- `status.sh`
- `send.sh`
- `capture.sh`

Core runtime outputs:
- `.runtime/terminal-supervisor/<name>/status.json`
- `.runtime/terminal-supervisor/<name>/inbox.jsonl`
- `.runtime/terminal-supervisor/<name>/output.log`

## 🚀 Quick start

### Install

Copy the skills you want into your local skill directory:

```bash
mkdir -p ~/.codex/skills
cp -R skills/mason-article-router ~/.codex/skills/
cp -R skills/mason-claudeception-ab ~/.codex/skills/
cp -R skills/mason-terminal-supervisor ~/.codex/skills/
```

Or install them into a project-local skill directory:

```bash
mkdir -p .claude/skills
cp -R skills/mason-article-router .claude/skills/
```

### Basic usage

#### `mason-claudeception-ab`
Use when you want to extract a new skill from real context.

#### `mason-article-router`
Use when a request needs to be routed into opinion vs explainer first.

#### `mason-terminal-supervisor`
Use when you want to supervise a long-running terminal task.

```bash
./skills/mason-terminal-supervisor/scripts/start.sh demo 'for i in {1..5}; do echo step:$i; sleep 1; done'
./skills/mason-terminal-supervisor/scripts/status.sh demo
./skills/mason-terminal-supervisor/scripts/send.sh demo note 'do not deploy yet; capture screenshots first'
./skills/mason-terminal-supervisor/scripts/capture.sh demo
```

## ⚙️ Configuration

Each public skill includes:
- `Configuration checklist`
- `How to use`

This repository documents only portable configuration facts:
- required CLI/runtime tools
- writable directories
- persisted runtime artifacts
- what must never be committed

It does **not** include:
- tokens
- cookies
- API keys
- credentialed private endpoints
- private production paths

## 📚 Documentation

- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [USAGE_AND_MAINTENANCE.md](./USAGE_AND_MAINTENANCE.md)
- [docs/naming.md](./docs/naming.md)
- [docs/inclusion-criteria.md](./docs/inclusion-criteria.md)
- [TODOS.md](./TODOS.md)

## 🛠️ Development

### Local validation

```bash
find skills -path '*/scripts/*.sh' -print0 | xargs -0 -I{} bash -n '{}'
find skills -path '*/scripts/*.py' -print0 | xargs -0 -I{} python3 -m py_compile '{}'
```

### Repo principles

- do not commit `.runtime/`
- do not commit secrets or credentials
- do not turn one-off chat residue into a skill
- preserve clear boundaries over broad ambition

## 🗺️ Scope of the first public release

This first release intentionally publishes only the 3 skills that are already portable enough.
The more complex `issue-managed-*` workflow is held back for another iteration because it still carries stronger local workflow assumptions.

## ✅ Automated validation

This repository includes a GitHub Actions workflow for:
- shell syntax validation
- Python script compilation checks
- fast secret / local-path scanning

## 🤝 Contributing

Contributions welcome for:
- tighter skill boundaries
- docs clarification
- compatibility fixes
- shell / tmux portability improvements

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## 📧 Contact

- GitHub: [@mason0510](https://github.com/mason0510)
- Issues: please use GitHub Issues in this repository

## 📄 License

MIT License — see [LICENSE](./LICENSE)
