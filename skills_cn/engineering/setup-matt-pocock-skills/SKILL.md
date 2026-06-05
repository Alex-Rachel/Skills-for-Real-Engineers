---
name: setup-matt-pocock-skills
description: 配置此技能集以适配你的代码库——设置领域术语表、issue 跟踪器集成和分流标签。当用户首次设置技能集或说"设置技能"时使用。
---

# Setup Matt Pocock Skills

配置此技能集以适配你的代码库。

## 流程

### 1. 领域术语表

在项目根目录创建 `CONTEXT.md`，描述代码库的核心领域概念。参见 [domain.md](domain.md) 了解格式。

### 2. Issue 跟踪器

配置技能集以与你的 issue 跟踪器协作。选择一个：

- [GitHub Issues](issue-tracker-github.md) — 使用 `gh` CLI
- [GitLab Issues](issue-tracker-gitlab.md) — 使用 `glab` CLI
- [本地文件](issue-tracker-local.md) — 使用 Markdown 文件

### 3. 分流标签

配置分流标签以匹配你的跟踪器词汇。参见 [triage-labels.md](triage-labels.md) 了解标准标签集。

## 完成后

设置完成后，技能集将：
- 使用你的领域术语来命名测试和接口
- 将 issue 路由到正确的跟踪器
- 使用正确的标签进行分流
