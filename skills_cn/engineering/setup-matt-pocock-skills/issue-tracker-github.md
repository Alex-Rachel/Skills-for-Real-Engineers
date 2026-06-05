# GitHub Issues

使用 `gh` CLI 与 GitHub Issues 交互。

## 设置

确保 `gh` CLI 已安装并认证：

```bash
gh auth status
```

如果未认证，运行：

```bash
gh auth login
```

## 常用命令

```bash
# 列出 issue
gh issue list

# 创建 issue
gh issue create --title "标题" --body "描述"

# 给 issue 添加标签
gh issue edit 123 --add-label "needs-triage"

# 评论 issue
gh issue comment 123 --body "评论内容"

# 关闭 issue
gh issue close 123
```

## 标签

GitHub 标签是字符串。参见 [triage-labels.md](triage-labels.md) 了解技能使用的标准标签集。确保这些标签存在于你的仓库中——如果不存在，创建它们：

```bash
gh label create "needs-triage" --description "需要维护者评估" --color "FBCA04"
gh label create "needs-info" --description "等待报告者提供更多信息" --color "0075CA"
gh label create "ready-for-agent" --description "已完整规格化，可供 AFK agent 处理" --color "0E8A16"
gh label create "ready-for-human" --description "需要人工实现" --color "B60205"
gh label create "wontfix" --description "不会处理" --color "BFD4F2"
```
