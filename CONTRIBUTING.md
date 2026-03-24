# Contributing

Thanks for contributing to `mason-skills`.

## What is welcome

- boundary clarification for existing skills
- better trigger phrases
- portability fixes for shell / tmux workflows
- documentation improvements
- secret-safety and runtime-safety improvements

## What is not welcome

- dumping one-off conversations into public skills
- adding fake A/B routes to linear execution skills
- widening skill names until their boundaries disappear
- committing secrets, cookies, API keys, or private production paths

## Contribution flow

1. Fork the repo
2. Create a branch
3. Make the smallest correct change
4. Run local validation
5. Open a PR with clear scope

## Pull request expectations

Please include:
- what changed
- why it was needed
- whether the skill boundary changed
- how you validated it
- whether any runtime artifacts or `.gitignore` rules changed

## Local validation

```bash
find skills -path '*/scripts/*.sh' -print0 | xargs -0 -I{} bash -n '{}'
find skills -path '*/scripts/*.py' -print0 | xargs -0 -I{} python3 -m py_compile '{}'
rg -n '/Users/|/home/|API_KEY|TOKEN|SECRET|gho_' .
```

## Design rules

### Router skills
- define one dominant contradiction first
- keep top-level routes to two in the first version
- make the route choice explicit before execution

### Wrench skills
- keep the workflow linear
- document prerequisites clearly
- bundle scripts when manual execution is error-prone

## Security rule

If a contribution makes a skill more useful but also exposes private workflow details, do not merge it into the public repo yet.
Generalize it first.
