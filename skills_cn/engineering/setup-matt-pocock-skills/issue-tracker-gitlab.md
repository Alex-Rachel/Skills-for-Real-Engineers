# GitLab Issues

使用 `glab` CLI 与 GitLab Issues 交互。

## 设置

确保 `glab` CLI 已安装并认证：

```bash
glab auth status
```

如果未认证，运行：

```bash
glab auth login
```

## 常用命令

```bash
# 列出 issue
glab issue list

# 创建 issue
glab issue create --title "标题" --description "描述"

# 给 issue 添加标签
glab issue update 123 --add-label "needs-triage"

# 评论 issue
glab issue note 123 --message "评论内容"

# 关闭 issue
glab issue close 123
```

## 标签

GitLab 标签是字符串。参见 [triage-labels.md](triage-labels.md) 了解技能使用的标准标签集。在 GitLab 项目设置中创建这些标签。
