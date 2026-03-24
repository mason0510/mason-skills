# mason-skills inclusion criteria

## Goal

Only include skills that are reusable enough to survive outside one chat session.

`mason-skills` is not a dump for every idea.
It is a warehouse for skills that are:
- reusable
- non-trivial
- validated
- bounded

## Include when

A skill should be added when most of these are true:

1. **Reusable**
   - likely to help in future tasks
   - not tied to one accidental situation only

2. **Non-obvious**
   - contains real discovered judgment, workflow, or hard-earned gotcha
   - not just generic advice

3. **Bounded**
   - can be named clearly
   - trigger conditions are explicit
   - main workflow is stable enough

4. **Validated**
   - based on real execution, real outputs, or repeated success
   - not just a speculative pattern

5. **Portable enough**
   - either self-contained
   - or its dependency on another `mason-*` skill is explicit and reasonable

## Exclude when

Do not add a skill when any of these are true:
- it is only a one-off conversation artifact
- the boundary is still fuzzy
- it needs too much hidden project context
- it has not been validated
- it is mostly motivational prose rather than operational guidance

## Router-specific rule

If the skill is a router:
- define one dominant A/B contradiction first
- do not add more than two top-level routes in the first version
- if you cannot define the A/B cleanly, do not include it yet

## Wrench-specific rule

If the skill is a wrench:
- keep the workflow linear
- bundle scripts if execution reliability matters
- do not add fake A/B just to look sophisticated

## Open-source readiness levels

### Level 1 — private-ready
- useful in Mason's own workflow
- may still assume some local conventions

### Level 2 — share-ready
- portable within `mason-skills`
- dependencies and runtime assumptions are explicit

### Level 3 — public-open-source-ready
- minimal hidden assumptions
- install/use path is clear
- docs and examples are self-sufficient

Current public repo goal: keep everything in the **Level 2 → Level 3** band.
If a skill still depends on strong local workflow assumptions, keep it private until generalized.
