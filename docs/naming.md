# mason-skills naming rules

## Core rule

Every reusable skill uses the `mason-` prefix.

The prefix is a namespace, not the boundary.
The **suffix** must reveal what the skill actually does.

## Naming formula

Use one of these shapes:

- `mason-<domain>-router`
- `mason-<action>`
- `mason-<domain>-<action>`
- `mason-<domain>-<diagnosis>`

## Good names

- `mason-article-router`
- `mason-terminal-supervisor`
- `mason-claudeception-ab`
- `mason-issue-managed-development-orchestrator`
- `mason-debug-triage`

## Bad names

- `mason-article`
- `mason-helper`
- `mason-workflow`
- `mason-system`
- `mason-general-skill`

## Router vs Wrench naming

### Router skill

If the skill decides direction first, prefer:
- `router`
- `triage`
- `decision`
- `ab`

Examples:
- `mason-article-router`
- `mason-debug-triage`
- `mason-research-decision`

### Wrench skill

If the skill executes one stable workflow, prefer the action itself.

Examples:
- `mason-terminal-supervisor`
- `mason-wechat-preview`
- `mason-progress-export`

## Fast check

Before finalizing a name, ask:
1. Does the name expose the boundary?
2. Could someone infer router vs wrench from the name?
3. If the `mason-` prefix is removed, is the remainder still meaningful?

If not, the name is still too vague.
