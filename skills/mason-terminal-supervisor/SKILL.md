---
name: mason-terminal-supervisor
description: This skill should be used when the user asks to "管理终端", "查看终端进度", "插话终端", "中断任务", "terminal-supervisor", "tmux status inbox", or wants to supervise long-running terminal work through tmux, status files, and inbox commands instead of manually driving iTerm.
author: Codex
version: 1.0.0
date: 2026-03-24
---

# Mason Terminal Supervisor

Use tmux as the carrier, but manage **task sessions** instead of GUI terminal windows.

## Script Directory

All helper scripts live in `scripts/` under this skill directory.

## Configuration checklist

Before using this skill, check:
- `bash`, `tmux`, and `jq` are installed
- current working directory is the target repo / workspace where `.runtime/` should be created
- the target repo is writable
- operators understand that queued commands and output are persisted to `output.log` and `inbox.jsonl`
- no secrets are pasted into commands unless you accept them being written into runtime logs

Optional environment knobs:
- `TS_ROOT` — override runtime directory root
- `TS_PREFIX` — override tmux session prefix

## How to use

1. `start.sh` a managed session in the target repo.
2. Use `status.sh` to inspect state and recent output.
3. Use `send.sh` to queue `note`, `exec`, `replace`, `interrupt`, or `abort`.
4. Use `capture.sh` when pane output is needed.
5. Keep git clean by not committing `.runtime/` artifacts.

| Script | Purpose |
|--------|---------|
| `scripts/start.sh` | Start a managed tmux session |
| `scripts/status.sh` | Read status + recent output |
| `scripts/send.sh` | Queue note / exec / replace / interrupt / abort |
| `scripts/capture.sh` | Capture recent tmux pane output |
| `scripts/worker.sh` | Background worker loop |
| `scripts/common.sh` | Shared helpers |

## What this skill provides

- Managed tmux session per task
- `status.json` heartbeat per session
- `inbox.jsonl` for control instructions
- `output.log` for command output
- Interrupt / replace / abort without UI automation

## Session layout

For session `<name>`:

- `.runtime/terminal-supervisor/<name>/status.json`
- `.runtime/terminal-supervisor/<name>/inbox.jsonl`
- `.runtime/terminal-supervisor/<name>/output.log`
- tmux session: `ts-<name>`

## Commands

### Start a managed session

```bash
./skills/mason-terminal-supervisor/scripts/start.sh demo
```

With an initial command:

```bash
./skills/mason-terminal-supervisor/scripts/start.sh demo 'for i in {1..20}; do echo step:$i; sleep 1; done'
```

### Read status

```bash
./skills/mason-terminal-supervisor/scripts/status.sh demo
```

### Send instructions

Queue a command:

```bash
./skills/mason-terminal-supervisor/scripts/send.sh demo exec 'echo hello'
```

Replace current job:

```bash
./skills/mason-terminal-supervisor/scripts/send.sh demo replace 'echo new job'
```

Interrupt current job:

```bash
./skills/mason-terminal-supervisor/scripts/send.sh demo interrupt
```

Add a note / side instruction:

```bash
./skills/mason-terminal-supervisor/scripts/send.sh demo note '先不要部署，先验收截图'
```

Abort the whole managed session:

```bash
./skills/mason-terminal-supervisor/scripts/send.sh demo abort
```

### Capture pane output

```bash
./skills/mason-terminal-supervisor/scripts/capture.sh demo
```

## Rules

- Prefer inbox instructions over typing directly into a terminal.
- Use `replace` when a running job must yield to a new command.
- Use `interrupt` for immediate stop, then send the next command.
- Treat tmux as the visual layer only; source of truth is `status.json`.

## Limits

- A completely arbitrary foreground program cannot be semantically interrupted unless it cooperates.
- Reliable management comes from inbox-driven commands launched by the supervisor, not from raw keystroke injection.
