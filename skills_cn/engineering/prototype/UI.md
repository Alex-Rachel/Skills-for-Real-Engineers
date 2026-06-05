# UI 原型

验证用户界面或交互流程的原型。

## 何时使用

当你需要验证 UI 但不需要后端逻辑时。常见场景：

- 布局在移动端是否可行？
- 用户能否在 3 步内完成任务？
- 某个交互模式是否直观？
- 设计在真实数据下是否好看？

## 方法

### HTML 原型

最简单的形式：一个 HTML 文件，带有内联 CSS 和 JS。

```html
<!doctype html>
<html>
  <head>
    <style>
      /* 所有样式内联 */
      .card { border: 1px solid #ccc; padding: 16px; }
    </style>
  </head>
  <body>
    <div class="card">
      <!-- 硬编码数据 -->
      <h2>订单 #1234</h2>
      <p>总计：$29.97</p>
    </div>
    <script>
      // 最少的交互
      document.querySelector('.card').addEventListener('click', () => {
        alert('原型：将打开订单详情');
      });
    </script>
  </body>
</html>
```

优点：零设置、浏览器中即时运行、容易共享。
缺点：没有组件复用、没有状态管理。

### 组件原型

在现有框架中构建单个组件或页面。

```tsx
// 硬编码所有数据，没有 API 调用
export function OrderCard() {
  const order = { id: '1234', total: 29.97, status: 'pending' };
  return (
    <div className="card">
      <h2>订单 #{order.id}</h2>
      <p>总计：${order.total}</p>
    </div>
  );
}
```

优点：使用真实框架、可复用组件、真实样式。
缺点：需要项目设置。

### Storybook 方法

在 Storybook 中构建原型。

```tsx
export default {
  title: 'Prototypes/OrderFlow',
};

export const HappyPath = () => <OrderFlow steps={hardcodedSteps} />;
export const EdgeCase = () => <OrderFlow steps={emptySteps} />;
```

优点：隔离、易于迭代、内置文档。
缺点：需要 Storybook 设置。

## 指导

- **从 HTML 开始。** 如果单个 HTML 文件够用，就用它。不要启动 dev server 来原型化一个布局。
- **硬编码数据。** 没有获取、没有状态管理、没有 API 调用。直接把数据放在组件中。
- **模拟交互。** 用 `alert()` 或 `console.log()` 代替真实行为。你是在验证流程，不是构建功能。
- **不要构建响应式。** 除非你专门原型化响应式设计，否则只做一个断点。
- **截屏。** 在不同状态下截屏，这样你就有记录而不需要保留代码。
