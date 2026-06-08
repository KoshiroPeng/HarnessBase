---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 计划文档目录入口，汇总当前迭代、迁移路线、后续待办与任务状态模板。
---

# 计划文档总览

## 目标

本目录沉淀 ProjectPilot 的当前迭代计划、技术迁移路线和后续待办，帮助协作者理解项目现在在做什么、下一步准备做什么。

当前阶段的计划主线已经明确调整为：先统一新基线和目标结构，再推进 Web 产品研发与代码迁移。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 当前迭代计划 | [docs/plans/current-sprint.md](current-sprint.md) |
| JDK 17 / Spring Boot 3 迁移路线 | [docs/plans/jdk17-springboot3-migration-roadmap.md](jdk17-springboot3-migration-roadmap.md) |
| 后续待办 | [docs/plans/backlog.md](backlog.md) |
| 任务状态模板 | [docs/plans/task-status-template.md](task-status-template.md) |

## 使用建议

- 如果要先理解当前产品主线，优先阅读 [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md) 和 [docs/plans/current-sprint.md](current-sprint.md)。
- 如果要理解“文档已经切到新基线，但代码还未完全迁移”应该怎么处理，优先阅读 [docs/plans/jdk17-springboot3-migration-roadmap.md](jdk17-springboot3-migration-roadmap.md)。
- 如果任务已经准备开始执行，但还不确定要联读哪些规范、评审和支撑文档，优先阅读 [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)。
- 如果要判断某个计划项是否过度平台化，优先阅读 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)。
- 如果要统一记录任务执行状态，优先使用 [docs/plans/task-status-template.md](task-status-template.md)。

## 维护规则

- 迭代目标变化时，优先更新 [docs/plans/current-sprint.md](current-sprint.md)。
- 技术迁移路线变化时，优先更新 [docs/plans/jdk17-springboot3-migration-roadmap.md](jdk17-springboot3-migration-roadmap.md)。
- 新增后续事项时，优先更新 [docs/plans/backlog.md](backlog.md)。
