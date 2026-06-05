● 1. 这个项目怎么用？

  这是 Matt Pocock 创建的 AI 编程代理技能包（Skills），核心哲学是：小而可组合的技能，而非大而全的框架。
  安装方式：
  npx skills@latest add mattpocock/skills  
  安装后，这些技能会作为斜杠命令（如 /tdd、/diagnose）在 Claude Code 中可用。首次使用需要运行 /setup-matt-pocock-skills 配置项目（issue tracker、triage 标签、文档路径等）。

  核心理念： 项目识别了 AI 代理的 4 种失败模式，每个技能对应解决一个：

  ┌──────────────────────────────────┬────────────────────────────────────────────────────┐
  │             失败模式             │                      解决技能                      │
  ├──────────────────────────────────┼────────────────────────────────────────────────────┤
  │ Agent 没做我想要的事（对齐失败） │ /grill-me、/grill-with-docs                        │
  ├──────────────────────────────────┼────────────────────────────────────────────────────┤
  │ Agent 太啰嗦（没有共享语言）     │ CONTEXT.md + /grill-with-docs                      │
  ├──────────────────────────────────┼────────────────────────────────────────────────────┤
  │ 代码不工作（没有反馈循环）       │ /tdd（红绿重构）、/diagnose                        │
  ├──────────────────────────────────┼────────────────────────────────────────────────────┤
  │ 代码变成泥球（设计熵增）         │ /to-prd、/zoom-out、/improve-codebase-architecture │
  └──────────────────────────────────┴────────────────────────────────────────────────────┘

  ---
  2. 日常开发推荐流程

  这是一个从需求到交付的完整工作流，按顺序使用：

  阶段一：对齐（Alignment）

  /grill-with-docs  →  追问你的计划，建立共享领域语言，更新 CONTEXT.md 和 ADR
  在写任何代码之前，先让 Agent 像严厉的面试官一样追问你的设计，消除所有歧义。同时建立 CONTEXT.md（领域术语表）和 docs/adr/（架构决策记录）。

  阶段二：规格化（Specification）

  /to-prd  →  把对话上下文合成 PRD，提交为 GitHub Issue
  /to-issues  →  把 PRD 拆解为可独立领取的垂直切片 Issue

  阶段三：实现（Implementation）

  /tdd  →  红绿重构循环，一次一个垂直切片
  严格遵循：写失败测试 → 让它通过 → 重构。每次只做一个垂直切片。

  阶段四：诊断与修复（Debugging）

  /diagnose  →  复现 → 最小化 → 假设 → 探测 → 修复 → 回归测试
  6 阶段严格诊断流程，10 种反馈循环策略按优先级排列。

  阶段五：架构治理（Architecture）

  /improve-codebase-architecture  →  找到"浅模块"，深化为"深模块"
  /zoom-out  →  Agent 陷得太深时，拉到系统全局视角

  辅助技能

  - /grill-me — 不涉及代码的纯设计追问
  - /prototype — 一次性原型验证设计（逻辑原型 or UI 原型）
  - /handoff — 压缩当前对话为交接文档，给下一个 Agent 继续
  - /caveman — 极简通信模式，省 ~75% token

  ---
  3. 与 OpenSpec 工作流的区别

  ┌──────────┬─────────────────────────────────────────────┬───────────────────────────────────────────────────────────────────────────┐
  │   维度   │                  OpenSpec                   │                            Matt Pocock Skills                             │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 哲学     │ 规格驱动（Spec-Driven），先写完整规格再实现 │ 技能驱动（Skill-Driven），小而可组合的原子操作                            │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 规格形式 │ 严格的规格文档/协议定义                     │ PRD + CONTEXT.md + ADR，轻量且渐进式                                      │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 对齐方式 │ 规格本身就是对齐，写完即锁定                │ /grill-with-docs 主动追问，通过对话消除歧义，规格是对齐的产物而非前提     │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 实现方式 │ 规格 → 实现（自顶向下）                     │ /tdd 红绿重构（自底向上，一次一个垂直切片）                               │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 反馈循环 │ 规格验证（规格是否被满足）                  │ /diagnose 6 阶段诊断 + TDD 的即时反馈，强调可运行的反馈循环               │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 架构治理 │ 通常依赖规格中的架构约束                    │ /improve-codebase-architecture 主动发现浅模块并深化，基于"深模块"理论     │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 粒度     │ 大规格文档，整体性                          │ 每个技能独立可用，你可以只用 /tdd 或只用 /diagnose                        │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 适应性   │ 规格变更成本高                              │ 渐进式，CONTEXT.md 和 ADR 随时更新，不追求一次性完美                      │
  ├──────────┼─────────────────────────────────────────────┼───────────────────────────────────────────────────────────────────────────┤
  │ 语言对齐 │ 依赖规格中的术语定义                        │ CONTEXT.md 领域术语表 + /grill-with-docs 持续维护，Agent 和人共享同一语言 │
  └──────────┴─────────────────────────────────────────────┴───────────────────────────────────────────────────────────────────────────┘

  核心区别总结：

  1. OpenSpec 是"先想清楚再动手" — Skills 是"边想边做，持续对齐"。/grill-with-docs 把追问嵌入工作流，而不是假设规格已经完美。
  2. OpenSpec 的规格是输入 — Skills 的 PRD/CONTEXT.md/ADR 是输出，是工作过程的沉淀，不是前提条件。
  3. Skills 更抗熵增 — /improve-codebase-architecture 和 /diagnose 是持续治理工具，OpenSpec 通常在规格写完后缺乏持续纠偏机制。
  4. Skills 更灵活 — 你可以按需组合，不强制全流程。OpenSpec 倾向于全有或全无。
  5. Skills 的反馈循环更强 — /diagnose 的 10 种反馈循环策略和 /tdd 的红绿重构，都是可运行的验证，而非文档层面的规格检查。

