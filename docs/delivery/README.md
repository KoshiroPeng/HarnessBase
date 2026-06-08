---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 交付文档

本目录按 Harness Engineering 的对象模型组织交付文档：先定义 `Service`、`Environment`、`Infrastructure`、`Artifact` 和 `Pipeline`，再说明发布、回滚、验证和治理规则。

## 核心入口

| 对象或任务 | 文档 |
| --- | --- |
| 交付总入口 | [delivery-operations-map.md](delivery-operations-map.md) |
| 对象模型 | [delivery-model.md](delivery-model.md) |
| 环境与基础设施 | [environments.md](environments.md)、[github-environments.md](github-environments.md) |
| 流水线 | [pipelines.md](pipelines.md) |
| 制品 | [artifact-policy.md](artifact-policy.md) |
| 部署策略 | [deployment-strategies.md](deployment-strategies.md) |
| 特性开关 | [feature-flags.md](feature-flags.md) |

## 维护规则

- 本目录只维护交付对象和交付流程，不重复编码规范、评审清单或运行手册。
- 新增可部署单元、环境、制品类型或流水线阶段时，必须同步更新对应对象文档。
