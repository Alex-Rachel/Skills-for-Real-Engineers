---
name: triage
description: 对新 issue 进行分类和路由——评估、编写 agent 简报、标记为分流标签。当用户说"分流"、"分类 issue"、"查看新 issue"，或有新 issue 需要评估时使用。
---

# Triage

对新 issue 进行分类和路由。

## 流程

### 1. 收集新 issue

获取标记为 `needs-triage` 的 issue。参见 [../setup-matt-pocock-skills/triage-labels.md](../setup-matt-pocock-skills/triage-labels.md) 了解标签定义。

### 2. 评估每个 issue

对每个 issue：

1. **理解报告。** issue 描述了什么问题或请求？
2. **分类。** 是 bug、功能请求、问题还是无效的？
3. **检查重复。** 是否存在相同的 issue？检查 `.out-of-scope/` 了解先前拒绝的请求。参见 [OUT-OF-SCOPE.md](OUT-OF-SCOPE.md)。
4. **评估完整性。** 是否有足够的信息来处理，还是需要更多信息？

### 3. 路由

根据评估路由 issue：

| 分类         | 行为                                                       |
| ------------ | ---------------------------------------------------------- |
| Bug          | 标记 `ready-for-agent` 或 `ready-for-human`                |
| 功能请求     | 评估是否在范围内。如果是，标记 `ready-for-agent` 或 `ready-for-human`。如果不在，参见 [OUT-OF-SCOPE.md](OUT-OF-SCOPE.md)。 |
| 问题         | 回答并关闭                                                 |
| 需要更多信息 | 标记 `needs-info`，请求具体缺失信息                       |
| 重复         | 关闭并引用原始 issue                                       |
| 无效         | 关闭并标记 `wontfix`                                       |

### 4. 编写 agent 简报

对路由到 `ready-for-agent` 的 issue，编写 agent 简报。参见 [AGENT-BRIEF.md](AGENT-BRIEF.md) 了解格式。

### 5. 更新标签

移除 `needs-triage` 标签并应用适当的路由标签。

## 原则

- **分流要快。** 目标是快速路由，而不是深入分析。agent 简报提供深度。
- **不要重复工作。** 如果 issue 已经有 agent 简报，只需验证它仍然准确。
- **标记范围外，不要忽略。** 如果功能请求超出范围，记录原因。参见 [OUT-OF-SCOPE.md](OUT-OF-SCOPE.md)。
- **请求具体信息。** "需要更多信息"应该说明具体缺什么，而不是泛泛地说"请提供更多细节"。
