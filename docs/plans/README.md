---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 计划文档目录入口，保留后续待办、专项任务说明和任务状态模板。
---

# 计划文档

## 目标

本目录只保留“还会被后续任务继续使用”的计划材料，避免在业务代码尚未展开前沉淀过多过程档案。

已完成的文档收敛、自动化接入、阶段验收和试运行记录不再长期保存在本目录；自动化规则统一进入 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)，验证结果统一进入 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 或对应 PR / CI 记录。

## 当前保留文档

| 主题 | 文档 |
| --- | --- |
| 后续待办 | [docs/plans/backlog.md](backlog.md) |
| 前后端接口差异修复任务说明 | [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) |
| 任务状态模板 | [docs/plans/task-status-template.md](task-status-template.md) |

## 使用方式

- 如果要挑后续任务，读 [docs/plans/backlog.md](backlog.md)。
- 如果要修复已知前后端接口差异，读 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md)。
- 如果任务跨多个模块、文档或阶段，使用 [docs/plans/task-status-template.md](task-status-template.md) 记录过程。
- 如果计划项涉及真实代码结构，先核对 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 如果任务涉及 API 摘要、SpringDoc、前端接口客户端或已知接口漂移，同时联读 [docs/reference/README.md](../reference/README.md)。
- 如果任务涉及自动化检查，直接读 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)、[docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md) 和 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)。

## 维护规则

- 新增后续事项时，优先更新 [docs/plans/backlog.md](backlog.md)。
- 新增计划文档前，先判断是否可以合并到本目录现有三类材料。
- 已完成的一次性过程记录优先沉淀到 PR、issue、验证证据或提交历史，不在本目录长期保留。
- 删除计划文档后，必须同步清理 [docs/README.md](../README.md) 和相关索引。
