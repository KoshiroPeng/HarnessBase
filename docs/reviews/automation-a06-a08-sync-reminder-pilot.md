---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase A06-A08 跨文档同步提醒本地试运行记录，说明 API、错误码、SQL 与发布材料提醒的触发范围、命中情况和阶段验收结论。
---

# A06-A08 跨文档同步提醒试运行记录

## 基本信息

- 阶段：第四阶段跨文档同步提醒
- 检查编号：A06、A07、A08
- 试运行时间：2026-06-09
- 执行环境：本地
- 执行人：Codex
- 关联脚本 / workflow：[.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)、[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

## 试运行目标

- 验证后端 Controller 或前端 API 客户端变更会触发 A06。
- 验证错误响应、异常或 i18n 相关变更会触发 A07。
- 验证 SQL 脚本变更会触发 A08。
- 验证 A06-A08 当前为提醒模式，不因提醒项阻断主线。

## 试运行结果

| 序号 | 验证项 | 结果 | 说明 |
| --- | --- | --- | --- |
| 1 | 当前仓库全量扫描 | 通过 | `python .github/scripts/doc_guardrails.py` 输出 A01/A02/A03/A04/A05/A06/A07/A08 通过 |
| 2 | API 变更模拟 | 通过 | Controller 与 `web/src/api` 文件触发 A06 提醒 |
| 3 | 错误码与异常变更模拟 | 通过 | `R.java` 触发 A07 提醒 |
| 4 | SQL 变更模拟 | 通过 | `server/sql` 文件触发 A08 提醒 |

## 命中情况

- 当前正式文件命中总数：0
- 模拟样例命中总数：4
- 明显真阳性：Controller、`web/src/api`、`R.java`、`server/sql` 触发文件
- 可能误报：当前未发现
- 可能漏报：复杂业务语义变化仍需人工评审判断是否需要同步更多文档

## 代表性输出

```text
[A06][提醒] API 文档同步提醒
1. 文件: server/ruoyi-modules/ruoyi-system/src/main/java/com/ruoyi/system/controller/SysUserController.java
   问题: API 相关文件发生变更，需要核对 API 参考文档
2. 文件: web/src/api/system/user.js
   问题: API 相关文件发生变更，需要核对 API 参考文档

[A07][提醒] 错误码与异常文档同步提醒
1. 文件: server/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/domain/R.java
   问题: 错误码、异常或 i18n 相关文件发生变更，需要核对错误码文档

[A08][提醒] SQL 与发布材料同步提醒
1. 文件: server/sql/ry_20260321.sql
   问题: SQL 脚本发生变更，需要核对 SQL 清单和发布材料

[A01/A02/A03/A04/A05/A06/A07/A08][通过] 未发现阻断问题
说明: A04、A06、A07、A08 当前为提醒模式，命中项只提示人工复核，不阻断主线
```

## 阶段验收结论

- 是否通过阶段验收：通过
- 当前建议状态：可接入 CI，并继续以提醒模式运行
- 对应验收清单：[docs/plans/automation-phase-acceptance-checklist.md](../plans/automation-phase-acceptance-checklist.md)

## 后续动作

- 持续维护 A06-A08 触发范围，优先覆盖真实高风险同步场景。
- 若未来某类同步遗漏高频出现，再评估是否将少量高置信项升级为阻断。
