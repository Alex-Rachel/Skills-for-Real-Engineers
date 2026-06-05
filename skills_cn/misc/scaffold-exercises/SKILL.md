---
name: scaffold-exercises
description: 搭建课程练习仓库——创建练习文件夹结构、起始代码和解决方案文件。当用户希望为课程或教程创建练习仓库时使用。
---

# Scaffold Exercises

## 概述

为课程或教程搭建练习仓库。创建标准化的文件夹结构，包含起始代码和解决方案文件，让学生可以逐步完成练习。

## 目录结构

```
exercises/
  01-first-exercise/
    problem.ts
    solution.ts
    tests.test.ts
  02-next-exercise/
    problem.ts
    solution.ts
    tests.test.ts
  ...
```

## 步骤

### 1. 收集练习信息

询问用户：
- 练习数量
- 每个练习的名称/主题
- 使用的语言/框架
- 是否需要测试文件

### 2. 创建目录结构

对于每个练习，创建：

```bash
mkdir -p exercises/01-exercise-name
```

### 3. 生成起始代码文件

在每个练习目录中创建 `problem.ts`（或相应语言的文件），包含：
- 类型/函数签名
- 占位符实现（`throw new Error("Not implemented")` 或类似内容）
- 描述练习目标的注释

### 4. 生成解决方案文件

创建 `solution.ts`，包含完整的工作实现。

### 5. 生成测试文件（可选）

创建 `tests.test.ts`，包含：
- 针对起始代码应失败的测试
- 针对解决方案应通过的测试

### 6. 创建索引文件

创建 `exercises/index.ts`，从每个练习中导出类型，供类型检查使用。

### 7. 添加配置文件

- `tsconfig.json`（如果使用 TypeScript）
- `package.json`，包含用于类型检查和测试的脚本
- `.prettierrc` 用于代码格式化

### 8. 提交

暂存所有文件并提交，消息为：`Scaffold exercises`

## 注意

- 练习应按难度递增排列
- 每个练习应聚焦于一个概念
- 起始代码应能编译（即使会抛出运行时错误）
- 解决方案应简洁且符合惯用写法
- 测试应具有描述性名称，解释预期行为
