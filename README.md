# mason-skills

> Public `mason-*` skill warehouse for Codex / Claude Code style workflows.

[English](./README_EN.md) | 中文

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Skills](https://img.shields.io/badge/skills-3-blue.svg)
![Status](https://img.shields.io/badge/status-active-orange.svg)

## ✨ 核心特性

- 🧭 **Router vs Wrench**：先判断技能是分诊器还是执行扳手，而不是把复杂世界硬塞进一个 skill
- ⚔️ **A/B first for router skills**：路由型 skill 先压成一组主矛盾，再进入执行
- 🖥️ **Terminal supervision**：用 `tmux + status.json + inbox.jsonl` 管理长任务，而不是靠 GUI 终端硬控
- 🔍 **Config 明示**：每个 skill 都写清楚 configuration checklist 和 how to use
- 🚫 **No fake acceptance**：只承认真实产物、真实运行、真实验证

## 📦 当前公开技能

### 1. `mason-claudeception-ab`
把一次真实上下文里的经验，压缩成可复用的 `mason-*` skill。
核心不是“多写知识”，而是先判断它到底是：
- Router / 分诊器
- Wrench / 扳手

只有 Router 才强制做 A/B 对立路由；Wrench 不允许硬拆假 A/B。

### 2. `mason-article-router`
把模糊的 “Mason 风格文章” 请求先路由成两类：
- Route A / Opinion：观点型、带立场、带冲突
- Route B / Explainer：说明型、结构清晰、认知交付

避免首稿一上来写成半观点半说明的混合垃圾。

### 3. `mason-terminal-supervisor`
用脚本化方式管理长时间运行的终端任务：
- `start.sh`
- `status.sh`
- `send.sh`
- `capture.sh`

核心产物：
- `.runtime/terminal-supervisor/<name>/status.json`
- `.runtime/terminal-supervisor/<name>/inbox.jsonl`
- `.runtime/terminal-supervisor/<name>/output.log`

## 🚀 快速开始

### 安装

把需要的 skill 目录复制到你的 skill 目录中，例如：

```bash
mkdir -p ~/.codex/skills
cp -R skills/mason-article-router ~/.codex/skills/
cp -R skills/mason-claudeception-ab ~/.codex/skills/
cp -R skills/mason-terminal-supervisor ~/.codex/skills/
```

如果你使用的是项目级 skill 仓库，也可以复制到：

```bash
mkdir -p .claude/skills
cp -R skills/mason-article-router .claude/skills/
```

### 基本使用

#### `mason-claudeception-ab`
适用：要把当前经验沉淀成新 skill 时。

#### `mason-article-router`
适用：用户说“写成 Mason 风格文章”“这篇该走观点还是说明”时。

#### `mason-terminal-supervisor`
适用：你要托管一个会跑很久的终端任务时。

```bash
./skills/mason-terminal-supervisor/scripts/start.sh demo 'for i in {1..5}; do echo step:$i; sleep 1; done'
./skills/mason-terminal-supervisor/scripts/status.sh demo
./skills/mason-terminal-supervisor/scripts/send.sh demo note '先不要部署，先截图'
./skills/mason-terminal-supervisor/scripts/capture.sh demo
```

## ⚙️ 配置

每个 skill 自带两部分：
- `Configuration checklist`
- `How to use`

公开仓库只保留**可以泛化**的配置说明：
- 需要哪些 CLI / runtime
- 需要什么目录可写
- 哪些日志会落盘
- 哪些内容绝不能写进仓库

不会放入：
- token
- cookie
- API key
- 私有 endpoint 凭证
- 生产环境私有路径

## 📚 详细文档

- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [USAGE_AND_MAINTENANCE.md](./USAGE_AND_MAINTENANCE.md)
- [docs/naming.md](./docs/naming.md)
- [docs/inclusion-criteria.md](./docs/inclusion-criteria.md)
- [TODOS.md](./TODOS.md)

## 🛠️ 开发

### 本地检查

```bash
find skills -path '*/scripts/*.sh' -print0 | xargs -0 -I{} bash -n '{}'
find skills -path '*/scripts/*.py' -print0 | xargs -0 -I{} python3 -m py_compile '{}'
```

### 仓库原则

- 不要提交 `.runtime/`
- 不要提交 secrets / credentials
- 不要把一次性聊天内容直接塞成 skill
- 优先保持 boundary 清晰，而不是追求“大而全”

## 🗺️ 首发范围说明

这次首发只公开 3 个已经相对通用的 skill。
更复杂的 `issue-managed-*` 工作流暂时没有包含进公开版，因为它仍然带有较强的本地工作流假设，需要再做一轮去私有化和泛化。

## 🤝 贡献

欢迎提交：
- skill 边界收窄建议
- 文档澄清
- 兼容性修复
- shell / tmux 可移植性改进

详见 [CONTRIBUTING.md](./CONTRIBUTING.md)

## 📧 联系方式

- GitHub: [@mason0510](https://github.com/mason0510)
- Issues: 请直接通过本仓库 GitHub Issues 提交

## 📄 许可证

MIT License — 详见 [LICENSE](./LICENSE)