✻ Brewed for 8m 14s

❯ 假设我要做个Unity的连招系统，使用Matt Pocock Skills  请给我完整举例子我要怎么做？                                                                                                                                                                                                                                    

● Skill(superpowers:brainstorming)
  ⎿  PreToolUse:Skill hook error                                                                                                                              ⎿  Failed with non-blocking status code: node:internal/modules/esm/get_format:219
  ⎿  Successfully loaded skill

● 好的，让我用一个 Unity 连招系统（Combo System） 作为完整案例，走一遍 Matt Pocock Skills 的每个阶段。

  ---
  阶段一：对齐 — /grill-with-docs

  你打开 Claude Code，输入：
  /grill-with-docs

  然后告诉 Agent 你的想法：

  ▎ 我想做一个 Unity 连招系统，玩家按攻击键可以连续出招，比如 轻→轻→重→重 这样。

  Agent 会像严厉的面试官一样追问你。以下是典型的追问对话：

  ---
  Agent： 连招的"连"是什么意思？是固定序列（必须 轻→轻→重），还是任意组合（任何招式都能接任何招式）？

  你： 是固定序列，每招有预定义的后续可接招式。

  Agent： 如果玩家在连招中间停顿太久怎么办？整个连招重置？还是停在当前招式？

  你： 超时重置回 idle 状态。每招有自己的时间窗口。

  Agent： 连招能被中断吗？比如被击飞、被格挡？

  你： 能，被击飞立即中断。格挡的话当前招式打完但后续不能接。

  Agent： 连招的动画怎么管理？是 Animator Controller 的状态机，还是动画代码驱动？

  你： 代码驱动，不用 Animator Controller。用 Playable API 或者简单的 AnimationClip 播放。

  Agent： 输入检测是在 Update 里轮询，还是事件驱动？

  你： Unity 新输入系统，事件驱动，回调注册。

  Agent： 网络同步呢？连招输入需要同步到其他客户端吗？

  你： 暂不考虑，单机先。

  ---
  追问结束后，Agent 会自动生成/更新两个文件：

  CONTEXT.md（领域术语表）

  # Context

  ## Combo System

  - **Combo Sequence** — 预定义的招式链，如 軻→轻→重。不是任意组合。
  - **Combo Step** — 连招中的单个招式，包含动画、时间窗口、伤害帧。
  - **Input Window** — 当前招式结束后可接受下一招输入的时间窗口，超时则连招重置。
  - **Combo Reset** — 连招中断，角色回到 idle 状态。触发条件：超时、被击飞。
  - **Combo Cancel** — 当前招式打完但后续不可接。触发条件：被格挡。
  - **Hit Frame** — 招式动画中产生伤害判定的帧。
  - **Input Buffer** — 在时间窗口内缓存玩家输入，用于判定下一招。

  ## Architecture

  - 输入层：Unity 新输入系统，事件驱动
  - 状态层：代码驱动的有限状态机，不用 Animator Controller
  - 动画层：Playable API / AnimationClip 直接播放
  - 判定层：Hit Frame 触发伤害检测

  docs/adr/0001-code-driven-animation.md

  # 0001: Code-Driven Animation for Combo System

  ## Status
  Accepted

  ## Context
  Unity Animator Controller 在连招系统中难以精确控制过渡时机和输入窗口。
  需要每帧检测输入窗口和 Hit Frame，Animator Controller 的状态机与代码状态机容易不同步。

  ## Decision
  使用代码驱动的有限状态机 + Playable API 播放动画，不使用 Animator Controller。

  ## Consequences
  - 优点：输入窗口和状态转换完全可控，与逻辑状态机天然同步
  - 缺点：失去 Animator Controller 的可视化编辑和过渡预览
  - 缺点：需要手动管理动画混合和过渡

  ---
  阶段二：规格化 — /to-prd + /to-issues

  /to-prd

  /to-prd

  Agent 把之前的对话和 CONTEXT.md 合成 PRD，提交为 GitHub Issue：

  # PRD: Unity Combo System

  ## Overview
  代码驱动的连招系统，支持固定序列连招、输入窗口、中断/取消机制。

  ## Core Requirements

  ### 1. Combo Definition
  - 连招由预定义的招式序列组成（如 軻→轻→重→重）
  - 每个 ComboStep 包含：动画片段、输入窗口时长、伤害帧列表
  - 配置数据驱动，策划可 ScriptableObject 配表

  ### 2. Input Detection
  - Unity 新输入系统，事件驱动
  - InputBuffer 缓存窗口期内的输入
  - 超时未输入 → Combo Reset

  ### 3. State Machine
  - 代码驱动的 FSM：Idle → ComboStep1 → ComboStep2 → ... → Idle
  - 每个状态有 OnEnter / OnUpdate / OnExit 生命周期
  - 支持中断（被击飞 → 立即 Reset）
  - 支持取消（被格挡 → 当前招式打完，不可接后续）

  ### 4. Animation
  - Playable API 播放 AnimationClip
  - 招式间过渡用 CrossFade
  - Hit Frame 在动画特定时间点触发伤害判定

  ### 5. Hit Detection
  - Hit Frame 触发时，根据当前招式的碰撞体配置做伤害检测
  - 每个招式可配置不同的判定形状和偏移

  ## Non-Goals
  - 网络同步
  - Animator Controller 集成
  - 连招编辑器可视化工具（后续迭代）

  /to-issues

  /to-issues

  Agent 把 PRD 拆解为垂直切片（每个 Issue 可独立完成、独立验证）：

  ┌───────┬────────────────────────────────────────────┬───────────────────────────────────────────────────────┐
  │ Issue │                  垂直切片                  │                       验收标准                        │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #1    │ ComboStep 数据模型 + ScriptableObject 配表 │ 能在 Inspector 里配置一个 3 招连招，运行时能读取      │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #2    │ 代码驱动的 FSM 框架                        │ FSM 能 Idle → Step1 → Step2 → Idle 转换，打印日志验证 │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #3    │ InputBuffer + 输入窗口检测                 │ 按键在窗口内 → 进入下一招，超时 → 回 Idle             │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #4    │ Playable API 动画播放 + CrossFade          │ 每个状态切换播放对应动画，过渡平滑                    │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #5    │ Hit Frame 触发 + 伤害判定                  │ 动画播放到 Hit Frame 时间点时，触发碰撞检测并输出伤害 │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #6    │ 中断机制（被击飞 Reset）                   │ 被击飞时立即中断当前招式，回到 Idle                   │
  ├───────┼────────────────────────────────────────────┼───────────────────────────────────────────────────────┤
  │ #7    │ 取消机制（被格挡 Cancel）                  │ 被格挡时当前招式播完，不接后续                        │
  └───────┴────────────────────────────────────────────┴───────────────────────────────────────────────────────┘

  ---
  阶段三：实现 — /tdd

  现在逐个 Issue 用 TDD 实现。以 Issue #2（FSM 框架） 为例：

  /tdd

  Agent 进入红绿重构循环：

  🔴 Red — 写失败测试

  [Test]
  public void Transition_FromIdle_ToComboStep1_OnAttackInput()
  {
      var fsm = new ComboFSM();
      fsm.Start(); // 初始状态 = Idle

      fsm.HandleInput(ComboInput.LightAttack);

      Assert.AreEqual(ComboState.Step1, fsm.CurrentState);
  }

  [Test]
  public void Transition_FromStep1_ToStep2_OnHeavyInput_WithinWindow()
  {
      var fsm = new ComboFSM();
      fsm.Start();
      fsm.HandleInput(ComboInput.LightAttack); // → Step1

      fsm.HandleInput(ComboInput.HeavyAttack); // → Step2

      Assert.AreEqual(ComboState.Step2, fsm.CurrentState);
  }

  [Test]
  public void Transition_FromStep1_ToIdle_OnTimeout()
  {
      var fsm = new ComboFSM();
      fsm.Start();
      fsm.HandleInput(ComboInput.LightAttack); // → Step1

      fsm.Update(windowDuration + 0.1f); // 超时

      Assert.AreEqual(ComboState.Idle, fsm.CurrentState);
  }

  🟢 Green — 最小实现让测试通过

  public class ComboFSM
  {
      public ComboState CurrentState { get; private set; } = ComboState.Idle;
      private float _windowTimer;

      public void Start() => CurrentState = ComboState.Idle;

      public void HandleInput(ComboInput input)
      {
          if (CurrentState == ComboState.Idle && input == ComboInput.LightAttack)
          {
              CurrentState = ComboState.Step1;
              _windowTimer = 0f;
          }
          else if (CurrentState == ComboState.Step1 && input == ComboInput.HeavyAttack)
          {
              CurrentState = ComboState.Step2;
              _windowTimer = 0f;
          }
      }

      public void Update(float deltaTime)
      {
          if (CurrentState != ComboState.Idle)
          {
              _windowTimer += deltaTime;
              if (_windowTimer > windowDuration)
                  CurrentState = ComboState.Idle;
          }
      }
  }

  🔵 Refactor — 消除硬编码，引入状态转换表

  public class ComboFSM
  {
      private readonly Dictionary<(ComboState, ComboInput), ComboState> _transitions;
      public ComboState CurrentState { get; private set; } = ComboState.Idle;
      private float _windowTimer;

      public ComboFSM(ComboDefinition definition)
      {
          _transitions = definition.BuildTransitionTable();
      }

      public void HandleInput(ComboInput input)
      {
          if (_transitions.TryGetValue((CurrentState, input), out var next))
          {
              CurrentState = next;
              _windowTimer = 0f;
          }
      }

      public void Update(float deltaTime)
      {
          if (CurrentState == ComboState.Idle) return;
          _windowTimer += deltaTime;
          if (_windowTimer > _currentWindowDuration)
              Reset();
      }

      public void Reset() => CurrentState = ComboState.Idle;
  }

  然后继续 Issue #3、#4、#5... 每个 Issue 都走完整的红绿重构。

  ---
  阶段四：诊断 — /diagnose

  假设集成测试时发现：连招第二招偶尔丢失输入。

  /diagnose

  Agent 进入 6 阶段诊断：

  1. 建立反馈循环

  选择策略：failing test（最优先）

  [Test]
  public void Step2_InputNotLost_WhenPressedEarlyInWindow()
  {
      var fsm = new ComboFSM(definition);
      fsm.Start();
      fsm.HandleInput(ComboInput.LightAttack);  // → Step1
      fsm.Update(0.05f);                         // 窗口刚开始

      fsm.HandleInput(ComboInput.HeavyAttack);   // → 应该进 Step2

      Assert.AreEqual(ComboState.Step2, fsm.CurrentState); // ❌ FAIL: 实际是 Step1
  }

  2. 复现 — 确认测试稳定失败 ✅

  3. 假设 — 生成 3-5 个可证伪假设

  ┌─────┬──────────────────────────────────────────────────────────┬────────┐
  │  #  │                           假设                           │ 优先级 │
  ├─────┼──────────────────────────────────────────────────────────┼────────┤
  │ H1  │ Update 在 HandleInput 之前被调用，导致窗口计时器还没重置 │ 高     │
  ├─────┼──────────────────────────────────────────────────────────┼────────┤
  │ H2  │ InputBuffer 没有缓存输入，帧间输入丢失                   │ 高     │
  ├─────┼──────────────────────────────────────────────────────────┼────────┤
  │ H3  │ 状态转换表中 (Step1, HeavyAttack) 映射错误               │ 中     │
  ├─────┼──────────────────────────────────────────────────────────┼────────┤
  │ H4  │ _windowTimer 重置时机不对                                │ 低     │
  └─────┴──────────────────────────────────────────────────────────┴────────┘

  4. 探测 — 每个假设一个探针

  // 探测 H1: 检查 Update 和 HandleInput 的调用顺序
  Debug.Log($"[H1] Before HandleInput: state={fsm.CurrentState}, timer={_windowTimer}");

  发现：HandleInput 被调用时，Update 已经把窗口计时器推进了，但状态转换检查的是旧计时器值。

  5. 修复 + 回归测试

  // 修复：HandleInput 应该重置计时器，且 Update 不应在 HandleInput 同帧再推进
  public void HandleInput(ComboInput input)
  {
      if (_transitions.TryGetValue((CurrentState, input), out var next))
      {
          CurrentState = next;
          _windowTimer = 0f;
          _inputConsumedThisFrame = true; // 标记本帧已消费输入
      }
  }

  public void Update(float deltaTime)
  {
      if (_inputConsumedThisFrame)
      {
          _inputConsumedThisFrame = false;
          return; // 本帧不推进计时器
      }
      // ...
  }

  6. 清理 + 复盘

  移除探针日志，记录：根因是 Update 和 HandleInput 同帧执行顺序问题，修复方式是加帧标记。

  ---
  阶段五：架构治理 — /improve-codebase-architecture

  做完所有 Issue 后：

  /improve-codebase-architecture

  Agent 分析代码库，发现浅模块：

  发现 1：ComboFSM 太浅

  // 问题：ComboFSM 同时做状态转换、计时、输入处理、动画触发
  // 接口面太大，功能太薄 → 浅模块
  public class ComboFSM
  {
      public void HandleInput(ComboInput input) { ... }
      public void Update(float deltaTime) { ... }
      public void Reset() { ... }
      public void OnHitFrame() { ... }
      public void OnInterrupt() { ... }
      public void OnCancel() { ... }
      // ... 8 个 public 方法，职责混杂
  }

  深化方案：拆为深模块

  // 深模块 1：纯状态转换，接口极窄
  public class ComboStateMachine
  {
      public ComboState CurrentState { get; }
      public void Transition(ComboInput input);  // 唯一入口
  }

  // 深模块 2：输入缓冲，接口极窄
  public class InputBuffer
  {
      public bool TryConsume(ComboInput expected, out ComboInput consumed);
      public void Push(ComboInput input);
  }

  // 深模块 3：窗口计时器，接口极窄
  public class ComboWindowTimer
  {
      public bool IsExpired { get; }
      public void Reset();
      public void Tick(float deltaTime);
  }

  // 组合层：薄薄的编排
  public class ComboController : MonoBehaviour
  {
      private readonly ComboStateMachine _fsm;
      private readonly InputBuffer _buffer;
      private readonly ComboWindowTimer _timer;

      void Update()
      {
          _timer.Tick(Time.deltaTime);
          if (_timer.IsExpired) _fsm.Transition(ComboInput.Timeout);
          if (_buffer.TryConsume(expected, out var input)) _fsm.Transition(input);
      }
  }

  每个模块接口窄、隐藏复杂度高 → 深模块。ComboController 只是薄薄的编排层。

  ---
  完整工作流一览

  ┌─────────────────────────────────────────────────────┐
  │  1. /grill-with-docs                                │
  │     "我想做 Unity 连招系统..."                       │
  │     → 追问 10+ 个问题，生成 CONTEXT.md + ADR        │
  ├─────────────────────────────────────────────────────┤
  │  2. /to-prd                                         │
  │     → 合成 PRD，提交 GitHub Issue                   │
  │  3. /to-issues                                      │
  │     → 拆为 7 个垂直切片 Issue                       │
  ├─────────────────────────────────────────────────────┤
  │  4. /tdd × 7 (每个 Issue)                           │
  │     Issue #1: 🔴Red → 🟢Green → 🔵Refactor         │
  │     Issue #2: 🔴Red → 🟢Green → 🔵Refactor         │
  │     ...                                              │
  │     Issue #7: 🔴Red → 🟢Green → 🔵Refactor         │
  ├─────────────────────────────────────────────────────┤
  │  5. /diagnose (遇到 bug 时)                         │
  │     复现→假设→探测→修复→回归                         │
  ├─────────────────────────────────────────────────────┤
  │  6. /improve-codebase-architecture                  │
  │     → 发现浅模块，深化为深模块                       │
  └─────────────────────────────────────────────────────┘

  关键点：每个技能独立可用。如果你只想用 /tdd 做 TDD，或只用 /diagnose 调试一个现有 bug，完全可以。不强制走全流程。