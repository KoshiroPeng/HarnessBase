---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 当前迭代计划

## 迭代目标

把 ProjectPilot 从“工程与交付骨架优先”纠偏为“Web 产品研发优先”，完成第一阶段 MVP 的前置准备和最小功能闭环。

纠偏时继续参考 Harness Engineering，但仅把它作为工程方法，而不是当前产品范围本身。相关说明见 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)。

如果要直接开始执行当前迭代中的任务，建议先阅读 [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)。

## 本迭代范围

| 优先级 | 事项 | 产出 |
| --- | --- | --- |
| P0 | 明确 Web MVP 范围与页面路线 | [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md) |
| P0 | 初始化 `web/` 前端工程 | `web/` |
| P0 | 落地认证、项目、任务的最小后端闭环 | `server/` |
| P0 | 建立前后端联调链路 | `web/` + `server/` |
| P1 | 细化项目、任务、成员与权限设计 | [docs/design/README.md](../design/README.md) |
| P1 | 持续维护 API 与错误码基线 | [docs/reference/README.md](../reference/README.md) |
| P2 | 补齐测试、评审和自检闭环 | [docs/reviews/README.md](../reviews/README.md)、[docs/conventions/README.md](../conventions/README.md) |
| P3 | 保留最小必要的发布与可观测性支撑材料 | [deploy/release/README.md](../../deploy/release/README.md)、[deploy/observability/README.md](../../deploy/observability/README.md) |

## 开发约束

- 不升级 JDK、Spring Boot、Maven、MySQL 或持久化框架。
- 不引入 JPA 或 Hibernate。
- 新增业务代码必须有 JUnit 5 测试。
- 涉及数据库结构时必须通过 Flyway migration 管理。
- 工程治理服务于 Web 产品研发，不反客为主。

## 验收标准

- `web/` 前端工程已建立。
- 至少有一条完整用户主流程可以从页面走通到后端接口。
- Auth / Project / Task 三类核心能力已具备最小闭环。
- API 与错误码能够支撑前后端联调。
- 现有工程规范、评审清单和测试规则仍可持续约束开发。

## 风险

- 仓库文档与流程曾明显偏向交付治理，容易继续挤占产品研发时间。
- `web/` 尚未建立，前后端联调链路暂不存在。
- 功能设计仍偏主题占位，尚未细化到页面、路由和交互层。
