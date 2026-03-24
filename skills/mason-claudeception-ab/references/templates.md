# Router / Wrench templates

## 1. Router skill template

```md
---
name: <precise-name>-router
description: This skill should be used when the user asks to "...", "...", or needs a first-pass decision between two opposing paths.
version: 1.0.0
---

# <Title>

## Problem
<why the request drifts without routing>

## Core split
- A: <route A>
- B: <route B>

## Routing rules
如果用户更关心 <signal> → A
如果用户更关心 <signal> → B

## Route A workflow
1. ...
2. ...
3. ...

## Route B workflow
1. ...
2. ...
3. ...

## Hard bans
- 不要在未选路前混做 A/B
- 不要新增第三条主路线
```

## 2. Wrench skill template

```md
---
name: <precise-action-name>
description: This skill should be used when the user asks to "...", "...", or needs one stable execution workflow for <action>.
version: 1.0.0
---

# <Title>

## Problem
<what action must be stabilized>

## Inputs
- ...
- ...

## Workflow
1. ...
2. ...
3. ...

## Verification
- ...
- ...

## Failure stop conditions
- ...
- ...
```

## 3. Naming rules

Good:
- `mason-article-router`
- `mason-terminal-supervisor`
- `mason-debug-triage`

Bad:
- `mason-article`
- `mason-helper`
- `mason-workflow`

## 4. Fast test
在落 skill 前，快速问 4 个问题：
1. 这是先判断，还是先执行？
2. 如果是判断，A/B 是否真的相反？
3. skill 名字是否暴露边界？
4. 删掉一半内容后，是否仍然能跑？
