中文文档 | **[English](./README.md)**

<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 面向真正工程师的技能

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

我每天使用的代理技能，用于做真正的工程——而不是随意编码。

开发真正的应用很难。GSD、BMAD 和 Spec-Kit 等方法试图通过掌控流程来帮忙。但这样做的同时，它们夺走了你的控制权，使得流程中的 bug 难以解决。

这些技能被设计为小巧、易适配、可组合的。它们适用于任何模型。它们基于数十年的工程经验。随意折腾它们，让它们成为你自己的。享受吧。

如果你想跟进这些技能的变化以及我创建的任何新技能，你可以加入我的通讯，和约 60,000 名开发者一起：

[订阅通讯](https://www.aihero.dev/s/skills-newsletter)

## 快速开始（30 秒设置）

1. 运行 skills.sh 安装器：

```bash
npx skills@latest add mattpocock/skills
```

2. 选择你想要的技能，以及你想安装到哪些编码代理上。**确保选择 `/setup-matt-pocock-skills`**。

3. 在你的代理中运行 `/setup-matt-pocock-skills`。它会：
   - 询问你想使用哪个 issue 追踪器（GitHub、Linear 或本地文件）
   - 询问你在分流 issue 时使用哪些标签（`/triage` 使用标签）
   - 询问你想把创建的文档保存在哪里

4. 搞定——你准备好了。

## 为什么需要这些技能

我创建这些技能是为了修复我在 Claude Code、Codex 和其他编码代理中看到的常见失败模式。

### #1：代理没有做我想要的事

> "没有人确切知道自己想要什么"
>
> David Thomas & Andrew Hunt，[《程序员修炼之道》](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**。软件开发中最常见的失败模式是错位。你以为开发者知道你想要什么。然后你看到他们构建的东西——你意识到它根本没理解你的意图。

在 AI 时代也是一样。你和代理之间存在沟通鸿沟。解决方法是**追问会话**——让代理详细询问你要构建什么。

**解决方案**是使用：

- [`/grill-me`](./skills_cn/productivity/grill-me/SKILL.md) — 用于非代码场景
- [`/grill-with-docs`](./skills_cn/engineering/grill-with-docs/SKILL.md) — 与 [`/grill-me`](./skills_cn/productivity/grill-me/SKILL.md) 相同，但增加了更多好东西（见下文）

这些是我最受欢迎的技能。它们帮助你在开始之前与代理对齐，并深入思考你要做的变更。每次想要做变更时都使用它们。

### #2：代理太啰嗦了

> 有了统一语言，开发者之间的对话和代码的表达都源自同一个领域模型。
>
> Eric Evans，[《领域驱动设计》](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**问题**：在项目开始时，开发者和他们为之构建软件的人（领域专家）通常说着不同的语言。

我在代理身上感受到了同样的张力。代理通常被投入一个项目，并被要求自己去搞懂行话。所以它们用 20 个词来表达 1 个词就能说清的事。

**解决方案**是建立共享语言。这是一份帮助代理解码项目中行话的文档。

<details>
<summary>
示例
</summary>

这里有一个 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 的示例，来自我的 `course-video-manager` 仓库。哪个更容易读？

- **之前**："当课程中某个章节里的课被'实体化'时（即被分配了文件系统中的一个位置），会出现一个问题"
- **之后**："实体化级联存在问题"

这种简洁性在一次次会话中不断带来回报。

</details>

这已内置在 [`/grill-with-docs`](./skills_cn/engineering/grill-with-docs/SKILL.md) 中。它是一个追问会话，同时帮助你与 AI 建立共享语言，并在 ADR 中记录难以解释的决策。

很难解释这有多强大。它可能是这个仓库里最酷的技术。试试看就知道了。

> [!TIP]
> 共享语言除了减少啰嗦之外还有很多其他好处：
>
> - **变量、函数和文件的命名保持一致**，使用共享语言
> - 因此，**代码库对代理来说更容易导航**
> - 代理也**在思考上花费更少的 token**，因为它可以使用更简洁的语言

### #3：代码不工作

> "始终采取小的、深思熟虑的步骤。反馈的速率就是你的速度限制。永远不要承担太大的任务。"
>
> David Thomas & Andrew Hunt，[《程序员修炼之道》](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**：假设你和代理在构建什么上已经对齐了。当代理_仍然_产出垃圾时怎么办？

这时候需要审视你的反馈循环。没有关于代码实际运行情况的反馈，代理就是在盲飞。

**解决方案**：你需要常规的反馈循环组合：静态类型、浏览器访问和自动化测试。

对于自动化测试，红-绿-重构循环至关重要。代理先写一个失败的测试，然后修复测试。这帮助代理获得一致的反馈水平，从而产出更好的代码。

我构建了一个 **[`/tdd`](./skills_cn/engineering/tdd/SKILL.md) 技能**，可以插入任何项目。它鼓励红-绿-重构，并给代理大量关于什么是好测试和坏测试的指导。

对于调试，我还构建了一个 **[`/diagnose`](./skills_cn/engineering/diagnose/SKILL.md)** 技能，将最佳调试实践封装在一个简单的循环中。

### #4：我们构建了一个泥球

> "每天都要投资于系统的设计。"
>
> Kent Beck，[《解析极限编程》](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "最好的模块是深的。它们允许通过简单的接口访问大量功能。"
>
> John Ousterhout，[《软件设计哲学》](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**问题**：大多数用代理构建的应用都很复杂且难以变更。因为代理可以极大地加速编码，它们也加速了软件熵。代码库以前所未有的速度变得更加复杂。

**解决方案**是一种全新的 AI 驱动开发方法：关心代码的设计。

这已内建到这些技能的每一层：

- [`/to-prd`](./skills_cn/engineering/to-prd/SKILL.md) 在创建 PRD 之前询问你要涉及哪些模块
- [`/zoom-out`](./skills_cn/engineering/zoom-out/SKILL.md) 让代理在整个系统的上下文中解释代码

关键是，[`/improve-codebase-architecture`](./skills_cn/engineering/improve-codebase-architecture/SKILL.md) 帮助你拯救已经变成泥球的代码库。我建议每隔几天在代码库上运行一次。

### 总结

软件工程基础比以往任何时候都更重要。这些技能是我将这些基础浓缩为可重复实践的最佳努力，帮助你交付职业生涯中最好的应用。享受吧。

## 参考

### 工程

我每天用于代码工作的技能。

- **[diagnose](./skills_cn/engineering/diagnose/SKILL.md)** — 针对疑难 bug 和性能退化的规范诊断循环：复现 → 最小化 → 假设 → 插桩 → 修复 → 回归测试。
- **[grill-with-docs](./skills_cn/engineering/grill-with-docs/SKILL.md)** — 追问会话，对照现有领域模型挑战你的计划，锐化术语，并内联更新 `CONTEXT.md` 和 ADR。
- **[triage](./skills_cn/engineering/triage/SKILL.md)** — 通过分流角色的状态机对 issue 进行分流。
- **[improve-codebase-architecture](./skills_cn/engineering/improve-codebase-architecture/SKILL.md)** — 在代码库中寻找深化机会，参考 `CONTEXT.md` 中的领域语言和 `docs/adr/` 中的决策。
- **[setup-matt-pocock-skills](./skills_cn/engineering/setup-matt-pocock-skills/SKILL.md)** — 搭建其他工程技能所需的每仓库配置（issue 追踪器、分流标签词汇、领域文档布局）。每个仓库运行一次，然后才能使用 `to-issues`、`to-prd`、`triage`、`diagnose`、`tdd`、`improve-codebase-architecture` 或 `zoom-out`。
- **[tdd](./skills_cn/engineering/tdd/SKILL.md)** — 采用红-绿-重构循环的测试驱动开发。每次构建一个垂直切片的功能或修复 bug。
- **[to-issues](./skills_cn/engineering/to-issues/SKILL.md)** — 将任何计划、规格或 PRD 拆分为可独立抓取的 GitHub issue，使用垂直切片。
- **[to-prd](./skills_cn/engineering/to-prd/SKILL.md)** — 将当前对话上下文转化为 PRD 并提交为 GitHub issue。无需面试——直接综合你已经讨论的内容。
- **[zoom-out](./skills_cn/engineering/zoom-out/SKILL.md)** — 让代理拉远视角，对不熟悉的代码段给出更广泛的上下文或更高层的视角。
- **[prototype](./skills_cn/engineering/prototype/SKILL.md)** — 构建一次性原型来充实设计——要么是一个可运行的终端应用用于状态/业务逻辑问题，要么是几个可从一个路由切换的截然不同的 UI 变体。

### 生产力

通用工作流工具，不限于代码。

- **[caveman](./skills_cn/productivity/caveman/SKILL.md)** — 超压缩通信模式。通过去除填充词减少约 75% 的 token 使用，同时保持完整的技术准确性。
- **[grill-me](./skills_cn/productivity/grill-me/SKILL.md)** — 对计划或设计进行无情的追问面试，直到决策树的每个分支都被解决。
- **[handoff](./skills_cn/productivity/handoff/SKILL.md)** — 将当前对话压缩为交接文档，以便另一个代理可以继续工作。
- **[write-a-skill](./skills_cn/productivity/write-a-skill/SKILL.md)** — 创建具有正确结构、渐进式披露和捆绑资源的新技能。

### 杂项

我保留但很少使用的工具。

- **[git-guardrails-claude-code](./skills_cn/misc/git-guardrails-claude-code/SKILL.md)** — 设置 Claude Code 钩子，在执行前阻止危险的 git 命令（push、reset --hard、clean 等）。
- **[migrate-to-shoehorn](./skills_cn/misc/migrate-to-shoehorn/SKILL.md)** — 将测试文件从 `as` 类型断言迁移到 @total-typescript/shoehorn。
- **[scaffold-exercises](./skills_cn/misc/scaffold-exercises/SKILL.md)** — 创建包含章节、问题、解决方案和讲解的练习目录结构。
- **[setup-pre-commit](./skills_cn/misc/setup-pre-commit/SKILL.md)** — 设置带有 lint-staged、Prettier、类型检查和测试的 Husky 预提交钩子。
