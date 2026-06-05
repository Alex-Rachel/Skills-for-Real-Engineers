---
name: migrate-to-shoehorn
description: 将项目迁移到 Shoehorn 标准——重构为 src/ 目录结构，配置 TypeScript 声明文件，并设置包的入口点。当用户希望将项目迁移到 Shoehorn 格式时使用。
---

# Migrate to Shoehorn

## 概述

将现有 TypeScript 项目迁移到 [Shoehorn](https://github.com/mattpocock/shoehorn) 标准。Shoehorn 是一种以类型优先方式发布 TypeScript 包的格式。

## 迁移内容

- 将源文件移动到 `src/` 目录
- 设置 `tsconfig.json` 以输出声明文件
- 配置 `package.json` 的入口点以指向构建输出
- 更新导入路径
- 添加构建脚本

## 步骤

### 1. 审查当前结构

检查项目当前的目录布局、`package.json` 和 `tsconfig.json`。记录：
- 源文件的位置
- 现有的入口点
- 现有的构建配置

### 2. 创建 `src/` 目录

将所有源文件移动到 `src/`：

```bash
mkdir -p src
git mv index.ts src/index.ts
# 对所有源文件重复此操作
```

### 3. 更新 `tsconfig.json`

```json
{
  "compilerOptions": {
    "outDir": "dist",
    "rootDir": "src",
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  },
  "include": ["src"]
}
```

### 4. 更新 `package.json`

设置入口点：

```json
{
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "default": "./dist/index.js"
    }
  },
  "files": ["dist"]
}
```

### 5. 添加构建脚本

```json
{
  "scripts": {
    "build": "tsc",
    "prepublishOnly": "npm run build"
  }
}
```

### 6. 更新导入路径

扫描所有文件，查找需要因目录移动而更新的导入路径。将 `./` 引用更新为指向 `src/` 内的新位置。

### 7. 验证

- [ ] `npm run build` 成功且无错误
- [ ] `dist/` 包含 `.js`、`.d.ts` 和 `.d.ts.map` 文件
- [ ] `package.json` 的入口点指向 `dist/`
- [ ] 所有导入路径正确解析

### 8. 提交

暂存所有更改并提交，消息为：`Migrate to Shoehorn format`

## 注意

- 如果项目有测试，可能需要更新测试配置以指向 `src/`
- 如果项目使用 `tsup` 或 `esbuild` 等打包工具，可能需要额外配置
- Shoehorn 格式优先考虑类型安全，而非打包优化
