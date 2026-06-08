---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 任务启动清单

## 目标

本文档用于给 AI 协作者和开发者提供一份“开始做事前先读什么、动手后要补什么、结束前怎么自检”的最小启动路径。

如果你不确定该从哪份文档开始，优先从本文档进入。

## 通用起步顺序

无论当前任务是什么，建议先完成下面 4 步：

1. 阅读 [AGENTS.md](../../AGENTS.md)
2. 阅读 [docs/README.md](../README.md)
3. 阅读 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)
4. 根据任务类型跳到下方对应清单

## 开发后端代码

开始前建议依次阅读：

1. [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)
2. [docs/architecture/README.md](../architecture/README.md)
3. [docs/conventions/README.md](README.md)
4. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
5. [docs/conventions/testing.md](testing.md)

动手时重点确认：

- 当前改动是否直接服务 Web MVP 主线
- 是否破坏分层依赖方向
- 是否涉及 API、错误码、Flyway migration 或发布影响

结束前至少自检：

1. [docs/conventions/README.md](README.md)
2. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
3. [docs/conventions/testing.md](testing.md)
4. [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
5. [docs/plans/task-status-template.md](../plans/task-status-template.md)

## 做需求评审

开始前建议依次阅读：

1. [docs/reviews/requirement-review-checklist.md](../reviews/requirement-review-checklist.md)
2. [docs/design/README.md](../design/README.md)
3. [docs/plans/README.md](../plans/README.md)
4. [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)

输出结果时建议配合：

- [docs/reviews/templates/requirement-review-template.md](../reviews/templates/requirement-review-template.md)
- [docs/plans/task-status-template.md](../plans/task-status-template.md)

## 做后端设计评审

开始前建议依次阅读：

1. [docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md)
2. [docs/architecture/README.md](../architecture/README.md)
3. [docs/reference/README.md](../reference/README.md)
4. [docs/conventions/error-handling.md](error-handling.md)

输出结果时建议配合：

- [docs/reviews/templates/backend-design-review-template.md](../reviews/templates/backend-design-review-template.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
- [docs/plans/task-status-template.md](../plans/task-status-template.md)

## 做代码评审或开发后自检

开始前建议依次阅读：

1. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
2. [docs/conventions/naming.md](naming.md)
3. [docs/conventions/error-handling.md](error-handling.md)
4. [docs/conventions/logging.md](logging.md)
5. [docs/conventions/testing.md](testing.md)

输出结果时建议配合：

- [docs/reviews/templates/backend-code-review-template.md](../reviews/templates/backend-code-review-template.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
- [docs/plans/task-status-template.md](../plans/task-status-template.md)

## 做测试设计、补测试或测试用例评审

开始前建议依次阅读：

1. [docs/conventions/testing.md](testing.md)
2. [docs/reviews/testcase-review-checklist.md](../reviews/testcase-review-checklist.md)
3. [docs/reference/error-codes.md](../reference/error-codes.md)
4. [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)

输出结果时建议配合：

- [docs/reviews/templates/testcase-review-template.md](../reviews/templates/testcase-review-template.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
- [docs/plans/task-status-template.md](../plans/task-status-template.md)

## 做发布、回滚或上线验证

开始前建议依次阅读：

1. [deploy/release/README.md](../../deploy/release/README.md)
2. [deploy/release/environment-variable-template.md](../../deploy/release/environment-variable-template.md)
3. [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
4. [deploy/observability/README.md](../../deploy/observability/README.md)

执行前重点确认：

- 本次变更是否仍服务当前 Web MVP 主线
- API、错误码、环境变量、迁移和回滚路径是否已同步
- 发布验证是否能覆盖本次真实影响范围

执行结果建议配合：

- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
- [docs/plans/task-status-template.md](../plans/task-status-template.md)

## 前端相关任务

- 当前仓库尚未正式启用 `web/` 前端应用。
- 若当前任务已经进入前端设计阶段，先阅读 [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)、[docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md) 和 [docs/reviews/templates/frontend-design-review-template.md](../reviews/templates/frontend-design-review-template.md)。
- 若当前任务已经进入前端代码评审或前端自检阶段，再补充阅读 [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md) 和 [docs/reviews/templates/frontend-code-review-template.md](../reviews/templates/frontend-code-review-template.md)。
- 若后续正式启用 `web/`，应再补齐前端编码规范与前端测试规范。

## 一句话准则

- 如果任务属于产品功能开发，优先看设计、计划、参考和代码评审材料。
- 如果任务属于工程护栏补强，优先看规范、架构和评审材料。
- 如果任务属于发布与运行支撑，优先看 `deploy/` 下的材料。
