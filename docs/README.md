---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 文档导航总入口

## 目标

本文档作为 CallCenter 项目的统一文档入口，按“我要做什么”组织现有文档，帮助开发、测试、评审和交付过程快速定位必须阅读的材料。

## 当前仓库状态

- `services/callcenter-server` 是当前项目完整后台，基于 Java 17 + Spring Boot 3.5 + RuoYi-Vue-Plus 裁剪版。
- `services/callcenter-web` 是当前项目前端，基于 Vue 3 + TypeScript + Vite + plus-ui 裁剪版。
- `docs/specs/` 是 CallCenter 产品范围、规模、部署约束、技术方案和工程结构事实来源。
- `deploy/compose.yml`、`deploy/compose.app.yml` 和 `deploy/ops` 已提供 CallCenter 本地 Compose 运维入口。
- `deploy/release/` 与 `.github/workflows/` 提供 SSH/systemd 发布、回滚和远端主机初始化骨架。
- `deploy/observability/` 提供本地 Prometheus、Loki、Promtail、Grafana 配置。
- 根目录 `server/` 仅作为历史工程骨架保留，不再作为当前项目主后台入口。

## CallCenter 主路径

| 我现在要做什么 | 优先阅读 |
| --- | --- |
| 理解业务范围和角色 | [docs/specs/01-产品范围与角色.md](specs/01-产品范围与角色.md) |
| 理解规模和非功能约束 | [docs/specs/02-规模与非功能要求.md](specs/02-规模与非功能要求.md) |
| 理解部署和外部系统约束 | [docs/specs/03-部署与集成约束.md](specs/03-部署与集成约束.md) |
| 理解总体技术方案 | [docs/specs/04-总体技术方案.md](specs/04-总体技术方案.md) |
| 理解工程结构 | [docs/specs/05-仓库与工程结构方案.md](specs/05-仓库与工程结构方案.md) |
| 开发后端 | [services/callcenter-server/README.md](../services/callcenter-server/README.md) |
| 开发前端 | [services/callcenter-web/README.md](../services/callcenter-web/README.md) |
| 做本地部署和健康检查 | [deploy/README.md](../deploy/README.md) |
| 做发布、回滚或环境初始化 | [交付与运维导航](#交付与运维导航) |
| 做需求、设计、代码或测试评审 | [评审清单导航](#评审清单导航) |

## 开发前必读

新增或修改呼叫中心业务能力时，至少按下面顺序查看：

1. [AGENTS.md](../AGENTS.md)
2. [docs/specs/README.md](specs/README.md)
3. [docs/architecture/overview.md](architecture/overview.md)
4. 对应前后台工程 README：
   - [services/callcenter-server/README.md](../services/callcenter-server/README.md)
   - [services/callcenter-web/README.md](../services/callcenter-web/README.md)

必须先明确领域模型的能力包括：电话、坐席、CTI、实时通道、聊天、录音、质检、AI 和报表。不要把这些能力直接做成系统管理菜单里的普通 CRUD。

## 架构与规范

| 主题 | 文档 |
| --- | --- |
| 系统架构概览 | [docs/architecture/overview.md](architecture/overview.md) |
| 模块边界和依赖规则 | [docs/architecture/boundaries.md](architecture/boundaries.md) |
| 数据流 | [docs/architecture/data-flow.md](architecture/data-flow.md) |
| 编码规范 | [docs/conventions/README.md](conventions/README.md) |
| 测试规范 | [docs/conventions/testing.md](conventions/testing.md) |
| 日志规范 | [docs/conventions/logging.md](conventions/logging.md) |

## 交付与运维导航

做环境初始化、发布、回滚或发布后验证时，优先阅读：

1. [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)
2. [docs/delivery/delivery-model.md](delivery/delivery-model.md)
3. [docs/delivery/pipelines.md](delivery/pipelines.md)
4. [docs/operations/github-environment-setup.md](operations/github-environment-setup.md)
5. [docs/operations/release-verification.md](operations/release-verification.md)
6. [docs/operations/rollback-runbook.md](operations/rollback-runbook.md)

本地 Compose 运维入口见 [deploy/README.md](../deploy/README.md)。

## 评审清单导航

如果你现在处于评审阶段，统一入口见：

- [docs/reviews/README.md](reviews/README.md)

## 维护规则

- 新增文档后，如果会影响“开发、测试、评审、交付”的主路径，必须同步更新本文档。
- 新增呼叫中心业务能力时，优先补齐 `docs/specs/` 或对应领域设计文档，再进入代码实现。
- 涉及部署、环境、流水线、制品、验证或回滚的变化，必须同步更新 `docs/delivery/` 或 `docs/operations/`。
