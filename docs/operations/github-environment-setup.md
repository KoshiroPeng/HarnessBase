---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# GitHub Environment 配置手册

## 目标

本文档提供 HernessDemo 在 GitHub 仓库中落地 `test`、`staging`、`prod` Environments 的具体操作步骤，让环境审批、密钥隔离和发布验证从文档约定变成真实配置。

## 前置条件

- 仓库管理员已确认有权限修改 GitHub Settings。
- 已准备环境负责人、审批人和值班联系人。
- 已根据 `deploy/release/environment-variable-template.md` 整理出变量与密钥清单。

## 创建 Environment

进入仓库：

1. 打开 GitHub 仓库主页。
2. 进入 `Settings`。
3. 打开左侧 `Environments`。
4. 依次创建：
   - `test`
   - `staging`
   - `prod`

## 配置 test

建议设置：

- `Required reviewers`：可留空。
- `Deployment branches`：按团队分支策略决定，默认可允许主分支和发布分支。
- `Environment variables`：
  - `APP_PROFILE=test`
  - `VERIFY_BASE_URL=<test 环境地址>`
  - `OBSERVATION_MINUTES=10`
  - `APP_DEPLOY_DIR=/opt/herness-demo-test`
  - `APP_DEPLOY_PORT=22`
  - `APP_DEPLOY_STRATEGY=nohup`
  - `APP_SERVICE_NAME=herness-demo-test`
- `Environment secrets`：
  - `DB_URL`
  - `DB_USERNAME`
  - `DB_PASSWORD`
  - `APP_DEPLOY_HOST`
  - `APP_DEPLOY_USER`
  - `APP_DEPLOY_KEY`

## 配置 staging

建议设置：

- `Required reviewers`：至少 1 人。
- `Deployment branches`：建议限制为 `main` 或发布分支。
- `Environment URL`：填写 staging 地址。
- `Environment variables`：
  - `APP_PROFILE=staging`
  - `VERIFY_BASE_URL=<staging 环境地址>`
  - `OBSERVATION_MINUTES=15`
  - `RELEASE_OWNER=<发布负责人>`
  - `ONCALL_CONTACT=<值班联系人>`
  - `APP_DEPLOY_DIR=/opt/herness-demo-staging`
  - `APP_DEPLOY_PORT=22`
  - `APP_DEPLOY_STRATEGY=systemd`
  - `APP_SERVICE_NAME=herness-demo-staging`
- `Environment secrets`：
  - `DB_URL`
  - `DB_USERNAME`
  - `DB_PASSWORD`
  - `API_CLIENT_TOKEN`
  - `APP_DEPLOY_HOST`
  - `APP_DEPLOY_USER`
  - `APP_DEPLOY_KEY`

## 配置 prod

建议设置：

- `Required reviewers`：至少 2 人，或 1 位审批人加值班确认。
- `Wait timer`：可按团队要求配置观察前等待时间。
- `Deployment branches`：限制为主分支或受控发布分支。
- `Environment URL`：填写正式地址。
- `Environment variables`：
  - `APP_PROFILE=prod`
  - `VERIFY_BASE_URL=<prod 环境地址>`
  - `OBSERVATION_MINUTES=30`
  - `RELEASE_OWNER=<发布负责人>`
  - `ONCALL_CONTACT=<值班联系人>`
  - `APP_DEPLOY_DIR=/opt/herness-demo`
  - `APP_DEPLOY_PORT=22`
  - `APP_DEPLOY_STRATEGY=systemd`
  - `APP_SERVICE_NAME=herness-demo`
- `Environment secrets`：
  - `DB_URL`
  - `DB_USERNAME`
  - `DB_PASSWORD`
  - `API_CLIENT_TOKEN`
  - `JWT_SIGNING_KEY`
  - `APP_DEPLOY_HOST`
  - `APP_DEPLOY_USER`
  - `APP_DEPLOY_KEY`

## 与仓库文件的对应关系

- 环境定义：`docs/delivery/github-environments.md`
- 变量模板：`deploy/release/environment-variable-template.md`
- 发布检查清单：`deploy/release/release-checklist.md`
- 发布工作流：`.github/workflows/server-release.yml`

## 配置完成后的验证

完成配置后，建议执行：

1. 先手工触发 `Remote Host Bootstrap`。
2. 选择目标环境并使用 `dry_run=true` 验证初始化计划。
3. 再在可控环境中以 `dry_run=false` 完成首次主机初始化。
4. 初始化完成后，再触发 `Server Release Orchestration`。
5. 使用 `dry_run=true` 验证发布审批和摘要输出。
6. 最后在可控环境中使用 `dry_run=false` 和真实 `VERIFY_BASE_URL` 验证发布后检查。

## 远端服务托管建议

- `test`：可先使用 `nohup`，降低初期接入成本。
- `staging` / `prod`：建议切换到 `systemd`，并参考 `deploy/release/herness-demo.service.template` 统一管理服务生命周期。

若首次接入新的 `staging` 或 `prod` 主机，建议先参考：

- `docs/operations/remote-host-bootstrap.md`

并执行：

- `deploy/release/bootstrap-remote-host.sh`

## 维护规则

- 变量或密钥名称变更时，必须同步更新工作流和模板文档。
- 审批人、分支限制或环境 URL 变化时，必须同步更新本文档。
