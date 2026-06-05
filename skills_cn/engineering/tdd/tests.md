# 测试

如何编写验证行为而非实现的测试。

## 好测试 vs 坏测试

### 好测试：通过公共接口验证行为

```typescript
// 好的 — 通过公共接口测试行为
describe('OrderService', () => {
  it('allows checkout with a valid cart', async () => {
    const cart = createCartWithItems([{ sku: 'A1', qty: 2 }]);
    const result = await orderService.checkout(cart);
    expect(result.status).toBe('confirmed');
    expect(result.total).toBe(29.97);
  });
});
```

这个测试：
- 使用公共接口（`checkout`）
- 描述用户可见行为（"可以用有效购物车结账"）
- 不关心实现细节
- 在完全重构后仍能存活

### 坏测试：与实现耦合

```typescript
// 坏的 — 与实现细节耦合
describe('OrderService', () => {
  it('calls validator then repo then email', async () => {
    const order = createOrder();
    await service.process(order);
    expect(mockValidator.validate).toHaveBeenCalled();      // 实现细节
    expect(mockRepo.save).toHaveBeenCalledWith(order);       // 实现细节
    expect(mockEmail.send).toHaveBeenCalled();               // 实现细节
  });
});
```

这个测试：
- 验证实现如何工作（调用顺序），而非结果是什么
- 重命名 `validator` 时会失败
- 将 `save` 改为 `upsert` 时会失败
- 重排调用顺序时会失败——即使行为完全相同

## 集成测试 vs 单元测试

### 集成测试（首选）

演练真实代码路径，使用真实依赖（或本地替身如 PGLite）。

```typescript
// 集成测试 — 真实代码路径
describe('Order checkout', () => {
  it('calculates tax based on shipping address', async () => {
    const service = new OrderService(realPricing, realTaxCalculator);
    const result = await service.checkout(orderWithNYAddress);
    expect(result.tax).toBe(closeTo(2.63));
  });
});
```

优点：验证真实行为、重构后存活、发现集成问题。
缺点：较慢、需要更多设置。

### 单元测试（用于纯逻辑）

隔离测试纯函数或算法。

```typescript
// 单元测试 — 纯逻辑
describe('calculateTax', () => {
  it('applies NY state tax rate', () => {
    expect(calculateTax(100, 'NY')).toBe(closeTo(8.875));
  });
});
```

优点：快速、简单、确定性。
缺点：不验证集成、可能遗漏连线问题。

### 经验法则

- **默认写集成测试。** 你想验证行为端到端可行。
- **对纯逻辑写单元测试。** 算法、计算、转换——没有依赖的东西。
- **永远不要为配线写单元测试。** 如果测试只是验证模块 A 调用了模块 B，那就是在测实现。

## 测试命名

测试名称应该描述行为，像规格说明一样读。

```typescript
// 好的 — 描述行为
it('rejects checkout when cart is empty')
it('applies discount code to order total')
it('sends confirmation email after successful checkout')

// 坏的 — 描述实现
it('calls validateCart before processing')
it('sets order.status to confirmed')
it('returns the result from repo.save')
```

## 断言

断言可观察的结果，而非内部状态。

```typescript
// 好的 — 断言可观察结果
expect(result.status).toBe('confirmed');
expect(result.total).toBe(29.97);
expect(result.emailSent).toBe(true);

// 坏的 — 断言内部状态
expect(service._orders.size).toBe(1);
expect(service._state).toBe('processing');
expect(mockRepo.save.calls.length).toBe(1);
```
