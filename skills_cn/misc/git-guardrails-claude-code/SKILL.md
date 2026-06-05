---
name: git-guardrails-claude-code
description: 阻止 Claude Code 执行危险的 git 操作（force push、reset --hard、clean 等），防止不可逆的代码丢失。当用户希望保护仓库免受破坏性 git 命令影响时使用。
---

# Git Guardrails for Claude Code

## 概述

Claude Code 有时会执行破坏性的 git 命令，导致不可逆的代码丢失。此技能通过 shell 脚本钩子拦截这些操作，在造成损害之前将其阻止。

## 被阻止的操作

- `git push --force` / `git push -f`
- `git push --force-with-lease`
- `git reset --hard`
- `git clean`
- `git checkout .` / `git restore .`
- `git rebase`（交互式变基可能导致意外结果）
- `git branch -D`

## 设置

### 1. 将脚本复制到项目中

将 `scripts/block-dangerous-git.sh` 复制到你的项目中的某个位置（例如 `.husky/block-dangerous-git.sh` 或 `scripts/block-dangerous-git.sh`）。

### 2. 使脚本可执行

```bash
chmod +x scripts/block-dangerous-git.sh
```

### 3. 配置 Claude Code 钩子

在你的 `.claude/settings.json` 或 `.claude/settings.local.json` 中，添加一个 `PreToolUse` 钩子，在每次 Bash 工具调用之前运行该脚本：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "scripts/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

### 4. 验证

尝试让 Claude Code 运行一个危险的命令。它应该被阻止：

```
> 请执行 git push --force
❌ 被阻止：检测到危险的 git 操作：git push --force
```

## 工作原理

该脚本从 Claude Code 钩子环境中读取 `TOOL_INPUT` 环境变量，其中包含拟执行的 Bash 命令。它根据已知危险操作的模式列表进行检查。如果匹配，则以非零退出码退出，从而阻止工具调用。

## 注意

- 这不能替代良好的 git 卫生习惯——它只是一道安全网
- 该脚本使用简单的模式匹配，因此可能会产生误报（例如，在非破坏性上下文中匹配 `--force`）
- 对于需要执行被阻止操作的合法用例，可以临时禁用钩子
