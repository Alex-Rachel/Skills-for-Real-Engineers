# 本地 Issue 跟踪

使用项目目录中的 Markdown 文件跟踪 issue。

## 设置

在项目根目录创建 `.issues/` 目录：

```bash
mkdir .issues
```

## 格式

每个 issue 是 `.issues/` 中的一个 Markdown 文件：

```markdown
# issue-001

## 标题

简短描述

## 状态

needs-triage | needs-info | ready-for-agent | ready-for-human | wontfix | closed

## 描述

详细描述

## 评论

- **2024-01-15** — 第一条评论
- **2024-01-16** — 第二条评论
```

## 命令

没有 CLI——直接读写文件。技能会：

- 列出 `.issues/` 中的文件来列出 issue
- 创建新文件来创建 issue
- 编辑文件来更新状态或添加评论

## 标签

状态存储在每个 issue 文件的 `## 状态` 部分中。参见 [triage-labels.md](triage-labels.md) 了解标准状态值。
