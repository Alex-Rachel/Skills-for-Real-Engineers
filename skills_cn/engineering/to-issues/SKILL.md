---
name: to-issues
description: 将 PRD（产品需求文档）拆解为可执行的 issue，附带 agent 简报和验收标准。当用户说"创建 issue"、"拆解 PRD"、"从 PRD 生成 issue"，或有 PRD 需要转化为可执行工作时使用。
---

# To Issues

将 PRD 拆解为可执行的 issue，附带 agent 简报和验收标准。

## 流程

### 1. 读取 PRD

读取 PRD 文件。PRD 应该描述：
- 要构建什么
- 为什么（成功指标）
- 约束条件

如果 PRD 不存在或不够详细，使用 `/to-prd` 技能先创建它。

### 2. 拆解为 issue

将 PRD 拆解为独立、可执行的 issue。每个 issue 应该：

- **可由单个 agent 或人独立完成** — 不需要等待其他 issue 完成
- **有明确的验收标准** — 你能判断它是否完成
- **有明确的范围** — 边界清晰，不会膨胀

### 3. 编写 agent 简报

对每个 issue，编写 agent 简报——一个结构化规格，AFK agent 可以据此工作。参见 [../triage/AGENT-BRIEF.md](../triage/AGENT-BRIEF.md) 了解格式。

### 4. 排序

对 issue 排序：
- 依赖顺序 — 被依赖的 issue 先
- 风险 — 高风险/高不确定性的先做（减少风险）
- 价值 — 高价值的先做（更早交付价值）

### 5. 创建 issue

使用配置的 issue 跟踪器创建 issue。参见 [../setup-matt-pocock-skills/SKILL.md](../setup-matt-pocock-skills/SKILL.md) 了解跟踪器设置。

## 原则

- **issue 是独立的工作单元。** 如果一个 issue 依赖另一个，那它可能需要拆分或重新排序。
- **agent 简报是契约。** 它必须足够完整，让 agent 可以在没有人干预的情况下工作。
- **验收标准是硬性的。** "功能正常工作"不是验收标准。"运行 `gh issue list --label needs-triage` 返回经过初始分类的 issue"才是。
