---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 架构文档目录入口，汇总目标基线、结构融合、边界、数据流与 Harness 纠偏文档。
---

# 架构文档总览

## 目标

本目录沉淀 ProjectPilot 的目标技术基线、模块边界、数据流、参考架构融合说明与 Harness Engineering 纠偏文档，帮助开发、设计、评审与测试在开始工作前快速建立共同上下文。

当前阶段的架构主线服务于 Web 产品 MVP 交付，并围绕 `JDK 17 + Spring Boot 3.x + Vue 3` 建立新的目标基线。

## 推荐阅读顺序

1. [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)
2. [docs/architecture/callcenter-reference-adaptation.md](callcenter-reference-adaptation.md)
3. [docs/architecture/overview.md](overview.md)
4. [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)
5. [docs/architecture/boundaries.md](boundaries.md)
6. [docs/architecture/data-flow.md](data-flow.md)

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 目标技术基线 | [docs/architecture/target-technology-baseline.md](target-technology-baseline.md) |
| CallCenter 参考架构融合说明 | [docs/architecture/callcenter-reference-adaptation.md](callcenter-reference-adaptation.md) |
| 系统架构总览 | [docs/architecture/overview.md](overview.md) |
| Harness Engineering 纠偏说明 | [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md) |
| Harness Engineering 参考手册 | [docs/architecture/harness-engineering-reference.md](harness-engineering-reference.md) |
| 模块边界与依赖约束 | [docs/architecture/boundaries.md](boundaries.md) |
| 数据流与关键链路 | [docs/architecture/data-flow.md](data-flow.md) |

## 使用建议

- 如果你要开始开发代码，先读 [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)、[docs/architecture/overview.md](overview.md) 和 [docs/architecture/boundaries.md](boundaries.md)。
- 如果你要判断某项方案是否还在沿用旧基线或旧脚手架心智，先读 [docs/architecture/callcenter-reference-adaptation.md](callcenter-reference-adaptation.md)。
- 如果你要判断某项方案是否又偏回“平台化主线”，先读 [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)。
- 如果你要梳理接口、数据落库、状态流转或关键调用链，先读 [docs/architecture/data-flow.md](data-flow.md)。
- 如果任务还需要结合规范、计划或评审材料，回到 [docs/README.md](../README.md) 按场景继续跳转。

## 维护规则

- 新增架构级文档时，必须同步更新本文档。
- 若某份架构文档已经失效或被替代，应先在本文档中调整推荐入口，再处理正文收敛。
