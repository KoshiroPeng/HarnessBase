---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 计划文档目录入口，汇总当前迭代、后续待办与任务状态模板。
---

# 计划文档总览

## 目标

本目录沉淀 HarnessBase 当前文档与工程收敛计划，帮助协作者理解现在要修正什么、下一步准备做什么。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 当前迭代计划 | [docs/plans/current-sprint.md](current-sprint.md) |
| 后续待办 | [docs/plans/backlog.md](backlog.md) |
| 前后端接口差异修复任务说明 | [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) |
| 文档收口状态说明 | [docs/plans/documentation-closure-status.md](documentation-closure-status.md) |
| 自动化接入总导航页 | [docs/plans/automation-delivery-map.md](automation-delivery-map.md) |
| 自动化阶段验收清单 | [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md) |
| Harness 自动化实施简报 | [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) |
| 第一阶段文档检查 CI 接入说明 | [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md) |
| 第二阶段历史事实扫描接入说明 | [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md) |
| 第三阶段 workflow 路径检查接入说明 | [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md) |
| 第四阶段文档同步提醒接入说明 | [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md) |
| 任务状态模板 | [docs/plans/task-status-template.md](task-status-template.md) |

## 使用建议

- 如果要理解当前最优先事项，先读 [docs/plans/current-sprint.md](current-sprint.md)。
- 如果要挑后续任务，读 [docs/plans/backlog.md](backlog.md)。
- 如果要判断当前文档体系哪些已稳定、哪些仍属预案，读 [docs/plans/documentation-closure-status.md](documentation-closure-status.md)。
- 如果要修复已知前后端接口差异，读 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md)。
- 如果要总览自动化接入全貌，读 [docs/plans/automation-delivery-map.md](automation-delivery-map.md)。
- 如果要判断某阶段能否接入或升级阻断，读 [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)。
- 如果要开始补文档校验、链接检查、workflow 路径护栏或同步提醒，读 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)。
- 如果要把第一阶段文档结构类检查接进 CI，读 [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)。
- 如果要把历史事实误用扫描接进提醒链路，读 [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)。
- 如果要把 workflow 路径护栏接进正式阻断，读 [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)。
- 如果要把 API、响应码、SQL 和发布材料提醒接进 CI，读 [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)。
- 如果任务跨多个模块、文档或阶段，使用 [docs/plans/task-status-template.md](task-status-template.md) 记录过程。
- 如果计划项涉及真实代码结构，先核对 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 如果任务涉及 API 摘要、SpringDoc、前端接口客户端或已知接口漂移，同时联读 [docs/reference/README.md](../reference/README.md)。

## 维护规则

- 迭代目标变化时，优先更新 [docs/plans/current-sprint.md](current-sprint.md)。
- 新增后续事项时，优先更新 [docs/plans/backlog.md](backlog.md)。
- 删除计划文档后，必须同步清理 [docs/README.md](../README.md) 和相关索引。
