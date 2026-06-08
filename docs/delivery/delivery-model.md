---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 交付模型

## 目标

本文档用于定义 HernessDemo 在持续交付中的核心对象，参考 Harness 常见的平台工程思想，把业务系统、部署单元、环境和基础设施的关系明确下来，避免后续流水线、部署脚本和运维规则各自演化。

## 核心对象

### Application

`Application` 表示一个可被业务和运维共同识别的产品级系统边界。在当前仓库中，`HernessDemo` 是唯一 Application。

Application 负责聚合：

- 一个或多个可独立演进的服务。
- 统一的发布治理规则。
- 统一的环境分层。
- 统一的审计、监控和发布门禁。

### Service

`Service` 表示一个可独立构建、测试、部署和回滚的交付单元。

当前阶段建议按以下方式定义：

- `server/`：后端服务，当前唯一正式 Service。
- `web/`：前端应用，目录已预留，启用后作为独立 Service 管理。
- `deploy/observability/`：观测栈配置，不视为业务 Service，但属于平台辅助资产。

Service 必须具备以下特征：

- 有明确源码目录和构建入口。
- 有清晰的版本产物定义。
- 有独立的质量门禁。
- 有明确的部署目标和回滚边界。

### Environment

`Environment` 表示一组具有稳定配置、访问边界和发布权限的运行环境。

建议统一分为：

- `dev`：开发联调环境。
- `test`：集成测试环境。
- `staging`：预发布验收环境。
- `prod`：生产环境。

环境差异不得散落在代码中，必须通过配置、密钥和部署参数显式表达。

### Infrastructure

`Infrastructure` 表示承载 Service 运行的底座能力，例如：

- JVM 与操作系统运行时。
- MySQL 5.7。
- 反向代理或网关。
- 日志、指标和追踪采集链路。
- 制品仓库、镜像仓库和 CI Runner。

Infrastructure 的目标不是承载业务逻辑，而是提供可复用、可审计、可替换的运行能力。

## 当前映射关系

当前仓库建议采用以下交付映射：

| 层级 | 当前对象 | 说明 |
| --- | --- | --- |
| Application | HernessDemo | 面向中小企业的在线项目管理平台 |
| Service | `server` | Spring Boot 后端服务 |
| Service | `web` | 前端应用目录预留，启用后纳入独立交付 |
| Infrastructure | MySQL 5.7 | 业务主数据库 |
| Infrastructure | Prometheus / Loki / Grafana | 当前本地观测能力 |
| Environment | dev/test/staging/prod | 需在文档和流水线中进一步落地 |

## 建模原则

- Application 负责业务边界和治理边界，不直接等价于 Git 仓库。
- Service 必须是最小可交付单元，不能把多个强耦合发布目标混为一个黑箱步骤。
- Environment 必须有明确准入条件、负责人和变更策略。
- Infrastructure 必须通过文档和配置管理，禁止依赖口头约定。
- 发布治理规则应围绕 Service 和 Environment 组合定义，而不是散落在脚本中。

## 当前缺口

结合当前仓库现状，还需要继续补齐：

- `docs/delivery/environments.md` 中的环境定义和差异说明。
- `docs/delivery/pipelines.md` 中的阶段化流水线模型。
- `docs/delivery/deployment-strategies.md` 中的部署与回滚策略。
- `docs/operations/` 下的发布验证、配置密钥和运行手册。
- `docs/governance/` 下的审批、权限和审计规则。

## 维护规则

- 新增可独立部署模块时，必须先更新本文档中的 Service 清单。
- 新增运行环境时，必须同步更新 `docs/delivery/environments.md`。
- 改变基础设施依赖时，必须同步更新 `deploy/` 材料和相关运维文档。
