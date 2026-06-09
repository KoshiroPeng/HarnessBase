---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 文档收口状态说明，明确当前哪些文档已稳定成基线、哪些按任务增量维护、哪些仍属自动化接入预案。
---

# 文档收口状态说明

## 目标

本文档用于给当前这轮大规模文档治理做一个明确的收口结论，帮助后续协作者快速判断：

- 哪些文档已经稳定，可作为长期基线入口
- 哪些文档只应在真实开发任务触发时增量维护
- 哪些文档仍然属于自动化接入预案，还没有变成实际执行结果
- 哪些自动化文档已经开始从预案转为已落地阶段结果

## 当前结论

以 2026-06-09 当前状态看，HarnessBase 的仓库级文档已经从“历史叙事混杂、入口分散、导航不稳”收敛到“入口明确、事实一致、第一阶段自动化已落地、后续阶段预案成体系”的状态。

因此后续不应再继续无目的扩写规则文档，而应以“增量维护”和“真实任务触发”为主。

## 一类：已稳定为基线入口的文档

以下文档当前可视为稳定基线，后续只在真实结构、规则或导航发生变化时更新：

- [AGENTS.md](../../AGENTS.md)
- [README.md](../../README.md)
- [docs/README.md](../README.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/overview.md](../architecture/overview.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [docs/architecture/boundaries.md](../architecture/boundaries.md)
- [docs/design/README.md](../design/README.md)
- [docs/reviews/README.md](../reviews/README.md)
- [docs/conventions/README.md](../conventions/README.md)
- [.github/README.md](../../.github/README.md)
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)
- [deploy/release/README.md](../../deploy/release/README.md)
- [deploy/observability/README.md](../../deploy/observability/README.md)

这些文档的共同特点：

- 它们承担主入口、索引页或真实事实锚点职责
- 它们已经与当前仓库结构和技术基线对齐
- 它们不应该频繁因为抽象想法而改动

## 二类：按真实开发任务增量维护的文档

以下文档已经具备稳定结构，但内容应按真实开发或修复任务触发时增量维护：

- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/reference/error-codes.md](../reference/error-codes.md)
- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [docs/reference/README.md](../reference/README.md)
- [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- [docs/design/feature-auth.md](../design/feature-auth.md)
- [docs/plans/backlog.md](backlog.md)
- [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md)

这些文档的共同特点：

- 结构已经稳定
- 但内容和真实代码、接口、SQL、异常模型强相关
- 不应为了“文档完整感”主动扩写超出当前代码事实的内容

## 三类：自动化接入预案文档

以下文档当前已经完整，但仍属于“接入说明、规则预案、验收材料”，不是已完成落地的事实声明：

- [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
- [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)
- [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)
- [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)
- [docs/plans/automation-delivery-map.md](automation-delivery-map.md)
- [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)
- [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md)
- [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md)

对这些文档必须坚持一个原则：

- 对仍未接入的阶段，在没有真实接入脚本、真实 CI 变更、真实试运行结果之前，不要把它们写成“已经落地完成”的事实。

## 四类：已开始落地的自动化阶段结果

以下文档已经不再只是预案，而是第一阶段真实接入后的结果材料：

- [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)
- [docs/reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-check-report-phase1-doc-guardrails-2026-06-09.md)
- [docs/reviews/automation-pilot-verification-phase1-doc-guardrails-2026-06-09.md](../reviews/automation-pilot-verification-phase1-doc-guardrails-2026-06-09.md)
- [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

这些材料的共同特点：

- 已有真实脚本实现
- 已有真实 CI 接入位置
- 已有本地试运行结果和阶段记录
- 后续应按真实运行结果继续维护，而不是退回纯概念预案
## 五类：本轮已完成但后续不应继续扩张的治理成果

以下事项本轮已完成，可以视为阶段性收口结果：

- 文档主线与当前 RuoYi-Vue-Plus 代码事实对齐
- 主入口、目录入口、规范入口、计划入口、评审入口和 workflow 入口闭环
- Harness Engineering 在本仓库中的定位收敛为代码地图、规则护栏、验证证据和自动化接入预案
- 自动化相关文档形成从方向到验收的完整链路
- 第一阶段文档护栏已经从预案推进到真实接入

后续不建议继续做的事情：

- 为了“更完整”再新增更多同类型导航页
- 继续重复写同一批自动化规则
- 在没有真实工程动作触发的情况下不断扩写子阶段说明

## 后续维护原则

从现在开始，文档维护应优先遵守：

1. 主入口只做必要收口，不做概念扩张。
2. 事实型文档跟着真实代码和配置变更更新。
3. 预案型文档跟着真实接入动作更新，不提前写成完成态。
4. 新增文档前先判断现有入口是否已经足够，不足时才新增。

## 推荐下一步

如果后续仍然只处理文档，最合适的动作不是继续扩写，而是：

- 做一次周期性链接与标头校验
- 在真实代码任务发生时按需更新 reference、design、backlog
- 等真正开始接自动化脚本或 CI 时，再回到自动化接入预案文档补“已落地结果”

如果后续允许进入工程实现，最优先的不是继续写文档，而是：

- 落第一阶段文档结构类检查
- 修前后端接口漂移问题
- 再用现有模板回填试运行和验收记录

## 一句话结论

当前文档体系已经达到“可作为稳定仓库基线继续使用”的状态；后续应从“持续扩写文档”切换到“围绕真实任务做增量维护”。
