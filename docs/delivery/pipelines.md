---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# Pipeline 设计

## 目标

本文档定义 CallCenter 的 Pipeline 设计。按 Harness Engineering 思想，Pipeline 由 stages 和 steps 组成，每条发布链路都必须明确 Service、Environment、Artifact、Infrastructure、Secrets/Connectors、Verification 和 Rollback。

## Pipeline 分层

- `CI Pipeline`：负责构建、测试、静态检查和产物生成。
- `CD Pipeline`：负责把制品部署到目标环境。
- `Verification Pipeline`：负责发布后验证、观察和回滚判定。
- `Local Ops Pipeline`：负责本地 Compose 启停、构建、日志和健康检查。

三类流水线必须共享统一的版本号、变更说明和审计记录。

## Harness 对象映射

| Pipeline 维度 | 当前映射 |
| --- | --- |
| Service | `callcenter-server`、`callcenter-web`，历史兼容项 `server` |
| Environment | `dev`、`test`、`staging`、`prod` |
| Artifact | `services/callcenter-server/**/target/*.jar`、`services/callcenter-web/dist/**`、CallCenter Docker 镜像、`release-output/*`、`deploy/release/**` |
| Infrastructure | Docker Compose、SSH 远端主机 + systemd 服务 |
| Secrets/Connectors | GitHub Environment variables/secrets、客户本地配置 |
| Verification | `deploy/ops health`、`deploy/release/verify-release.sh` |
| Rollback | `.github/workflows/server-rollback.yml` + `rollback-via-ssh.sh` |

## 标准 Stages

### 1. Source

触发条件：

- Pull Request。
- 合并到主分支。
- 手工触发指定版本发布。

输入必须固定到可追溯的 Git commit，禁止使用不可追踪源码快照。

### 2. Build

构建阶段负责：

- 拉取依赖。
- 编译代码。
- 生成可部署制品。
- 输出版本号和构建元数据。

当前 Service 最小要求：

- `callcenter-server`: JDK 17 + Maven。
- `callcenter-web`: Node >= 20.19.0 + pnpm 11.5.2。
- `server`: JDK 1.8 + Maven 3.6.3，仅做历史骨架兼容校验。
- 每个 Service 生成唯一可追溯的构建产物。

### 3. Test

测试阶段负责：

- 单元测试。
- 必要的集成测试。
- 前端构建与类型检查。
- 外部系统 adapter 的隔离验证。

测试失败必须阻断后续部署，不允许以跳过测试的方式继续流转。

### 4. Scan

扫描阶段负责：

- 代码质量检查。
- 依赖与镜像漏洞扫描。
- 敏感信息泄露扫描。

当前仓库已落地部分代码质量检查，但尚未补齐依赖漏洞和密钥泄露扫描。

### 5. Package / Publish Artifact

制品阶段负责：

- 为制品打上版本标签。
- 发布到统一制品仓库或镜像仓库。
- 记录制品与 Git commit、构建时间、构建参数的映射关系。

没有唯一版本制品时，不允许进入部署阶段。

### 6. Deploy

部署阶段负责：

- 选择目标环境。
- 绑定目标 Service 和 Artifact。
- 解析目标 Infrastructure。
- 注入对应配置与密钥。
- 执行数据库初始化或迁移。
- 发布应用实例。
- 记录部署批次和操作者。

部署必须以 Service 为单位执行，不允许把多个系统改动混在不可审计的脚本里。

### 7. Verify

验证阶段负责：

- 检查健康检查端点。
- 检查关键日志、错误率和指标。
- 验证核心业务探针。
- 给出通过、观察中或回滚建议。

Verification 不是可选动作。业务模块落地后必须补充 CTI、坐席状态、来电弹屏和实时通道探针。

### 8. Rollback / Close

收尾阶段负责：

- 触发自动或人工回滚。
- 归档变更记录。
- 输出发布结论。
- 记录失败原因和后续动作。

## 当前仓库对应关系

当前已有能力：

- GitHub Actions 中的质量门禁，workflow 名称为 `Multi-Service CI`。
- `agent-guardrails.yml` 中的 CallCenter 后端、前端和历史骨架兼容校验。
- `bootstrap-remote-host.yml` 中的远端主机初始化编排。
- `server-release.yml` 中的手工发布编排、环境审批门禁、发布包生成和发布后验证入口。
- `server-rollback.yml` 中的独立回滚编排和回滚后验证入口。
- `deploy/ops` 中的本地 Compose 启停、构建、日志和健康检查入口。
- `deploy-via-ssh.sh` 中的最小远端部署骨架。
- `callcenter-server` 已有 Maven 聚合构建入口。
- `callcenter-web` 已有 pnpm 锁文件和 Vite 构建入口。

当前缺失能力：

- 更成熟的制品仓库接入与版本选择机制。
- 更成熟的部署平台适配，例如容器编排、滚动发布或 GitOps。
- 更自动化的回滚制品发现与选择机制。
- 更强的密钥管理系统接入，例如 Vault 或云原生密钥服务。
- 依赖漏洞扫描和密钥泄露扫描。
- Harness 原生连接器、服务目录和环境定义尚未接入；当前用 GitHub Actions 与脚本模拟最小模型。
- `callcenter-server` 和 `callcenter-web` 尚未接入独立发布、回滚和发布后验证 workflow。

## 最小落地顺序

1. 完善 CI Pipeline，确保制品可追溯。
2. 为 `test` 和 `staging` 建立最小 CD Pipeline。
3. 为健康检查和关键指标建立 Verification Pipeline。
4. 为 CTI、坐席状态、来电弹屏和实时通道补充业务探针。
5. 为生产环境补充审批、观察和回滚阶段。

## 当前文件映射

- `.github/workflows/agent-guardrails.yml`：CI Pipeline，实现多 Service 质量门禁、构建和制品归档。
- `.github/workflows/bootstrap-remote-host.yml`：首次接入远端主机时的初始化工作流。
- `.github/workflows/server-release.yml`：手工触发的发布编排入口，串联构建、审批和验证。
- `.github/workflows/server-rollback.yml`：独立回滚工作流，串联审批、回滚和回滚后验证。
- `deploy/ops`：本地 Compose 运维入口。
- `deploy/compose.yml`：基础设施 Compose。
- `deploy/compose.app.yml`：CallCenter 应用 Compose。
- `deploy/release/render-release-plan.sh`：生成标准化发布计划。
- `deploy/release/deploy-via-ssh.sh`：基于 SSH 的最小远端部署骨架。
- `deploy/release/rollback-via-ssh.sh`：基于 SSH 的最小远端回滚骨架。
- `deploy/release/verify-release.sh`：执行最小发布后验证。

## 维护规则

- 新增流水线阶段时，必须说明输入、输出和失败处理方式。
- 新增部署步骤时，必须说明是否可重试、是否幂等以及回滚路径。
- 流水线和环境规则不得只写在 CI 平台配置中，必须同步本文档。
