---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第一阶段文档护栏试运行验证，记录 A01/A02/A03 在本地与 CI 接入条件下的试运行结论。
---

# 自动化试运行验证

## 基本信息

- 阶段：第一阶段
- 检查编号：A01 / A02 / A03
- 试运行时间：2026-06-09
- 执行环境：本地
- 执行人：Codex
- 关联脚本 / workflow：[.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)、[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

## 试运行目标

- 本次要验证什么：
  - 文档护栏脚本能否稳定发现治理型 Markdown 缺失标头的问题
  - 文档护栏脚本能否稳定发现相对链接目标和 Markdown 锚点缺失的问题
  - 豁免规则是否不会误伤根目录 `README.md`、上游模板和占位 Markdown
- 本次不验证什么：
  - 第二阶段历史事实误用扫描
  - 第三阶段 workflow 路径护栏
  - 第四阶段 API / SQL / 错误码文档同步提醒

## 试运行结果

| 序号 | 验证项 | 结果 | 说明 |
| --- | --- | --- | --- |
| 1 | 本地直接执行脚本 | 通过 | `python .github/scripts/doc_guardrails.py` 可直接运行，无额外依赖 |
| 2 | A01 标头检查 | 通过 | 现有治理型 Markdown 全部通过，豁免范围生效 |
| 3 | A02 相对链接检查 | 通过 | 仓库内 Markdown 相对链接均能解析 |
| 4 | A02 锚点检查 | 通过 | 已使用 Markdown 标题 slug 规则校验页内与跨页锚点 |
| 5 | A03 失效引用检查 | 通过 | 失效文件引用已并入 A02 的目标存在性检查 |
| 6 | 接入 CI 的阻断条件 | 通过 | 脚本退出码符合“有问题阻断、无问题放行”的接入要求 |

## 命中情况

- 命中总数：0
- 明显真阳性：0
- 可能误报：0
- 可能漏报：当前未覆盖第 2、3、4 阶段规则

## 代表性样例

```text
[A01/A02/A03][通过] 文档护栏检查通过
说明: 治理型 Markdown 标头、相对链接和锚点检查均未发现问题
```

## 阶段验收结论

- 是否通过阶段验收：通过
- 当前建议状态：可接入 CI
- 对应验收清单：[docs/plans/automation-phase-acceptance-checklist.md](../../docs/plans/automation-phase-acceptance-checklist.md)

## 后续动作

- 将该脚本前置接入 [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)。
- 在真实 CI 运行后补充一轮流水线侧验证结果。
