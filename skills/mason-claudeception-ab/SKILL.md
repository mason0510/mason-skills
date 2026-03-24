---
name: mason-claudeception-ab
description: |
  This skill should be used when the user asks to "复制 claudeception", "基于上下文创作 skill", "按 AB 拆技能", "把这次经验沉淀成 skill", "重写 skill", "mason-skills", "把这个 skill 收敛一下", or wants to turn current-session learnings into a reusable `mason-*` skill by first deciding whether the target is (A) a router / judgment skill or (B) a direct execution skill.
author: Codex
version: 1.0.0
date: 2026-03-24
---

# Mason Claudeception AB

## Problem
复杂场景一旦直接塞进 skill，skill 就会失真：边界发虚、分支过多、执行漂移。

这个 skill 不把 skill 当成“世界模型”，而把 skill 当成两类能力之一：
- **Router / 分诊器**：先选方向，再进入不同流程
- **Wrench / 扳手**：输入明确，直接稳定执行

## Core principle
先做一次更高层的二分，再决定 skill 怎么写：

1. **先判断目标 skill 是 Router 还是 Wrench**
2. **只有 Router skill 才强制做内部 A/B 对立路由**
3. **Wrench skill 禁止硬拆 A/B，避免空心化**

不要一上来枚举所有复杂度。
先抓主矛盾，再把 skill 压缩成可稳定触发的决策单元。

## When to use
在这些场景触发：
- 用户要复制 / 改写 `claudeception`
- 用户要把当前对话经验沉淀成 `mason-*` skill
- 用户明确提出“按 A/B 创作 skill”
- 现有 skill 太大、太散、太像知识堆积
- 需要决定某个 skill 应该做成“路由型”还是“执行型”
- 需要基于本次上下文，新建一个更短、更硬、更可触发的 skill


## Configuration checklist

Before using this skill, check:
- target skill directory is chosen clearly: project-local or user-level
- target directory is writable
- `find` / `rg` / `git` are available if searching existing skills
- no secret values are about to be copied into SKILL.md / references / examples
- if extracting from real production work, sensitive paths / ids / credentials are either removed or generalized

## How to use

1. Decide whether the new skill belongs in project-local `.claude/skills/` or repo-level `mason-skills/skills/`.
2. Search existing skills first.
3. Classify the target as Router or Wrench.
4. If Router, define one dominant A/B contradiction.
5. Write the smallest complete skill that still works.

## Workflow

### Step 1: Search existing skills first
优先检查项目级 skill，再检查用户级 skill：

```bash
find .claude/skills "$HOME/.claude/skills" "$HOME/.codex/skills" -maxdepth 2 -name SKILL.md 2>/dev/null
rg -i "keyword1|keyword2|error|tool|domain" .claude/skills "$HOME/.claude/skills" "$HOME/.codex/skills" 2>/dev/null
```

决策规则：
- **同问题同解法** → 更新现有 skill
- **同域但不同触发条件** → 新建 skill，并互相写 `See also`
- **现有 skill 过宽** → 收窄，改成 router 或 wrench
- **现有事实已过时** → 直接修，不等 retrospective

### Step 2: Extract the reusable learning
只沉淀下面这些内容：
- 非显然的判断方法
- 反复踩坑后确认的流程
- 容易误判的触发条件
- 真实验证过的命令、路径、接口、文章结构、工作流

不要沉淀：
- 一次性聊天废话
- 模糊态度
- “也可以这样也可以那样”的空判断
- 没验证过的推测

### Step 3: Decide the skill class
先问一句：

> 这个 skill 的核心价值，是“先判断怎么走”，还是“把一个动作稳定做完”？

#### 归为 Router / 分诊器，如果满足任一项
- 先选方向比执行细节更重要
- 不同方向会进入不同流程
- 用户经常说不清自己要哪种结果
- 当前 skill 失败的根因是“没有先做判断”

#### 归为 Wrench / 扳手，如果满足任一项
- 输入足够明确
- 主流程稳定
- 重点是可靠执行，不是路径选择
- 当前 skill 失败的根因是“动作没做稳”

### Step 4A: If Router, build one dominant contradiction
Router skill 必须先定义一组**截然相反**的 A/B：
- 互斥
- 可操作
- 会导向不同流程
- 能回答“用户现在更像哪边”

好例子：
- 观点型 vs 说明型
- 安全优先 vs 速度优先
- 数据/现象优先 vs 代码/实现优先

坏例子：
- 写作 / 营销 / 表达 / 传播 / 结构 / 情绪
- 快 / 慢 / 稳 / 灵活 / 保守

Router skill 必须包含：
1. **核心二分**
2. **路由判断规则**
3. **A 流程**
4. **B 流程**
5. **禁止混做的规则**

### Step 4B: If Wrench, keep it linear
Wrench skill 不做假二分，只写：
1. 触发条件
2. 输入要求
3. 固定执行顺序
4. 验证方法
5. 失败时的停机条件

### Step 5: Name the skill by boundary, not ambition
命名必须直接暴露边界：
- `mason-article-router`
- `mason-terminal-supervisor`
- `mason-debug-triage`

禁止宽泛命名：
- `mason-article`
- `mason-helper`
- `mason-workflow`

### Step 6: Write the smallest complete skill
目标不是最全，而是**最短可行且不失真**：
- 只保留主流程
- 只保留真实触发词
- 只保留会改变执行结果的规则
- 详细模板与变体丢到 `references/` 再按需读

模板见：
- `references/templates.md`

## Definition of done
只有同时满足下面几条，才算这次抽取完成：
- 已确认是 Router 还是 Wrench
- 若是 Router，A/B 已经互斥且可执行
- skill 名字暴露边界，不再虚
- 触发描述包含用户真实会说的话
- skill 能明显比原始上下文更短、更稳、更好触发

## Hard bans
- 不要把复杂世界原样塞进 skill
- 不要给 Wrench 硬套 A/B
- 不要给 Router 写 4 个以上顶层方向
- 不要用宽泛名字掩盖边界不清
- 不要把未验证的经验写进 skill
- 不要用 sample / mock 结果冒充真实 workflow

## Additional resources
- **`references/templates.md`** - Router / Wrench 两种 skill 模板与命名规则
