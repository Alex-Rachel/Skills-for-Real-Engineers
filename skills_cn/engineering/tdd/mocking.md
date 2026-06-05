# Mock 指南

何时以及如何使用 mock——以及何时不使用。

## 核心原则

**Mock 是你与不可控依赖的接缝。** 你 mock 是为了将代码与你不拥有或无法在测试中运行的东西隔离。如果你 mock 了你能控制的东西，你的测试就在测实现，不是行为。

## 何时 Mock

### Mock：外部依赖

你不拥有的服务、需要网络的库、文件系统。你无法在测试中运行真实的东西，所以你提供一个替身。

```typescript
// Mock 外部支付服务 — 你无法在测试中调用 Stripe
const mockPricing = {
  calculatePrice: vi.fn().mockResolvedValue({ total: 29.97 }),
};
```

### Mock：尚未构建的依赖

你正在与之集成的代码尚不存在。Mock 让你定义期望的契约，以便在依赖构建后验证。

### 不要 Mock：你能运行的代码

如果你能在测试中运行真实代码，就运行真实代码。Mock 你能运行的代码会产生脆弱的测试——它们与实现耦合，重构时会失败。

```typescript
// 不要 mock 你能运行的代码
const result = calculateTotal(items, taxRate);  // 直接运行真实函数
expect(result).toBe(29.97);

// 而不是 mock 它
const mockCalc = vi.fn().mockReturnValue(29.97);  // 脆弱
```

### 不要 Mock：同一模块内的协作者

如果两个类在同一个模块中且总是协同工作，不要 mock 它们之间的交互。通过模块的公共接口测试整个模块。

```typescript
// 不要 mock 内部协作者
class OrderService {
  constructor(private validator: OrderValidator, private repo: OrderRepo) {}
  process(order: Order) {
    this.validator.validate(order);  // 不要 mock 这个
    this.repo.save(order);
  }
}

// 通过公共接口测试
const service = new OrderService(realValidator, mockRepo);
service.process(order);
```

## Mock 类型

### Stub（桩）

返回预设值。不验证交互。

```typescript
const stubRepo = {
  findById: vi.fn().mockResolvedValue({ id: '1', total: 100 }),
};
```

用于：你需要依赖返回数据，但不关心它被如何调用。

### Spy（间谍）

记录调用但不改变行为。

```typescript
const spyLogger = {
  log: vi.fn(),
};
// 后续：expect(spyLogger.log).toHaveBeenCalledWith('Order processed', order)
```

用于：你想验证某个调用发生了，但不需要改变行为。

### Mock（模拟）

预设行为并验证交互。

```typescript
const mockRepo = {
  save: vi.fn().mockResolvedValue(undefined),
};
// 后续：expect(mockRepo.save).toHaveBeenCalledWith(expectedOrder)
```

用于：你需要控制行为并验证交互。

## 反模式

### 过度 Mock

每个依赖都被 mock 了。测试与实现高度耦合。重构时测试到处失败。

**信号**：你的测试中 mock 设置比断言还多。

**修复**：用真实代码替换尽可能多的 mock。只 mock 你无法运行的东西。

### Mock 你正在测试的东西

```typescript
// 绝对不要这样做
const mockService = vi.fn().mockResolvedValue(result);
expect(mockService()).toEqual(result);  // 这什么都没测试
```

### Mock 返回 Mock

```typescript
// 这说明你的接口太大了
const mockUser = {
  getProfile: vi.fn().mockReturnValue({
    getSettings: vi.fn().mockReturnValue({
      getTheme: vi.fn().mockReturnValue('dark'),
    }),
  }),
};
```

**修复**：简化接口。返回数据，不是对象图。

## 指导

1. **默认使用真实代码。** 只有在无法运行真实代码时才 mock。
2. **在边界 Mock。** Mock 外部依赖（网络、数据库、文件系统），而非内部协作者。
3. **Mock 数据，不是行为。** 返回简单数据，不是复杂对象图。
4. **Mock 最小接口。** 只 mock 测试需要的方法，不是整个接口。
5. **当你发现自己 mock 了太多东西时，重新考虑设计。** 难以测试的代码通常需要更好的接口，不是更多的 mock。
