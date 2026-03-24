# Usage and Maintenance Guide

## Part 1: Usage

### Prerequisites

Baseline:
- macOS or Linux
- `bash`
- `git`

Per skill:
- `mason-terminal-supervisor`: `tmux`, `jq`
- `mason-claudeception-ab`: search tools such as `find`, `rg`, optionally `git`
- `mason-article-router`: no mandatory external runtime beyond your normal writing workflow

### Installation patterns

#### User-level install

```bash
mkdir -p ~/.codex/skills
cp -R skills/mason-claudeception-ab ~/.codex/skills/
cp -R skills/mason-article-router ~/.codex/skills/
cp -R skills/mason-terminal-supervisor ~/.codex/skills/
```

#### Project-level install

```bash
mkdir -p .claude/skills
cp -R skills/mason-terminal-supervisor .claude/skills/
```

### Common scenarios

#### Scenario A: extract a new skill from real context
Use `mason-claudeception-ab`.

Checklist:
- decide whether the target belongs in a project-local or user-level skill directory
- search for an existing skill first
- classify Router vs Wrench
- only if Router, define the A/B split

#### Scenario B: route an article request before drafting
Use `mason-article-router`.

Checklist:
- source material exists
- the real goal is clear: persuade or explain
- evidence is real if evidence is referenced

Output contract:
- `Route: A / Opinion`
- or `Route: B / Explainer`

#### Scenario C: supervise a long-running terminal job
Use `mason-terminal-supervisor`.

Start:

```bash
./skills/mason-terminal-supervisor/scripts/start.sh demo 'sleep 30 && echo done'
```

Read status:

```bash
./skills/mason-terminal-supervisor/scripts/status.sh demo
```

Send instructions:

```bash
./skills/mason-terminal-supervisor/scripts/send.sh demo note 'hold deployment'
./skills/mason-terminal-supervisor/scripts/send.sh demo interrupt
./skills/mason-terminal-supervisor/scripts/send.sh demo replace 'echo new command'
```

Capture output:

```bash
./skills/mason-terminal-supervisor/scripts/capture.sh demo
```

## Part 2: Maintenance

### Repository structure

```text
mason-skills/
├── README.md
├── README_EN.md
├── ARCHITECTURE.md
├── USAGE_AND_MAINTENANCE.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── TODOS.md
├── LICENSE
├── docs/
└── skills/
```

### Adding a new public skill

1. Verify the skill is reusable and bounded
2. Remove private paths, secrets, and environment-specific assumptions
3. Add `Configuration checklist`
4. Add `How to use`
5. Add hard bans if misuse is common
6. Bundle scripts only when reliability depends on them
7. Update README and docs if the public surface changes

### Updating an existing skill

1. Re-check scope boundaries
2. Update only verified facts
3. Keep examples portable
4. Re-run validation for every bundled script
5. Review `.gitignore` impact if runtime outputs changed

### Validation commands

#### Shell

```bash
find skills -path '*/scripts/*.sh' -print0 | xargs -0 -I{} bash -n '{}'
```

#### Python

```bash
find skills -path '*/scripts/*.py' -print0 | xargs -0 -I{} python3 -m py_compile '{}'
```

#### Fast secret/path scan

```bash
rg -n '/Users/|/home/|API_KEY|TOKEN|SECRET|gho_' .
```

### Release checklist

- README and README_EN match current public scope
- LICENSE exists
- `.gitignore` covers runtime artifacts and env files
- no private skills accidentally included
- no secrets in docs, scripts, or examples
- shell/python validation passed
- `git status` is clean before tag or push

### Troubleshooting

#### `tmux: command not found`
Install `tmux` before using `mason-terminal-supervisor`.

#### `jq: command not found`
Install `jq`; `send.sh` and `status.sh` depend on it.

#### Runtime files are appearing in git status
Check `.gitignore` and confirm you are writing into `.runtime/` as expected.

#### A public skill still depends on local conventions
That means it is not public-ready yet. Narrow it or move it back to private incubation.

### Long-term maintenance rule

Public skills should stay boringly reliable.
Novel but fragile workflow experiments should remain private until their hidden assumptions are removed.
