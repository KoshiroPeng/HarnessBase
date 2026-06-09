---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化接入总导航页，汇总方向、检查定义、输出规范、阶段接入说明与验收材料。
---

# 自动化接入总导航页

## 目标

本文档用于把 HarnessBase 当前已经补齐的自动化相关文档集中到一个入口，方便继续落地自动化检查时，能够快速找到：

- 规则来源
- 检查定义
- 输出规范
- 阶段接入说明
- 验收与记录模板

## 推荐阅读顺序

1. [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
2. [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
3. [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
4. [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
5. [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md)
6. [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)

## 文档索引

| 类别 | 文档 |
| --- | --- |
| 自动化方向 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) |
| 自动化实施顺序 | [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) |
| 检查定义 | [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) |
| 报错文案规范 | [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md) |
| 自动化检查结果模板 | [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) |
| 自动化试运行验证模板 | [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md) |
| 阶段验收清单 | [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md) |
| 第一阶段检查结果 | [docs/reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md) |
| 第一阶段试运行验证 | [docs/reviews/automation-pilot-verification-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-pilot-verification-phase1-doc-guardrails-2026-06-09.md) |

## 分阶段入口

| 阶段 | 入口 |
| --- | --- |
| 第一阶段：文档结构类硬校验（已接入） | [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md) |
| 第二阶段：历史事实误用扫描 | [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md) |
| 第三阶段：workflow 路径护栏 | [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md) |
| 第四阶段：文档同步提醒 | [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md) |

## 当前落地状态

- 第一阶段 `A01 / A02 / A03` 已通过 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 接入 [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)。
- 第一阶段执行结果与试运行验证已沉淀到：
  - [docs/reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md)
  - [docs/reviews/automation-pilot-verification-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-pilot-verification-phase1-doc-guardrails-2026-06-09.md)
- 第二、三、四阶段当前仍属于待接入预案，尚未进入主线 CI。

## 我现在要做什么

| 我现在要做什么 | 先看哪里 |
| --- | --- |
| 想知道自动化总体方向 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) |
| 想知道按什么顺序推进 | [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) |
| 想知道某个检查项到底怎么定义 | [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) |
| 想统一 CI / 脚本文案输出 | [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md) |
| 想记录自动化检查执行结果 | [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) |
| 想做阶段验收 | [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md) |
| 想记录试运行验证证据 | [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md) |
| 想查看第一阶段已落地结果 | [docs/reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md) |

## 维护规则

- 新增自动化相关文档后，若会影响接入、验收或输出口径，必须同步更新本文档。
- 若某阶段被合并、删除或调整阻断级别，必须同步更新本文档和 [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)。

## 一句话结论

后续推进 HarnessBase 自动化时，优先从本文档进入，而不是在多个目录里手工拼接阅读路径。
