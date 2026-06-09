---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第四阶段跨文档同步提醒接入说明，定义 API、错误码、SQL 与发布材料提醒的触发范围、提示方式和验收口径。
---

# 第四阶段跨文档同步提醒接入说明

## 目标

本文档用于说明第四阶段自动化检查，也就是跨文档同步提醒，当前如何接入脚本和 CI、如何解释提醒输出、后续如何维护触发范围。

## 适用范围

第四阶段覆盖以下检查项：

1. `A06`：API 文档同步提醒
2. `A07`：错误码与异常文档同步提醒
3. `A08`：SQL 与发布材料同步提醒

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 当前状态

截至 2026-06-09，第四阶段已经接入当前文档护栏脚本：

- A06、A07、A08 已由 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 覆盖。
- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 已在后端和前端构建前执行该脚本。
- 当前为提醒模式；命中项会输出触发文件和应核对文档，但不会作为阻断退出码。
- 本地执行 `python .github/scripts/doc_guardrails.py` 应输出 A01/A02/A03/A04/A05/A06/A07/A08 通过。
- 当前通过本次变更文件触发提醒，不做全仓噪音扫描。

## 为什么放在第四阶段

这类检查与前几阶段不同：

- 它依赖“代码变化 -> 应提醒哪份文档”的映射关系
- 它不一定能自动判断文档是否已经改够
- 更适合作为提醒，而不是一开始就阻断

## 接入位置

当前已接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

接入方式：

- 复用 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 基于本次变更文件触发提醒
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

## 推荐试运行命令

模拟 API、错误码和 SQL 三类变更：

```bash
DOC_GUARDRAILS_CHANGED_FILES=$'server/ruoyi-modules/ruoyi-system/src/main/java/com/ruoyi/system/controller/SysUserController.java\nweb/src/api/system/user.js\nserver/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/domain/R.java\nserver/sql/ry_20260321.sql' python .github/scripts/doc_guardrails.py
```

## 推荐验收标准

第四阶段当前已满足：

1. API 相关变更会提醒核对 API 参考文档
2. 错误码、异常和 i18n 相关变更会提醒核对错误码文档
3. SQL 相关变更会提醒核对 SQL 清单和发布材料
4. 提醒内容带具体文档路径
5. 初期以提醒为主，不直接阻断

## 一句话结论

第四阶段已经作为非阻断同步提醒接入当前文档护栏脚本，维护重点是让 API、错误码、SQL 和发布材料的联动提醒覆盖真实高风险变更，同时避免全仓扫描噪音。
