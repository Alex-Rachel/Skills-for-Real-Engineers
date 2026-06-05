# 重构

红-绿-重构循环中的重构阶段。在所有测试通过后应用。

## 时机

**只在 GREEN 时重构。** 如果有测试失败，先让它们通过。重构需要安全网——所有测试必须通过才能开始。

## 寻找重构候选

### 1. 重复

相同或相似的代码出现在多个地方。提取到共享函数或模块。

```typescript
// 之前：重复的验证逻辑
function processOrder(order: Order) {
  if (!order.items || order.items.length === 0) throw new Error('No items');
  // ...
}

function cancelOrder(order: Order) {
  if (!order.items || order.items.length === 0) throw new Error('No items');
  // ...
}

// 之后：提取共享验证
function validateItems(order: Order) {
  if (!order.items || order.items.length === 0) throw new Error('No items');
}

function processOrder(order: Order) {
  validateItems(order);
  // ...
}

function cancelOrder(order: Order) {
  validateItems(order);
  // ...
}
```

### 2. 浅模块

接口几乎与实现一样复杂的模块。寻找[加深](deep-modules.md)的机会。

```typescript
// 之前：浅模块 — 只是转发
class OrderValidator {
  validate(order: Order): ValidationResult {
    return this.schema.validate(order);  // 没增加价值
  }
}

// 之后：加深 — 将验证逻辑内联到使用它的模块中
class OrderService {
  process(order: Order) {
    this.validateOrder(order);  // 私有方法，封装逻辑
    // ...
  }
}
```

### 3. 泄漏抽象

实现细节通过接口泄漏。调用者必须了解内部才能正确使用模块。

```typescript
// 之前：泄漏 — 调用者必须知道内部状态
class OrderService {
  state: 'idle' | 'processing' | 'done';  // 泄漏
  process() { this.state = 'processing'; /* ... */ this.state = 'done'; }
}

// 之后：封装 — 调用者只使用行为
class OrderService {
  private state: 'idle' | 'processing' | 'done';
  async process(): Promise<OrderResult> { /* ... */ }
}
```

### 4. 缺失抽象

重复的模式表明需要一个命名抽象。

```typescript
// 之前：重复的错误处理模式
async function fetchUser() {
  try { return await api.getUser(); }
  catch (e) { logger.error(e); throw new AppError(e); }
}

async function fetchOrder() {
  try { return await api.getOrder(); }
  catch (e) { logger.error(e); throw new AppError(e); }
}

// 之后：提取抽象
async function withErrorHandling<T>(fn: () => Promise<T>): Promise<T> {
  try { return await fn(); }
  catch (e) { logger.error(e); throw new AppError(e); }
}

async function fetchUser() {
  return withErrorHandling(() => api.getUser());
}
```

## 重构顺序

应用重构的优先级：

1. **消除重复** — 最高优先级。重复是软件中万恶之源。
2. **加深浅模块** — 合并、内联、简化接口。
3. **修复泄漏抽象** — 封装实现细节。
4. **引入缺失抽象** — 命名重复模式。
5. **应用 SOLID 原则** — 在自然的地方，不要强求。

## 安全重构

每一步：

1. 确认所有测试通过
2. 进行一个小的重构
3. 运行测试
4. 如果失败，回滚
5. 如果通过，提交（或继续下一个重构）

**不要在一次重构中混合多个变更。** 一次一个，每次之后运行测试。
