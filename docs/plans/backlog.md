---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 后续待办列表，覆盖 Web 主线、基线迁移、业务增强与工程硬化事项。
---

# Backlog

## 使用说明

- 当某个 backlog 项准备进入开发时，先回看 [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md) 判断它是否仍符合当前主线。
- 如果任务涉及架构、规范、评审或发布影响，回到 [docs/README.md](../README.md) 按场景补齐联读材料。
- 如果某项建设更像平台扩张而不是当前产品推进，先参考 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md) 做范围判断。

## P0：基线迁移与结构收敛

- 将 `server/` 实际代码迁移到 JDK 17。
- 将 `server/` 实际依赖迁移到 Spring Boot 3.x。
- 完成 `javax.* -> jakarta.*` 代码与依赖迁移。
- 将数据库运行基线切换到 MySQL 8.x。
- 收敛后端目录结构到模块化单体目标形态。

## P1：Web MVP 主线

- 建立 `web/` 前端工程与基础路由。
- 建立登录页与会话校验流程。
- 建立项目列表页与项目详情页。
- 建立任务列表页、任务创建与状态流转。
- 打通前后端联调链路。

## P2：核心业务增强

- 组织管理。
- 成员与角色管理。
- 项目与任务搜索。
- 用户注册、登录、登出和会话校验增强能力。

## P3：商业化能力

- 套餐管理。
- 订阅管理。
- 用量统计。
- 账单查询。
- 支付渠道适配抽象。

## P4：运营与质量支撑

- API 文档持续维护。
- 错误码治理。
- 审计日志。
- 指标和 telemetry。
- 发布文档与运行手册。
- 性能基准测试。

## P5：渐进式工程硬化

- 将 Harness Engineering 纠偏说明持续映射到导航、评审和验证材料。
- 只保留对 Web MVP 交付有直接帮助的工程护栏。
- 在真实主链路稳定后，再评估是否需要新增更重的平台化能力。

## Backlog 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 涉及架构或边界变化的任务必须同步 [docs/architecture/README.md](../architecture/README.md) 与对应文档。
- 涉及 API 的任务必须同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- 涉及错误码的任务必须同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 产品研发主线优先于平台治理主线，除非当前任务明确属于发布、运维或观测支撑建设。
- 如果某项建设无法直接帮助当前主线推进，应先放回 backlog，而不是立即扩张为独立体系。
