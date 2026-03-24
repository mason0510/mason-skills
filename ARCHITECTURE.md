# mason-skills Architecture

## Overall structure

```text
User request
    |
    v
Trigger phrase / task shape
    |
    v
Selected skill
    |
    +--> Router skill ----------------------+
    |                                       |
    |                                   Route A / Route B
    |                                       |
    |                                       v
    |                                task-specific output
    |
    +--> Wrench skill ----------------------+
                                            |
                                            v
                                   linear execution workflow
                                            |
                                            v
                                   real runtime artifacts
```

## Core modules

### 1. Skill namespace layer
- Responsibility: keep the repository scoped to reusable `mason-*` skills
- Inputs: validated skills
- Outputs: clear skill directories under `skills/`

### 2. Router layer
- Responsibility: decide direction before writing or executing
- Current example: `mason-claudeception-ab`, `mason-article-router`
- Design rule: one dominant contradiction, no fake multi-route explosion

### 3. Wrench layer
- Responsibility: execute one stable workflow with minimal branching
- Current example: `mason-terminal-supervisor`
- Design rule: linear steps, explicit runtime artifacts, operational commands bundled as scripts when needed

### 4. Runtime artifact layer
- Responsibility: make supervision and acceptance evidence visible
- Current example: `.runtime/terminal-supervisor/...`
- Outputs: `status.json`, `inbox.jsonl`, `output.log`

### 5. Documentation layer
- Responsibility: make install path, config checks, usage, and maintenance obvious
- Files: `README*`, `USAGE_AND_MAINTENANCE.md`, `docs/*`, each `SKILL.md`

## Data flow

### Router skills
1. Request arrives with ambiguous intent
2. Skill compresses ambiguity into A/B
3. One route is chosen explicitly
4. Drafting or execution starts only after routing

### Wrench skills
1. Request arrives with clear operational intent
2. Skill checks prerequisites
3. Scripts run in a fixed sequence
4. Runtime state is written to disk
5. Operator reads real status instead of guessing from terminal visuals

## Key design decisions

### Decision 1: separate Router from Wrench
Why:
- Most bloated skills fail because they mix judgment and execution in one file

Trade-off:
- More explicit classification work up front
- Much less drift during execution

### Decision 2: force A/B only for router skills
Why:
- A router needs a dominant contradiction to be triggerable and teachable

Trade-off:
- Some nuance is postponed
- But first version stays sharp instead of turning into a taxonomy dump

### Decision 3: keep runtime evidence on disk
Why:
- Long-running terminal work cannot be trusted if state only lives in chat memory

Trade-off:
- More files are produced locally
- But acceptance becomes observable and auditable

## Extensibility

### Adding a new router skill
- define the dominant contradiction first
- keep top-level routes to two in v1
- document route rules and hard bans

### Adding a new wrench skill
- define stable trigger conditions
- document config checklist and usage
- bundle scripts if manual steps are the main failure mode

### Maintenance notes
- keep hidden local assumptions out of public skills
- move repo-specific workflows to a private or experimental layer until generalized
- validate shell/python scripts before every release
