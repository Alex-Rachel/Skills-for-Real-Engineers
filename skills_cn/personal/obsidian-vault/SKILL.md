---
name: obsidian-vault
description: 在 Obsidian 知识库中搜索、创建和管理笔记，支持维基链接和索引笔记。当用户想要在 Obsidian 中查找、创建或整理笔记时使用。
---

# Obsidian 知识库

## 知识库位置

`/mnt/d/Obsidian Vault/AI Research/`

根层级基本保持扁平结构。

## 命名规范

- **索引笔记**：聚合相关主题（例如 `Ralph Wiggum Index.md`、`Skills Index.md`、`RAG Index.md`）
- 所有笔记名称使用 **标题大小写（Title Case）**
- 不使用文件夹进行组织——改用链接和索引笔记

## 链接

- 使用 Obsidian `[[wikilinks]]` 语法：`[[Note Title]]`
- 笔记在底部链接到其依赖/相关笔记
- 索引笔记就是 `[[wikilinks]]` 的列表

## 工作流程

### 搜索笔记

```bash
# 按文件名搜索
find "/mnt/d/Obsidian Vault/AI Research/" -name "*.md" | grep -i "keyword"

# 按内容搜索
grep -rl "keyword" "/mnt/d/Obsidian Vault/AI Research/" --include="*.md"
```

也可以直接在知识库路径上使用 Grep/Glob 工具。

### 创建新笔记

1. 文件名使用 **标题大小写（Title Case）**
2. 将内容作为一个学习单元来撰写（遵循知识库规则）
3. 在底部添加指向相关笔记的 `[[wikilinks]]`
4. 如果属于编号序列，使用层级编号方案

### 查找相关笔记

在整个知识库中搜索 `[[Note Title]]` 以查找反向链接（backlinks）：

```bash
grep -rl "\\[\\[Note Title\\]\\]" "/mnt/d/Obsidian Vault/AI Research/"
```

### 查找索引笔记

```bash
find "/mnt/d/Obsidian Vault/AI Research/" -name "*Index*"
```
