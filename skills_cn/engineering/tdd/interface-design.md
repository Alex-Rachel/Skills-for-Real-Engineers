# 面向可测试性的接口设计

接口设计如何影响可测试性，以及如何设计易于测试的接口。

## 原则

### 1. 依赖注入，而非硬编码

硬编码的依赖使测试困难，因为你无法替换它们。

```typescript
// 难以测试 — 硬编码依赖
class OrderService {
  processOrder(order: Order) {
    const repo = new PostgresOrderRepo();  // 硬编码
    const pricing = new StripePricing();   // 硬编码
    // ...
  }
}

// 易于测试 — 注入依赖
class OrderService {
  constructor(
    private repo: OrderRepo,      // 接口
    private pricing: Pricing,     // 接口
  ) {}

  processOrder(order: Order) {
    // ...
  }
}
```

### 2. 接口，而非实现

依赖应该是接口（或类型），而非具体类。这允许测试提供替代实现。

```typescript
// 接口 — 测试可以提供 mock
interface OrderRepo {
  save(order: Order): Promise<void>;
  findById(id: string): Promise<Order | null>;
}

// 具体 — 测试被锁定到实现
class PostgresOrderRepo {
  save(order: Order): Promise<void> { /* ... */ }
  findById(id: string): Promise<Order | null> { /* ... */ }
}
```

### 3. 纯函数优先

纯函数（无副作用、输出仅由输入决定）天然可测试。不需要 mock，不需要设置。

```typescript
// 纯函数 — 天然可测试
function calculateTotal(items: Item[], taxRate: number): number {
  return items.reduce((sum, item) => sum + item.price * item.qty, 0) * (1 + taxRate);
}

// 不纯 — 需要 mock 数据库
async function calculateTotal(orderId: string): Promise<number> {
  const items = await db.query('SELECT * FROM items WHERE order_id = $1', [orderId]);
  // ...
}
```

### 4. 将 I/O 推到边界

核心逻辑应该是纯的。I/O（数据库、网络、文件系统）应该发生在边界。

```typescript
// I/O 在边界 — 核心逻辑是纯的
async function processOrder(order: Order, repo: OrderRepo): Promise<Result> {
  const validated = validateOrder(order);        // 纯
  const priced = priceOrder(validated);          // 纯
  await repo.save(priced);                       // I/O 在边界
  return { success: true, order: priced };
}
```

## 反模式

### God 接口

一个做所有事情的接口。难以 mock（需要实现每个方法），难以理解（太多行为）。

```typescript
// God 接口 — 太多行为
interface UserService {
  createUser(): Promise<User>;
  deleteUser(): Promise<void>;
  updateUser(): Promise<User>;
  sendWelcomeEmail(): Promise<void>;
  resetPassword(): Promise<void>;
  changeRole(): Promise<void>;
  getPermissions(): Promise<Permissions>;
  // ... 20 个以上方法
}

// 拆分为聚焦接口
interface UserCrud {
  createUser(): Promise<User>;
  deleteUser(): Promise<void>;
  updateUser(): Promise<User>;
}

interface UserNotifications {
  sendWelcomeEmail(): Promise<void>;
  resetPassword(): Promise<void>;
}
```

### 暴露内部状态

接口暴露了内部状态，迫使调用者了解实现细节。

```typescript
// 暴露内部 — 调用者必须知道内部结构
class OrderService {
  get internalState(): Map<string, Order> { return this._orders; }
}

// 封装 — 调用者只使用公共行为
class OrderService {
  getOrder(id: string): Promise<Order> { /* ... */ }
}
```

## 检查清单

设计接口时问：

- [ ] 能否在不了解实现的情况下测试此接口？
- [ ] 能否提供简单的测试替身（test double）？
- [ ] 接口是否足够小以易于理解？
- [ ] 接口是否足够大以隐藏实现细节？
- [ ] 核心逻辑是否是纯的，I/O 是否在边界？
