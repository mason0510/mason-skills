---
name: mason-article-router
description: |
  This skill should be used when the user asks to "mason-article", "写成 Mason 风格文章", "这篇文章该走观点还是说明", "写成观点文", "写成说明文", "Mason 风格长文", or wants an article request routed first into either (A) a sharp opinion article or (B) a structured explainer article instead of mixing both styles.
author: Codex
version: 1.0.0
date: 2026-03-24
---

# Mason Article Router

## Problem
“Mason 风格文章”这个说法太宽。
如果不先选路，文章很容易写成半观点、半说明、既不够狠也不够清楚的混合体。

先做路由，再写正文。

## Configuration checklist

Before using this skill, check:
- source material exists: idea, outline, draft, transcript, or notes
- the target output goal is clear: persuade or explain
- any factual claims that require proof have real evidence available
- if screenshots / links / data are referenced, they are real current artifacts rather than mock placeholders
- no private notes, credentials, or internal-only links are accidentally carried into the article draft

## How to use

1. Read the request and decide whether the main goal is **A / opinion** or **B / explainer**.
2. State the chosen route explicitly before drafting.
3. Draft only in the chosen style.
4. If the article requires evidence, insert only real evidence.
5. Deliver the final output with the route label preserved.

## Core split
- **A：观点型文章** — 目标是打人、说服、立判断
- **B：说明型文章** — 目标是讲清、交付、建立认知模型

## Routing rules
符合下面信号时，走 **A：观点型**：
- 用户要“公众号感”“金句”“情绪”“作者存在感”
- 用户要“狠一点”“有判断”“像在和读者说话”
- 用户本质上是要输出立场，不是输出教程

符合下面信号时，走 **B：说明型**：
- 用户要“讲清楚”“拆解一下”“给方法”“做成解释文”
- 用户更关心结构、定义、流程、约束
- 用户本质上是要完成认知交付，不是做态度输出

如果用户同时提了两者，必须先判断主目标：
- **先打动读者** → A
- **先让读者理解** → B

## Route A workflow: opinion article

### 1. Lock one hard judgment
先写一句硬判断：
- 旧范式为什么错
- 新范式为什么成立
- 这篇文章要替读者砍掉什么旧认知

一句话写不出来，不进入正文。

### 2. Build hook and pressure
开头必须先抓人：
- 痛点
- 厌倦
- 愤怒
- 鲜明立场

不要从背景介绍起手。

### 3. Organize as conflict, not documentation
默认结构：
1. 开头钩子
2. 旧范式判死刑
3. 新判断抛出
4. 关键武器 / 关键结构
5. 真实证据
6. 结尾定锤

### 4. Insert gold lines
至少要有：
- 1 条主金句
- 每个关键章节 1 条分段金句
- 1 条结尾定锤句

金句优先用二元对打：
- “这不是……这是……”
- “不是锦上添花，而是生死线。”
- “A 解决的是 X，B 解决的是 Y。”

### 5. Use real evidence only
截图、页面、数据、案例只能来自本次真实产物。
没有真实结果，就明确不写。

## Route B workflow: explainer article

### 1. Lock the core question
先写清楚这篇文章到底解释什么：
- 一个概念
- 一个方法
- 一个系统
- 一个判断模型

### 2. Build a teaching chain
默认按下面顺序组织：
1. 问题定义
2. 核心概念
3. 结构 / 模型
4. 执行流程
5. 约束与边界
6. 真实例子
7. 结论

### 3. Prefer clarity over pressure
说明型文章允许有判断，但不要用观点文的高压句式覆盖可读性。
优先：
- 定义准确
- 层次清楚
- 例子具体
- 段落顺滑

### 4. Make the transfer explicit
每一节都要回答一个问题：

> 读者在这一段之后，具体多理解了什么？

如果不能回答，说明这段在灌水。

### 5. Use real examples only
案例、数据、截图、路径必须来自真实上下文。
没有真实例子时，只能明确说“当前暂无真实例子”，不能伪造。

## Output contract
最终输出前，先显式标记所选路由：
- `Route: A / Opinion`
- `Route: B / Explainer`

不要把两种风格混在一个首稿里。

## Hard bans
- 不要在未选路前同时写观点文和说明文
- 不要把“观点 + 说明”伪装成更全面
- 不要用 `mason-article` 这种宽名字继续放大歧义
- 不要用假证据、假截图、假案例
- 不要把 Markdown 垃圾直接漏进最终正文
