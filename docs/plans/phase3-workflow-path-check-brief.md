---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第三阶段 workflow 路径护栏接入说明，定义工作流路径存在性检查的接入位置、范围、输出与验收方式。
---

# 第三阶段 workflow 路径护栏接入说明

## 目标

本文档用于说明 HarnessBase 第三阶段自动化检查，也就是 workflow 路径存在性检查，后续应如何接入 CI。

## 适用范围

第三阶段只覆盖以下检查项：

1. A05：workflow 路径存在性检查

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 为什么单独成阶段

workflow 路径问题通常具有高风险：

- 会让 CI 直接失效
- 会让发布、回滚、初始化流程指向错误目录
- 很容易因为目录调整或历史路径回流而再次出现

但它又和第一阶段的 Markdown 检查不同，因此适合单独成阶段处理。

## 推荐接入位置

后续真正落地时，优先接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

原因：

- 它本身就是最需要被路径护栏保护的 workflow
- 它承担主线门禁职责

## 推荐扫描范围

优先扫描：

- `.github/workflows/*.yml`

优先检查字段：

- `working-directory`
- `cache-dependency-path`
- 上传制品路径
- 发布脚本路径
- 模板路径

事实来源：

- [.github/README.md](../../.github/README.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)
- [deploy/release/README.md](../../deploy/release/README.md)

## 推荐接入策略

建议：

1. 先实现路径存在性校验
2. 先只判断“路径是否存在”
3. 不在第一版里过度推断 workflow 语义

因为第一版最重要的是先拦住“明显失效路径”。

## 推荐输出方式

输出建议统一遵守：

- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)

最小输出要求：

- 明确检查编号 `A05`
- 明确结果级别 `阻断`
- 明确缺失路径值
- 明确该路径来自哪个 workflow 文件、哪个字段
- 明确规则来源

## 推荐结果沉淀方式

首次接入或路径规则调整时，建议：

- 使用 [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) 记录试运行结果
- 若涉及发布、回滚或初始化流程变更，补 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 推荐验收标准

第三阶段接入完成后，至少应满足：

1. 能发现不存在的 `working-directory`
2. 能发现不存在的缓存路径或依赖路径
3. 能发现不存在的制品路径或脚本路径
4. 输出能明确指出来源 workflow 与字段
5. 对明显失效路径采取阻断策略

## 推荐试运行步骤

建议按以下顺序推进：

1. 先本地模拟扫描 workflow 文件
2. 再在 CI 中接入试运行
3. 验证现有 workflow 全部通过
4. 再把检查升级为正式阻断

## 与当前文档的关系

- 自动化方向：见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
- 实施顺序：见 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- 检查定义：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- workflow 入口：见 [.github/README.md](../../.github/README.md)

## 一句话结论

第三阶段最合理的接法，是把 workflow 路径存在性检查作为主线 CI 的正式阻断护栏，先防止目录和脚本路径再次偏离当前仓库事实。
