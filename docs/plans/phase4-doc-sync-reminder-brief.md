---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第四阶段文档同步提醒接入说明，定义 API、响应码、SQL 与发布材料提醒的触发范围、提示方式与验收口径。
---

# 第四阶段文档同步提醒接入说明

## 目标

本文档用于说明 HarnessBase 第四阶段自动化检查，也就是跨文档同步提醒，后续应如何接入脚本或 CI。

## 适用范围

第四阶段覆盖以下检查项：

1. A06：API 文档同步提醒
2. A07：响应码与异常文档同步提醒
3. A08：SQL 与发布材料同步提醒

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 为什么放在第四阶段

这类检查和前三阶段不同：

- 它们依赖“变更路径 -> 应提醒哪些文档”的关系
- 它们不一定能自动判断文档改得够不够
- 它们更适合作为提醒，而不是第一时间阻断

因此更适合在结构类与路径类护栏稳定后，再补进去形成闭环。

## 推荐接入位置

后续真正落地时，优先接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

接入方式建议：

- 作为独立的提醒步骤
- 可以在主构建前或后执行
- 初期不阻断流水线

## 推荐触发范围

### A06：API 文档同步提醒

建议触发：

- `server/**/controller/**/*.java`
- `web/src/api/**/*.ts`

建议提醒文档：

- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/reference/README.md](../reference/README.md)

### A07：响应码与异常文档同步提醒

建议触发：

- `**/GlobalExceptionHandler.java`
- `**/SaTokenExceptionHandler.java`
- `**/R.java`
- `**/TableDataInfo.java`
- `server/**/i18n/**/*.properties`

建议提醒文档：

- [docs/reference/error-codes.md](../reference/error-codes.md)

### A08：SQL 与发布材料同步提醒

建议触发：

- `server/script/sql/**`

建议提醒文档：

- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
- [deploy/release/README.md](../../deploy/release/README.md)

## 推荐输出方式

输出建议统一遵守：

- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)

最小输出要求：

- 明确检查编号，例如 `A06`
- 明确结果级别为 `提醒`
- 明确触发文件
- 明确应该联读或同步核对的文档
- 明确如果不一致该怎么处理

## 推荐结果沉淀方式

这类提醒更适合配合人工验证闭环，建议：

- 使用 [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) 记录阶段性效果
- 实际功能、缺陷或发布任务完成后，再用 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 记录最终验证结果

## 推荐验收标准

第四阶段接入完成后，至少应满足：

1. API 相关变更会提醒核对 API 摘要与 reference 文档
2. 异常、响应码相关变更会提醒核对错误码文档
3. SQL 相关变更会提醒核对数据脚本清单与发布材料
4. 提醒中必须带具体文档路径
5. 初期以提醒为主，不要求阻断

## 推荐试运行步骤

建议按以下顺序推进：

1. 先用变更路径规则本地模拟触发
2. 再在 CI 中跑 1 到 2 轮提醒模式
3. 观察提醒是否足够具体、是否存在明显漏提
4. 再决定是否对部分高风险场景升级为更严格策略

## 与当前文档的关系

- 自动化方向：见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
- 实施顺序：见 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- 检查定义：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- 报错口径：见 [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- 结果模板：见 [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md)

## 一句话结论

第四阶段最合理的接法，是把 API、响应码、SQL 与发布材料的关联关系先做成“带具体文档路径的提醒”，先让同步动作不再依赖人工记忆。
