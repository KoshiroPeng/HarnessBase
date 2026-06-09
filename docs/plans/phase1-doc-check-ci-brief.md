---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第一阶段文档结构类检查 CI 接入说明，记录元数据与链接检查的接入状态、位置、输出与验收方式。
---

# 第一阶段文档结构类检查 CI 接入说明

## 目标

本文档用于说明 HarnessBase 第一阶段自动化检查，也就是文档结构类硬校验，当前如何接入 CI、如何本地验证、后续如何维护。

本说明只描述：

- 接什么检查
- 接到哪里
- 输出成什么样
- 如何验收

本说明不替代具体脚本实现；当前脚本入口是 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)，CI 入口是 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)。

## 当前状态

截至 2026-06-09，第一阶段已经落地：

- A01、A02、A03 已由 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 覆盖。
- A03 已删除文档引用检查并入 A02 相对链接目标检查。
- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 已将文档护栏作为后端和前端构建前置门禁。
- 本阶段验收关注 A01/A02/A03；当前同一脚本还会一并执行 A05 workflow 路径检查。

## 适用范围

第一阶段只覆盖以下检查项：

1. A01：治理型 Markdown 元数据标头检查
2. A02：Markdown 相对链接与锚点检查
3. A03：已删除文档引用检查

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 为什么先接这一阶段

因为这三类问题具备共同特征：

- 规则明确
- 误报低
- 易于脚本化
- 失败后可以直接阻断，而不需要复杂人工判断

这意味着它们最适合作为 HarnessBase 自动化检查的第一批落地点。

## 接入位置

当前已接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

原因：

- 它已经承担主线 CI / 护栏校验职责。
- 文档变更本身就会触发当前 workflow。
- 文档检查与后端构建、前端构建属于同一类“进入主线前的基础门禁”。

## 接入方式

当前 workflow 结构按以下顺序组织：

1. 检出代码
2. 执行文档结构类检查
3. 执行后端构建
4. 执行前端构建
5. 上传检查结果与构建制品

如果文档检查失败：

- 允许后端、前端构建是否继续执行，可以根据资源策略决定
- 但整个 workflow 结果应为失败

若希望最小化资源浪费，推荐：

- 文档检查先跑
- 文档检查失败后直接终止后续构建

## 推荐输出方式

脚本与 CI 输出建议统一遵守：

- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md)

最小输出要求：

- 明确检查编号，例如 `A01`
- 明确阻断级别，例如 `阻断`
- 明确命中文件
- 明确具体缺失字段、缺失路径或缺失锚点
- 明确规则来源文档

## 推荐结果沉淀方式

规则调整或误报治理时，建议同步输出一份人工可读结果，便于回顾：

- 使用 [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) 记录试运行结果
- 若本次接入涉及规则调整或忽略项变更，补充 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 推荐扫描范围

以当前文档规则为准，第一阶段建议优先覆盖：

- `AGENTS.md`
- 根目录 [README.md](../../README.md)
- `docs/**/*.md`
- `deploy/**/*.md`
- [.github/README.md](../../.github/README.md)
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)

豁免与忽略规则以 [docs/conventions/document-metadata.md](../conventions/document-metadata.md) 和 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 推荐验收标准

第一阶段接入完成后，至少应满足：

1. 能发现缺失元数据字段的治理型 Markdown 文档
2. 能发现相对链接目标不存在的问题
3. 能发现 Markdown 锚点不存在的问题
4. 不把根目录 `README.md` 误判为必须带标头
5. 不把 `.gitee/` 模板和资源目录 `package-info.md` 误判为治理型 Markdown
6. CI 输出可直接让开发者定位问题，而不是只显示模糊失败

## 推荐试运行步骤

后续维护建议按以下顺序推进：

1. 先在本地执行 `python .github/scripts/doc_guardrails.py`
2. 收集误报与漏报
3. 修正忽略规则与输出文案
4. 继续保持 CI 阻断模式

## 与当前文档的关系

- 自动化方向：见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
- 实施顺序：见 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- 检查定义：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- 报错口径：见 [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- workflow 入口：见 [.github/README.md](../../.github/README.md)

## 不在本文处理

以下事项不在本文处理：

- workflow YAML 实际改动
- 第二阶段历史事实误用扫描
- 第三阶段 workflow 路径护栏
- 第四阶段 API / SQL / 响应码同步提醒

## 一句话结论

第一阶段已经作为 `agent-guardrails.yml` 中最前置的阻断门禁落地，维护重点是保持输出能直接定位文件、字段、路径和规则来源。
