---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第四阶段跨文档同步提醒接入说明，定义 API、错误码、SQL 与发布材料提醒的触发范围、提示方式和验收口径。
---

# 第四阶段跨文档同步提醒接入说明

## 目标

本文档用于说明第四阶段自动化检查，也就是跨文档同步提醒，后续如何接入脚本或 CI。

## 适用范围

第四阶段覆盖以下检查项：

1. `A06`：API 文档同步提醒
2. `A07`：错误码与异常文档同步提醒
3. `A08`：SQL 与发布材料同步提醒

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 为什么放在第四阶段

这类检查与前几阶段不同：

- 它依赖“代码变化 -> 应提醒哪份文档”的映射关系
- 它不一定能自动判断文档是否已经改够
- 更适合作为提醒，而不是一开始就阻断

## 推荐接入位置

优先接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

接入建议：

- 作为独立提醒步骤
- 可放在主构建前或主构建后执行
- 初期不阻断流水线

## 推荐触发范围

### A06：API 文档同步提醒

建议触发：

- `server/**/controller/**/*.java`
- `web/src/api/**/*.js`

建议提醒文档：

- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/reference/README.md](../reference/README.md)

### A07：错误码与异常文档同步提醒

建议触发：

- `**/GlobalExceptionHandler.java`
- `**/R.java`
- `**/TableDataInfo.java`
- `server/**/i18n/**/*.properties`

建议提醒文档：

- [docs/reference/error-codes.md](../reference/error-codes.md)

### A08：SQL 与发布材料同步提醒

建议触发：

- `server/sql/**`

建议提醒文档：

- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [deploy/release/README.md](../../deploy/release/README.md)

## 推荐输出方式

输出建议统一遵守：

- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)

最小输出要求：

- 明确检查编号，例如 `A06`
- 明确结果级别为“提醒”
- 明确触发文件
- 明确应同步核对的文档

## 推荐结果沉淀方式

建议搭配：

- [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

前者记录自动化提醒效果，后者记录具体任务最终验证结果。

## 推荐验收标准

接入完成后，至少应满足：

1. API 相关变更会提醒核对 API 参考文档
2. 错误码、异常和 i18n 相关变更会提醒核对错误码文档
3. SQL 相关变更会提醒核对 SQL 清单和发布材料
4. 提醒内容带具体文档路径
5. 初期以提醒为主，不直接阻断
