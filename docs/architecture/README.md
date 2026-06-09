---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 架构文档目录入口，汇总代码地图、技术基线、微服务边界、业务扩展基线、数据流与 Harness 护栏。
---

# 架构文档总览

## 目标

本目录沉淀 HarnessBase 的真实代码地图、技术基线、模块边界、业务扩展基线、数据流与 Harness Engineering 护栏。架构文档应围绕当前若依微服务工程展开，并服务于开发、评审、发布和治理主路径。

## 推荐阅读顺序

1. [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)
2. [docs/architecture/code-map.md](code-map.md)
3. [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)
4. [docs/architecture/overview.md](overview.md)
5. [docs/architecture/boundaries.md](boundaries.md)
6. [docs/architecture/business-extension-baseline.md](business-extension-baseline.md)
7. [docs/architecture/data-flow.md](data-flow.md)

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 当前代码地图 | [docs/architecture/code-map.md](code-map.md) |
| 技术基线 | [docs/architecture/target-technology-baseline.md](target-technology-baseline.md) |
| 系统架构总览 | [docs/architecture/overview.md](overview.md) |
| 模块边界与依赖约束 | [docs/architecture/boundaries.md](boundaries.md) |
| 业务扩展基线 | [docs/architecture/business-extension-baseline.md](business-extension-baseline.md) |
| 仓库影响图模板 | [docs/architecture/business-extension-baseline.md#仓库影响图](business-extension-baseline.md#仓库影响图) |
| 数据流与关键链路 | [docs/architecture/data-flow.md](data-flow.md) |
| Harness Engineering 落地说明 | [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md) |

## 场景导航

| 场景 | 优先阅读 |
| --- | --- |
| 后端开发前确认落位 | [docs/architecture/code-map.md](code-map.md)、[docs/architecture/boundaries.md](boundaries.md)、[server/README.md](../../server/README.md) |
| 前端开发前确认落位 | [docs/architecture/code-map.md](code-map.md)、[docs/architecture/business-extension-baseline.md](business-extension-baseline.md)、[web/README.md](../../web/README.md) |
| 新增业务功能前确认范围 | [docs/architecture/business-extension-baseline.md#仓库影响图](business-extension-baseline.md#仓库影响图)、[docs/architecture/boundaries.md](boundaries.md)、[docs/design/README.md](../design/README.md) |
| 核对 API、响应码或 SQL 事实 | [docs/architecture/data-flow.md](data-flow.md)、[docs/reference/README.md](../reference/README.md) |
| 核对发布路径、workflow 或观测支撑 | [docs/architecture/code-map.md](code-map.md)、[.github/README.md](../../.github/README.md)、[deploy/release/README.md](../../deploy/release/README.md)、[deploy/observability/README.md](../../deploy/observability/README.md) |

## 维护原则

- 架构结论必须能回到 [docs/architecture/code-map.md](code-map.md) 或真实代码验证。
- 新增业务域或完整业务功能时，必须同步核对 [docs/architecture/business-extension-baseline.md](business-extension-baseline.md)。
- 新增服务、删除服务、移动目录、调整 workflow 或发布入口时，优先更新代码地图和本索引。
- 如果发现文档入口与真实结构不一致，应优先修正文档入口，再继续扩写内容。
