---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 文档导航总入口

## 目标

本文档作为 HernessDemo 仓库的统一文档入口，按“我要做什么”组织现有文档，帮助开发、测试、评审和交付过程快速定位必须阅读的材料。

## 当前仓库状态

- `server/` 是 HernessDemo 的 Java 8 + Spring Boot 2.7 后端骨架，包含质量门禁和标准包结构。
- `services/callcenter-server` 是从 CallCenter 合并进来的 Java 17 + Spring Boot 3.5 后端 Service。
- `services/callcenter-web` 是从 CallCenter 合并进来的 Vue 3 + TypeScript + Vite 前端 Service。
- `docs/design/` 与 `docs/reference/api-spec.yaml` 描述第一版目标功能和 API 契约，当前认证、搜索、计费接口尚未实现。
- `deploy/release/` 与 `.github/workflows/` 已提供 SSH/systemd 方式的发布、回滚和远端主机初始化骨架。
- `deploy/observability/` 已提供本地 Prometheus、Loki、Promtail、Grafana 配置。
- 前端能力当前由 `services/callcenter-web` 承载，不再使用根目录 `web/`。

## CallCenter 合并核对

当前已经从 `/Users/pengkang/Documents/workspace/CallCenter` 合并前后台代码，并按 Harness Service 边界放入 `services/`。

| CallCenter 资产 | 当前状态 | 说明 |
| --- | --- | --- |
| `AGENTS.md` / `README.md` 的 AI 协作入口思想 | 已吸收 | 当前仓库以根目录 [AGENTS.md](../AGENTS.md) 作为唯一 AI 规则入口 |
| `doc/specs` 的执行期文档收敛原则 | 已吸收并改造成 `docs/` | 当前按架构、规范、设计、交付、运维、治理和评审分区 |
| `server/` 后端目录边界 | 已具备 | 当前根 `server/` 仍是 HernessDemo 的 Java 8 后端骨架 |
| CallCenter 后端 | 已迁入 | 路径为 [services/callcenter-server](../services/callcenter-server) |
| CallCenter 前端 | 已迁入 | 路径为 [services/callcenter-web](../services/callcenter-web) |
| `deploy/compose.yml`、`compose.app.yml`、`deploy/ops` | 未迁入 | 当前仍采用 GitHub Actions + SSH/systemd 发布骨架，本地仅有 observability Compose |
| CallCenter 呼叫中心领域文档 | 未迁入 | HernessDemo 业务方向仍是项目管理平台；呼叫中心领域模型不得自动套用到 HernessDemo |

因此，前后台代码合并已完成；部署编排和呼叫中心领域文档没有直接迁入，后续若需要纳入，必须按 Harness Service、Environment、Artifact 和 Pipeline 重新建模。

## Harness 对象模型

当前交付文档使用 Harness Engineering 思想做映射：`Application -> Service -> Environment/Infrastructure -> Artifact -> Pipeline -> Verification -> Rollback`。

| Harness 对象 | HernessDemo 当前映射 | 入口 |
| --- | --- | --- |
| Application | `HernessDemo` | [docs/delivery/delivery-model.md](delivery/delivery-model.md) |
| Service | `server`、`callcenter-server`、`callcenter-web` | [services/README.md](../services/README.md) |
| Environment | `dev`、`test`、`staging`、`prod` | [docs/delivery/environments.md](delivery/environments.md) |
| Infrastructure | SSH 远端主机、systemd、MySQL 5.7、本地观测栈 | [docs/delivery/delivery-model.md](delivery/delivery-model.md) |
| Artifact | 后端 Jar、前端静态产物、构建元数据、发布包 | [docs/delivery/artifact-policy.md](delivery/artifact-policy.md) |
| Pipeline | CI、Bootstrap、Release、Rollback workflow | [docs/delivery/pipelines.md](delivery/pipelines.md) |
| Verification | 健康检查、指标端点、业务探针、观察窗口 | [docs/operations/release-verification.md](operations/release-verification.md) |

## 使用方式

如果你不确定该先看哪份文档，先看本文档，再根据当前任务进入对应场景。

如果你已经知道要看的目录，也可以直接进入对应目录首页；这些目录首页只做简短索引，具体规则以专题文档为准。

## 场景导航

