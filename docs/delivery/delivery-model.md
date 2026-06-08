---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# Harness 交付模型

## 目标

本文档定义 CallCenter 的持续交付对象模型。项目级强制规则以根目录 [AGENTS.md](../../AGENTS.md) 为准；本文档展开 Application、Service、Environment、Infrastructure、Artifact、Pipeline、Verification 和 Rollback 的当前映射关系。

## 核心对象

### Application

`Application` 表示一个可被业务和运维共同识别的产品级系统边界。在当前仓库中，`CallCenter` 是唯一 Application。

### Service

`Service` 表示一个可独立构建、测试、部署和回滚的交付单元。

当前阶段按以下方式定义：

- `services/callcenter-server/`：CallCenter Java 后端 Service。
- `services/callcenter-web/`：CallCenter Vue 前端 Service。
- `server/`：历史后端骨架，仅兼容保留，不再作为当前主 Service。
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

- JVM、Node.js 与操作系统运行时。
- MySQL 8、Redis、MinIO。
- Nginx、Docker Compose 或 SSH/systemd 运行底座。
- 日志、指标和追踪采集链路。
- 制品仓库、镜像仓库和 CI Runner。

### Artifact

`Artifact` 表示可被 Pipeline 部署和回滚的版本化产物。当前至少包括：

- `callcenter-server` 构建出的 Jar 或镜像。
- `callcenter-web` 构建出的前端静态产物或镜像。
- CI 生成的构建元数据。
- 发布 workflow 上传的 release bundle。
- 数据库初始化与迁移脚本集合。

Artifact 必须能追溯到 Git commit、构建编号和目标 Service。

### Pipeline

`Pipeline` 表示由阶段和步骤组成的自动化流程。当前仓库已有入口：

- `Multi-Service CI`
- `Remote Host Bootstrap`
- `Server Release Orchestration`
- `Server Rollback`
- `deploy/ops` 本地 Compose 运维入口

Pipeline 必须围绕明确的 Service 和 Environment 执行，不允许把多个无法追踪的系统变更混成一个脚本。

### Verification

`Verification` 表示发布后验证和回滚判定。当前最小验证来源为：

- 容器健康状态。
- Spring Boot Actuator 健康检查。
- 前端 HTTP 健康检查。
- Prometheus、Loki 和 Grafana 本地观测。
- 发布脚本中的业务探针占位。

Verification 失败时进入 Rollback 或人工处置流程。

## 当前映射关系

| 层级 | 当前对象 | 说明 |
| --- | --- | --- |
| Application | CallCenter | 企业级呼叫中心 Web 平台 |
| Service | `callcenter-server` | Java 17 + Spring Boot 3.x 后端 |
| Service | `callcenter-web` | Vue 3 + Vite 前端 |
| Legacy | `server` | 历史 Java 后端骨架，仅兼容保留 |
| Environment | `dev`、`test`、`staging`、`prod` | 通过配置、GitHub Environments 和部署参数表达 |
| Infrastructure | Docker Compose、SSH 远端主机、systemd、MySQL 8、Redis、MinIO | 当前最小部署底座 |
| Infrastructure | Prometheus / Loki / Grafana | 当前本地观测能力 |
| Artifact | CallCenter 后端 Jar / 镜像、前端静态产物 / 镜像、构建元数据、发布包 | 当前发布产物 |
| Pipeline | CI、Bootstrap、Release、Rollback、deploy/ops | GitHub Actions 与本地运维脚本 |
| Verification | 健康检查、指标端点、观察窗口 | `deploy/ops health`、`verify-release.sh` 与运维文档 |

## 建模原则

- Application 负责业务边界和治理边界，不直接等价于 Git 仓库。
- Service 必须是最小可交付单元，不能把多个强耦合发布目标混为一个黑箱步骤。
- Environment 必须有明确准入条件、负责人和变更策略。
- Infrastructure 必须通过文档和配置管理，禁止依赖口头约定。
- Artifact 必须唯一、可追溯、可回滚。
- Pipeline 必须围绕 Service + Environment + Artifact 组合定义，而不是散落在脚本中。
- Verification 必须作为发布闭环的一部分，不是发布后的可选动作。

## 当前缺口

- 远端主机、GitHub Environments、密钥和审批人仍需要在真实仓库配置中落地。
- `callcenter-server` 和 `callcenter-web` 尚未接入完整独立发布、回滚和发布后验证 workflow。
- CTI、CRM、工单、客户资料等外部系统的真实连接器和验证探针尚未落地。
- Secrets/Connectors 目前由 GitHub Environment variables/secrets 和脚本环境变量承载，尚未接入独立密钥管理系统。

## 维护规则

- 新增可独立部署模块时，必须先更新本文档中的 Service 清单。
- 新增运行环境时，必须同步更新 [environments.md](environments.md)。
- 改变基础设施依赖时，必须同步更新 `deploy/` 材料和相关运维文档。
