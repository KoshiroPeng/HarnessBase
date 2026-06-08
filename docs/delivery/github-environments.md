---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# GitHub Environments 映射

## 目标

本文档定义 HernessDemo 在 GitHub Actions 中的 Environment 使用方式，把 Harness 风格的环境门禁、审批和密钥隔离映射到 GitHub 原生能力。

## 标准 Environment

仓库中建议至少创建以下 GitHub Environments：

- `test`
- `staging`
- `prod`

`dev` 当前更多用于本地或临时联调，不强制要求在 GitHub Environments 中单独建模。

## 每个 Environment 的建议配置

### test

建议配置：

- 可不启用人工审批。
- 保留环境级变量。
- 保留环境级密钥。
- 允许高频发布。

### staging

建议配置：

- 启用至少 1 位审批人。
- 配置环境级变量与密钥。
- 若有固定预发布地址，可配置 Environment URL。
- 要求发布前后执行验证脚本。

### prod

建议配置：

- 启用至少 2 位审批人，或 1 位审批人加值班人确认。
- 配置完整环境级变量与密钥。
- 配置正式环境 URL。
- 限制生产部署权限。
- 强制启用发布后观察窗口。

## 推荐变量与密钥划分

### Environment Variables

建议放入 GitHub Environment variables 的字段：

- `VERIFY_BASE_URL`
- `APP_PROFILE`
- `RELEASE_OWNER`
- `ONCALL_CONTACT`
- `OBSERVATION_MINUTES`

### Environment Secrets

建议放入 GitHub Environment secrets 的字段：

- `APP_DEPLOY_HOST`
- `APP_DEPLOY_USER`
- `APP_DEPLOY_KEY`
- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`
- `API_CLIENT_TOKEN`

## 与当前工作流的对应关系

当前发布工作流：

- `.github/workflows/server-release.yml`

该工作流会通过：

- `environment: \${{ inputs.target_environment }}`

把发布任务绑定到对应的 GitHub Environment。

这意味着：

- 若 Environment 配置了审批规则，工作流会在审批门禁处等待。
- 若 Environment 配置了变量和密钥，后续可逐步在部署脚本中读取。
- 当前工作流已开始读取 `vars.APP_PROFILE` 与 `vars.VERIFY_BASE_URL` 作为环境级输入入口。

## 当前落地建议

1. 先在仓库设置中创建 `test`、`staging`、`prod` 三个 Environment。
2. 为 `staging` 和 `prod` 添加审批人。
3. 为每个 Environment 补充统一变量和密钥命名。
4. 为 `prod` 配置正式 URL 和观察窗口责任人。
5. 按 `docs/operations/github-environment-setup.md` 完成 GitHub 设置落地。

## 维护规则

- 新增目标环境时，必须同步更新本文档和发布工作流输入项。
- 调整审批策略时，必须同步更新 `docs/governance/release-governance.md`。
