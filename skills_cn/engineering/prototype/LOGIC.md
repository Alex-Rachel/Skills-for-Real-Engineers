# 逻辑原型

验证算法、数据流或业务逻辑的原型。

## 何时使用

当你需要验证逻辑但不需要 UI 时。常见场景：

- 算道或数据流是否可行？
- 算法能否处理预期负载？
- 业务规则在边缘情况下是否产生正确结果？
- 两个系统能否以特定方式集成？

## 方法

### 脚本方法

最简单的形式：一个脚本，接收输入、运行逻辑、打印输出。

```typescript
// 硬编码输入，打印输出，完成
const input = { items: [...], config: {...} };
const result = myAlgorithm(input);
console.log(JSON.stringify(result, null, 2));
```

优点：快速、隔离、容易修改。
缺点：不测试集成。

### REPL 方法

在 REPL 中交互式探索逻辑。

```typescript
// 在 Node REPL 中
> const { processOrder } = require('./order-logic')
> processOrder({ items: [{ sku: 'A1', qty: 3 }] })
{ total: 29.97, tax: 2.40, ... }
```

优点：即时反馈、探索性强。
缺点：不留下记录、不可复现。

### 测试方法

将原型写为测试——即使你不打算保留测试。

```typescript
describe('order processing prototype', () => {
  it('handles the edge case we are worried about', () => {
    const result = processOrder({ items: [], coupon: 'FREE' });
    expect(result.total).toBe(0);
  });
});
```

优点：可复现、留下记录、IDE 支持好。
缺点：设置开销稍大。

## 指导

- **从最简单的方法开始。** 如果脚本够用，就用脚本。
- **不要构建基础设施。** 没有配置文件、没有构建管道、没有 DI 容器。直接运行逻辑。
- **硬编码一切。** 数据库连接、API URL、配置值——全部硬编码。你以后可以参数化。
- **打印中间结果。** 在管道的每个阶段打印数据，这样你可以看到发生了什么。
- **先尝试快乐路径。** 先让典型情况可行，再探索边缘情况。
