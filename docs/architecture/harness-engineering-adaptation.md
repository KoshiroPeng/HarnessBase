---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# Harness Engineering 纠偏说明

## 目标

本文档用于说明 Harness Engineering 思想在 HernessDemo 中的正确用法，避免把它误解为“继续建设交付平台本体”。

在当前仓库中，Harness Engineering 不是产品范围，不是独立业务模块，也不是优先级高于 Web MVP 的建设目标。它应被理解为一种工程方法，用来帮助我们更稳定、更可追踪、更可验证地交付 Web 产品。

## 当前纠偏结论

对本项目而言，Harness Engineering 应落在下面这句话上：

> 用工程化约束、可执行验证和清晰导航，降低 Web 产品研发的不确定性。

它不应落在下面这些方向上：

- 继续扩大“交付平台化”文档体系
- 把发布治理当成当前产品主线
- 在业务还未闭环前提前建设过多平台抽象
- 用平台术语替代真实产品术语和用户场景

## 在本项目中的正确落点

### 1. 主线优先

当前第一优先级始终是 Web 产品 MVP：

- 登录与会话
- 项目
- 任务
- 成员与权限
- 前后端联调

Harness Engineering 在这里的作用，是保证这条主线可以被稳定推进，而不是把注意力转移到额外平台建设上。

### 2. 文档即导航

Harness Engineering 强调把知识沉淀成可复用的操作界面。

在本项目里，它对应为：

- [AGENTS.md](../../AGENTS.md) 作为统一规则入口
- [docs/README.md](../README.md) 作为统一任务导航入口
- [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md) 作为直接执行任务的最短启动入口
- [docs/reviews/README.md](../reviews/README.md) 作为统一评审入口
- [deploy/release/README.md](../../deploy/release/README.md) 作为发布支撑入口

也就是说，文档要帮助人和 AI 快速找到下一步，而不是堆积概念。

### 3. 规则即护栏

Harness Engineering 不是“写很多制度”，而是把真正高价值的约束前置。

在本项目里，高价值护栏包括：

- 固定技术栈基线
- 固定分层依赖方向
- Flyway 管理数据库迁移
- `ApiClient` 统一外部调用抽象
- JUnit 5 测试与回归要求
- CI 中的架构、迁移、文件规模检查

这些护栏的目的，是减少返工和偏航，不是增加额外流程负担。

### 4. 评审即收敛

Harness Engineering 强调在需求、设计、代码、测试阶段持续收敛风险。

在本项目里，这意味着：

- 需求评审先判断是否符合当前 Web MVP 主线
- 设计评审先判断是否围绕业务闭环最小实现
- 代码评审先判断是否引入不必要的平台化抽象
- 测试评审先判断是否覆盖真实主链路与回归风险

评审的目标不是扩大范围，而是收敛范围。

### 5. 交付即支撑

发布、回滚、环境变量、可观测性都很重要，但它们在当前阶段的定位是“支撑产品交付”。

所以本项目保留：

- `deploy/release/`
- `deploy/observability/`

但不再把它们放在 `docs/` 主线中扩张为大量平台化专题。

### 6. 渐进硬化

Harness Engineering 适合做“先有最小闭环，再逐步硬化”。

在本项目里推荐顺序是：

1. 先打通 MVP 主链路
2. 再补齐评审、测试、错误码、API 文档
3. 再增强发布、回滚、观测和自动化护栏
4. 最后才评估是否需要更重的平台能力

## 评估一项文档或建设是否偏航

如果一项文档或改动满足下面大多数条件，就说明它更符合当前项目的 Harness Engineering 用法：

- 能直接帮助 Web MVP 研发推进
- 能降低需求、设计、开发、测试、发布中的不确定性
- 能让人或 AI 更快找到规则、入口或验证路径
- 能沉淀为后续反复复用的最小操作材料
- 不会引入超前的平台抽象

如果一项文档或改动更像下面这样，就应谨慎：

- 主要在描述平台概念，而不是当前产品问题
- 对当前 MVP 推进没有直接帮助
- 增加了很多流程名词，但没有带来可执行验证
- 需要维护大量结构，却没有稳定使用者
- 抢占了产品设计和业务实现的时间

## 当前仓库中的具体执行原则

- 如果任务是产品功能开发，优先更新 [docs/design/README.md](../design/README.md)、[docs/plans/README.md](../plans/README.md)、[docs/reference/README.md](../reference/README.md)。
- 如果任务是工程约束补强，优先更新 [AGENTS.md](../../AGENTS.md)、[docs/conventions/README.md](../conventions/README.md)、[docs/reviews/README.md](../reviews/README.md)。
- 如果任务是发布和运行支撑，优先更新 [deploy/release/README.md](../../deploy/release/README.md)、[deploy/observability/README.md](../../deploy/observability/README.md)。
- 除非有明确新需求，否则不再恢复 `docs/delivery/`、`docs/operations/`、`docs/governance/` 这类扩张型目录。

## 一句话准则

在 HernessDemo 里，Harness Engineering 的正确用法不是“多做平台”，而是“让 Web 产品研发更稳、更清楚、更可验证”。
