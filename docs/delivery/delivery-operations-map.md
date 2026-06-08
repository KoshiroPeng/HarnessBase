---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 交付与运维导航图

## 目标

本文档作为 CallCenter 交付体系的统一入口，汇总当前仓库中与环境治理、发布、回滚、主机初始化和运行手册相关的 workflow、脚本与文档，帮助协作者快速找到正确入口。

## 总览

当前交付体系按三条主线组织：

1. `远端主机初始化`
2. `日常发布`
3. `异常回滚`

三条主线共享相同的环境治理、变量模板和验证逻辑。

## 一、远端主机初始化

适用场景：

- 首次接入 `staging` 或 `prod` 服务器。
- 远端主机重建后重新纳管。
- 从 `nohup` 切换到 `systemd`。

入口：

- Workflow：[.github/workflows/bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml)
- 脚本：[deploy/release/bootstrap-remote-host.sh](../../deploy/release/bootstrap-remote-host.sh)
- systemd 模板：[deploy/release/callcenter.service.template](../../deploy/release/callcenter.service.template)
- 手册：[docs/operations/remote-host-bootstrap.md](../operations/remote-host-bootstrap.md)

## 二、日常发布

适用场景：

- 新版本部署到 `test`、`staging`、`prod`

入口：

- Workflow：[.github/workflows/server-release.yml](../../.github/workflows/server-release.yml)
- 发布计划脚本：[deploy/release/render-release-plan.sh](../../deploy/release/render-release-plan.sh)
- 部署脚本：[deploy/release/deploy-via-ssh.sh](../../deploy/release/deploy-via-ssh.sh)
- 发布验证脚本：[deploy/release/verify-release.sh](../../deploy/release/verify-release.sh)
- 检查清单：[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
- 手册：[docs/operations/release-verification.md](../operations/release-verification.md)

## 三、异常回滚

适用场景：

- 发布后健康检查失败。
- 指标持续恶化。
- 关键业务路径异常。

入口：

- Workflow：[.github/workflows/server-rollback.yml](../../.github/workflows/server-rollback.yml)
- 回滚脚本：[deploy/release/rollback-via-ssh.sh](../../deploy/release/rollback-via-ssh.sh)
- 检查清单：[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
- 手册：[docs/operations/rollback-runbook.md](../operations/rollback-runbook.md)

## 四、环境与配置治理

入口：

- 环境定义：[docs/delivery/environments.md](environments.md)
- GitHub Environment 映射：[docs/delivery/github-environments.md](github-environments.md)
- GitHub 配置手册：[docs/operations/github-environment-setup.md](../operations/github-environment-setup.md)
- 变量与密钥模板：[deploy/release/environment-variable-template.md](../../deploy/release/environment-variable-template.md)
- 配置与密钥治理：[docs/operations/config-and-secrets.md](../operations/config-and-secrets.md)
- 本地 Compose 运维入口：[deploy/README.md](../../deploy/README.md)

## 五、交付模型与策略

入口：

- 交付模型：[docs/delivery/delivery-model.md](delivery-model.md)
- 流水线设计：[docs/delivery/pipelines.md](pipelines.md)
- 部署策略：[docs/delivery/deployment-strategies.md](deployment-strategies.md)
- 制品治理：[docs/delivery/artifact-policy.md](artifact-policy.md)
- 服务目标与门禁：[docs/operations/slo-and-gates.md](../operations/slo-and-gates.md)

## 推荐使用顺序

首次接入新环境：

1. 阅读 [docs/delivery/github-environments.md](github-environments.md)
2. 按 [docs/operations/github-environment-setup.md](../operations/github-environment-setup.md) 配置 GitHub Environments
3. 触发 [Remote Host Bootstrap](../../.github/workflows/bootstrap-remote-host.yml)
4. 触发 [Server Release Orchestration](../../.github/workflows/server-release.yml)

日常发布：

1. 触发 [Server Release Orchestration](../../.github/workflows/server-release.yml)
2. 观察验证结果
3. 若异常，再触发 [Server Rollback](../../.github/workflows/server-rollback.yml)

## 当前 Workflow 清单

| Workflow | 用途 |
| --- | --- |
| [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) | CI 质量门禁与制品归档 |
| [bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml) | 首次初始化远端主机 |
| [server-release.yml](../../.github/workflows/server-release.yml) | 日常发布与验证 |
| [server-rollback.yml](../../.github/workflows/server-rollback.yml) | 异常回滚与回滚后验证 |

## 本地运维入口

| 命令 | 用途 |
| --- | --- |
| `./deploy/ops start` | 启动基础设施容器 |
| `./deploy/ops start --app` | 启动基础设施和 CallCenter 应用容器 |
| `./deploy/ops health` | 执行本地健康检查 |

## 维护规则

- 新增交付脚本时，必须同步更新本文档。
- 新增 workflow 时，必须同步更新本文档及 README 入口。