| 我现在要做什么 | 优先阅读 |
| --- | --- |
| 开发后端代码 | [开发后端代码导航](#开发后端代码) |
| 开发 CallCenter Service | [CallCenter Service 导航](#callcenter-service-导航) |
| 开发完成后做自检 | [开发后自检导航](#开发后自检导航) |
| 做后台设计评审 | [后台设计评审导航](#后台设计评审) |
| 做需求评审 | [需求评审导航](#需求评审) |
| 做测试或补测试 | [测试导航](#测试导航) |
| 做发布、回滚或环境初始化 | [交付与运维导航](#交付与运维导航) |
| 查找所有评审清单 | [评审清单导航](#评审清单导航) |
| 查找评审输出模板 | [评审输出模板导航](#评审输出模板导航) |

## 开发后端代码

开发后端代码时，建议至少按下面顺序查看：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/overview.md](architecture/overview.md)
3. [docs/architecture/boundaries.md](architecture/boundaries.md)
4. [docs/conventions/README.md](conventions/README.md)
5. [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)
6. [docs/conventions/testing.md](conventions/testing.md)

当前新增业务代码应落在 `server/src/main/java/com/example/app/` 的标准分层包下。若新增 Controller、Service、Mapper、Entity 或 DTO，需要同时补充对应测试，并确认 ArchUnit、Checkstyle、SpotBugs 和 JaCoCo 仍通过。

如果当前改动涉及以下内容，再额外补读：

- 接口变更： [docs/reference/api-spec.yaml](reference/api-spec.yaml)
- 错误处理： [docs/conventions/error-handling.md](conventions/error-handling.md) 和 [docs/reference/error-codes.md](reference/error-codes.md)
- 数据库结构： [docs/delivery/pipelines.md](delivery/pipelines.md) 与 Flyway 相关规则
- 外部调用： [docs/architecture/boundaries.md](architecture/boundaries.md) 中 `ApiClient` 约束
- 发布影响： [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)

## CallCenter Service 导航

开发从 CallCenter 合并进来的前后台代码时，优先阅读：

1. [services/README.md](../services/README.md)
2. [services/callcenter-server/README.md](../services/callcenter-server/README.md)
3. [services/callcenter-web/README.md](../services/callcenter-web/README.md)
4. [docs/delivery/delivery-model.md](delivery/delivery-model.md)
5. [docs/delivery/pipelines.md](delivery/pipelines.md)

注意：

- `services/callcenter-server` 使用 Java 17 + Spring Boot 3.5，不受根 `server/` 的 Java 8 限制。
- `services/callcenter-web` 使用 Node >= 20.19.0 + pnpm 11.5.2。
- 修改 CallCenter Service 时，不要把代码混入根 `server/`。

## 开发后自检导航

完成后端代码改动后，建议至少按下面顺序自检一次：

1. [AGENTS.md](../AGENTS.md)
2. [docs/conventions/README.md](conventions/README.md)
3. [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)
4. [docs/conventions/testing.md](conventions/testing.md)

建议最少确认以下事项：

- 命名、注释、日志、文件规模和方法规模符合规范。
- 没有 `System.out.println`、`e.printStackTrace()`、字段级 `@Autowired`、裸用 `RestTemplate` 或 `HttpURLConnection`。
- 新增或调整的业务逻辑有对应测试，缺陷修复有回归测试。
- 若改动涉及 API、错误码、数据库迁移、交付流程或运行手册，相关文档已经同步更新。

## 后台设计评审

做后台设计评审时，建议阅读：

1. [docs/reviews/backend-design-review-checklist.md](reviews/backend-design-review-checklist.md)
2. [docs/architecture/boundaries.md](architecture/boundaries.md)
3. [docs/conventions/naming.md](conventions/naming.md)
4. [docs/conventions/error-handling.md](conventions/error-handling.md)
5. [docs/reference/api-spec.yaml](reference/api-spec.yaml)
6. [docs/reference/error-codes.md](reference/error-codes.md)

若设计涉及交付、配置、发布、回滚，再补读：

- [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)
- [docs/operations/config-and-secrets.md](operations/config-and-secrets.md)

## 需求评审

做需求评审时，建议阅读：

1. [docs/reviews/requirement-review-checklist.md](reviews/requirement-review-checklist.md)
2. [docs/design/README.md](design/README.md)
3. [docs/plans/README.md](plans/README.md)
4. [docs/architecture/overview.md](architecture/overview.md)

若需求涉及认证、搜索、计费等既有方向，可补读：

- [docs/design/feature-auth.md](design/feature-auth.md)
- [docs/design/feature-search.md](design/feature-search.md)
- [docs/design/feature-billing.md](design/feature-billing.md)

## 测试导航

做测试设计、补测试或评审测试用例时，建议阅读：

1. [docs/conventions/testing.md](conventions/testing.md)
2. [docs/reviews/testcase-review-checklist.md](reviews/testcase-review-checklist.md)
3. [docs/operations/release-verification.md](operations/release-verification.md)

如果是缺陷修复测试，还应补读：

- 对应需求或设计文档
- 对应错误码文档： [docs/reference/error-codes.md](reference/error-codes.md)
- 对应代码评审清单： [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)

## 交付与运维导航

做环境初始化、发布、回滚或发布后验证时，优先阅读：

1. [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)
2. [docs/operations/github-environment-setup.md](operations/github-environment-setup.md)
3. [docs/operations/release-verification.md](operations/release-verification.md)
4. [docs/operations/rollback-runbook.md](operations/rollback-runbook.md)
5. [docs/operations/remote-host-bootstrap.md](operations/remote-host-bootstrap.md)

## 评审清单导航

如果你现在处于评审阶段，统一入口见：

- [docs/reviews/README.md](reviews/README.md)

## 评审输出模板导航

如果你已经完成评审，准备沉淀评审结论、评审纪要或自检记录，统一入口见：

- [docs/reviews/templates/README.md](reviews/templates/README.md)

## 维护规则

- 新增文档后，如果会影响“开发、测试、评审、交付”的主路径，必须同步更新本文档。
- 新增目录级文档后，应优先补齐该目录的 `README.md` 或等价索引页，再把入口接入本文档。
- 如果一个任务需要同时参考多份文档，应优先把“文档组合”补进本文档，而不是让使用者自己猜。
