---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 当前迭代计划，聚焦新基线对齐、架构融合与 Web 主线准备。
---

# 当前迭代计划

## 迭代目标

把 ProjectPilot 从“历史基线遗留 + 文档主线分散”的状态，收敛为“目标技术基线明确、后端基线已验证、Web 工程方向明确、迁移路线明确”的状态。

纠偏时继续参考 Harness Engineering，但仅把它作为工程方法，而不是当前产品范围本身。相关说明见 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)。

## 本迭代范围

| 优先级 | 事项 | 产出 |
| --- | --- | --- |
| P0 | 统一文档主线到 JDK 17 / Spring Boot 3.x / Vue 3 | [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md) |
| P0 | 明确如何吸收 CallCenter 的工程结构经验 | [docs/architecture/callcenter-reference-adaptation.md](../architecture/callcenter-reference-adaptation.md) |
| P0 | 形成代码迁移路线、验收标准并完成后端最小基线验证 | [docs/plans/jdk17-springboot3-migration-roadmap.md](jdk17-springboot3-migration-roadmap.md) |
| P1 | 明确后端模块化单体目标结构 | [docs/architecture/overview.md](../architecture/overview.md)、[docs/architecture/boundaries.md](../architecture/boundaries.md) |
| P1 | 明确 Web 前端目标工程结构 | [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md) |
| P2 | 持续维护 API 与错误码基线 | [docs/reference/README.md](../reference/README.md) |
| P2 | 补齐评审、自检与验证闭环 | [docs/reviews/README.md](../reviews/README.md)、[docs/conventions/README.md](../conventions/README.md) |
| P3 | 保留最小必要的发布与可观测性支撑材料 | [deploy/release/README.md](../../deploy/release/README.md)、[deploy/observability/README.md](../../deploy/observability/README.md) |

## 开发约束

- 不再把 JDK 1.8、Spring Boot 2.7 或 MySQL 5.7 作为新增设计默认前提。
- 新代码主线以 JDK 17、Spring Boot 3.x、MySQL 8.x、Vue 3、TypeScript、Vite 为准。
- 外部集成必须通过 adapter 或 `ApiClient` 抽象。
- 新增业务代码必须有测试。
- 涉及数据库结构时必须通过 Flyway migration 管理。
- 工程治理服务于 Web 产品研发，不反客为主。

## 验收标准

- 文档导航已经能够明确区分目标基线、迁移路线和 Web 主线。
- 关键架构文档已经不再以旧基线作为默认事实来源。
- 已形成面向后续代码升级的可执行迁移路线，且 `server/` 已在新基线下通过最小验证。
- AI 与人工在开发、评审、测试和发布时都能快速定位应联读的文档。

## 风险

- `server/` 虽已完成版本基线升级验证，但目标模块化单体结构仍未落地完成。
- `web/` 尚未完整建立，前端工程方向仍需后续落地。
- 历史命名、脚本和工作流仍可能带有旧标识。
