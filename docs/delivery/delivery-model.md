---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# Harness 交付模型

## 目标

本文档定义 HernessDemo 的持续交付对象模型。它参考 Harness CD 的常见组织方式：Pipeline 由 stages 和 steps 组成，CD 阶段围绕 Service、Environment、Infrastructure、Artifact、Secrets/Connectors、Verification 和 Rollback 编排。

本文档只描述交付对象和对象关系；发布步骤见 [pipelines.md](pipelines.md)，运行手册见 [docs/operations/](../operations/)。

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

当前阶段按以下方式定义：

- `server/`：HernessDemo Java 8 后端骨架。
- `services/callcenter-server/`：CallCenter Java 17 后端 Service。
- `services/callcenter-web/`：CallCenter Vue 前端 Service。
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

### Artifact

`Artifact` 表示可被 Pipeline 部署和回滚的版本化产物。当前至少包括：

- `server` 构建出的 Jar。
- `callcenter-server` 构建出的 Jar。
- `callcenter-web` 构建出的前端静态产物。
- CI 生成的构建元数据。
- 发布 workflow 上传的 release bundle。
- 后续 Flyway migration 集合。

Artifact 必须能追溯到 Git commit、构建编号和目标 Service。

### Pipeline

`Pipeline` 表示由阶段和步骤组成的自动化流程。当前仓库已有四条入口：

- `Multi-Service CI`
- `Remote Host Bootstrap`
- `Server Release Orchestration`
- `Server Rollback`

Pipeline 必须围绕明确的 Service 和 Environment 执行，不允许把多个无法追踪的系统变更混成一个脚本。

### Verification

`Verification` 表示发布后验证和回滚判定。当前最小验证来源为：

- `actuator/health`
- `actuator/prometheus`
- 发布脚本中的业务探针占位
- 观察窗口中的日志和指标

Verification 失败时进入 Rollback 或人工处置流程。

## 当前映射关系

当前仓库建议采用以下交付映射：

| 层级 | 当前对象 | 说明 |
| --- | --- | --- |
| Application | HernessDemo | 面向中小企业的在线项目管理平台 |
| Service | `server` | HernessDemo Java 8 + Spring Boot 2.7 后端骨架 |
| Service | `callcenter-server` | CallCenter Java 17 + Spring Boot 3.5 后端 |
| Service | `callcenter-web` | CallCenter Vue 3 + Vite 前端 |
| Environment | `dev`、`test`、`staging`、`prod` | 通过 profile、GitHub Environments 和部署参数表达 |
| Infrastructure | SSH 远端主机、systemd、MySQL 5.7 | 当前最小部署底座 |
| Infrastructure | Prometheus / Loki / Grafana | 当前本地观测能力 |
| Artifact | `herness-demo-server-*.jar`、`callcenter` Jar、前端静态产物、构建元数据、发布包 | 当前发布产物 |
| Pipeline | CI、Bootstrap、Release、Rollback | GitHub Actions workflow |
| Verification | 健康检查、指标端点、观察窗口 | `verify-release.sh` 与运维文档 |

## 建模原则

- Application 负责业务边界和治理边界，不直接等价于 Git 仓库。
- Service 必须是最小可交付单元，不能把多个强耦合发布目标混为一个黑箱步骤。
- Environment 必须有明确准入条件、负责人和变更策略。
- Infrastructure 必须通过文档和配置管理，禁止依赖口头约定。
- Artifact 必须唯一、可追溯、可回滚。
- Pipeline 必须围绕 Service + Environment + Artifact 组合定义，而不是散落在脚本中。
- Verification 必须作为发布闭环的一部分，不是发布后的可选动作。

## 当前缺口

结合当前仓库现状，还需要继续补齐：

- 远端主机、GitHub Environments、密钥和审批人仍需要在真实仓库配置中落地。
- 当前发布方式是最小 SSH/systemd 骨架，尚未为 `callcenter-server` 和 `callcenter-web` 单独接入发布 workflow。
- 业务模块尚未实现，API 契约与错误码需要随真实接口持续校准。
- Secrets/Connectors 目前由 GitHub Environment variables/secrets 和脚本环境变量承载，尚未接入独立密钥管理系统。

## 维护规则

- 新增可独立部署模块时，必须先更新本文档中的 Service 清单。
- 新增运行环境时，必须同步更新 `docs/delivery/environments.md`。
- 改变基础设施依赖时，必须同步更新 `deploy/` 材料和相关运维文档。
