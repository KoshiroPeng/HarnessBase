---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 环境治理

## 目标

本文档定义 CallCenter 的标准环境分层、差异边界和准入条件，避免环境用途混乱、配置漂移或发布流程失控。

## 标准环境

### dev

`dev` 用于开发、自测和基础联调。

特点：

- 允许高频部署。
- 可以使用精简数据和模拟依赖。
- 允许为开发效率启用更宽松的非生产配置。
- 不作为最终验收依据。

### test

`test` 用于集成测试、回归测试和接口兼容性验证。

特点：

- 配置应尽量接近生产约束。
- 需要稳定的数据库和基础依赖。
- 重点验证功能正确性、迁移脚本和接口兼容性。
- 不允许长期堆积未清理的临时开关。

### staging

`staging` 用于预发布验收、变更演练和发布前风险评估。

特点：

- 环境拓扑应尽量接近生产。
- 发布步骤、配置覆盖和回滚脚本必须可在此演练。
- 需要验证观测、告警、迁移和部署策略是否生效。
- 业务验收和上线前检查应优先在此完成。

### prod

`prod` 用于正式对外服务。

特点：

- 所有配置与密钥必须受控管理。
- 部署必须经过质量门禁和审批策略。
- 发布后必须执行观测验证和回滚判定。
- 严禁将实验性配置直接带入生产。

## 环境差异维度

环境差异只能来自受控维度，不允许散落在源代码分支判断中。

允许的差异包括：

- 数据库连接地址和容量。
- 外部依赖地址与凭据。
- 日志级别和采样比例。
- 功能开关默认值。
- 部署副本数和资源规格。
- 告警阈值和验收阈值。

禁止的差异包括：

- 生产环境独有但未在低环境验证过的关键逻辑。
- 只存在于某个环境的手工补丁。
- 依赖人工登录服务器临时修改配置。

## 环境准入条件

### 进入 test 的准入条件

- 代码已通过本地编译和单元测试。
- 架构规则和静态检查通过。
- 数据库迁移脚本可在空库执行。
- API 和错误码相关文档已同步。

### 进入 staging 的准入条件

- test 环境通过集成测试与回归测试。
- 变更涉及的配置、密钥和部署参数已审阅。
- 观测指标和日志字段已可用。
- 回滚步骤已明确。

### 进入 prod 的准入条件

- staging 已完成验收。
- 发布负责人、审批人和值班联系人明确。
- 发布窗口、风险说明和回滚条件明确。
- 发布验证指标和观察时长明确。

## 当前落地状态

当前仓库已经为 CallCenter 提供本地 Compose 环境入口，并保留历史骨架 `server` 的最小 profile 配置：

| 入口 | 文件 | 当前用途 |
| --- | --- | --- |
| 基础设施 | `deploy/compose.yml` | 启动 MySQL 8、Redis、MinIO |
| 应用 | `deploy/compose.app.yml` | 启动 CallCenter 后端和前端应用容器 |
| 运维脚本 | `deploy/ops` | 统一启停、构建、日志和健康检查 |

历史骨架 profile：

| Profile | 文件 | 当前用途 |
| --- | --- | --- |
| 默认 | `server/src/main/resources/application.yml` | 定义应用名、Actuator 暴露范围、日志文件位置 |
| local | `server/src/main/resources/application-local.yml` | 排除 DataSource 和 Flyway，便于无数据库时启动健康检查和指标端点 |
| test | `server/src/main/resources/application-test.yml` | 通过环境变量注入数据库连接，保留本地默认值便于集成测试 |
| staging | `server/src/main/resources/application-staging.yml` | 通过环境变量注入数据库连接，尽量贴近生产约束 |
| prod | `server/src/main/resources/application-prod.yml` | 必须通过外部环境变量提供数据库连接和凭据 |

仍需继续补齐：

1. 为数据库、外部 API、日志级别和指标开关建立更完整的环境差异表。
2. 在真实 GitHub Environments 中配置负责人、审批人、变量和密钥。
3. 为 `services/callcenter-server` 和 `services/callcenter-web` 补齐环境差异表。
4. 在真实 test/staging/prod 主机上演练发布、验证和回滚。

## GitHub Environment 映射

若使用 GitHub Actions 作为最小交付入口，环境映射建议见：

- `docs/delivery/github-environments.md`

通过该映射可把审批、密钥隔离和发布 URL 绑定到工作流环境。

## 维护规则

- 新增环境变量或密钥时，必须说明适用环境和来源。
- 新增环境专属能力时，必须说明为何不能在低环境验证。
- 环境职责变化时，必须同步更新本文档和相关流水线文档。
