---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 配置与密钥治理

## 目标

本文档用于规范 HernessDemo 的配置来源、密钥管理和环境覆盖方式，避免配置漂移、凭据泄露和不可审计的手工改动。

## 配置分类

### 静态配置

适合进入 Git 管理的配置，例如：

- 日志格式。
- 指标开关默认值。
- 非敏感业务默认参数。
- 本地开发模板配置。

### 环境配置

按环境变化但不属于敏感信息的配置，例如：

- 服务地址。
- 端口。
- 超时阈值。
- 资源规格。

### 密钥与敏感配置

不得直接提交到仓库的配置，例如：

- 数据库密码。
- 外部 API Token。
- 第三方支付密钥。
- JWT 签名密钥。

## 管理原则

- 源码仓库只保留非敏感默认配置和模板。
- 敏感配置必须来自受控密钥管理系统或 CI/CD 密文注入。
- 不同环境的配置差异必须有明确来源说明。
- 禁止在服务器上手工改配置后长期不回写治理文档。

## 当前仓库约束

当前已存在：

- `application.yml`
- `application-local.yml`
- `application-test.yml`
- `application-staging.yml`
- `application-prod.yml`
- `deploy/release/environment-variable-template.md`
- `docs/operations/github-environment-setup.md`

后续建议补齐：

- 环境配置命名约定。
- 密钥轮换流程。
- 更强的密钥托管与审计能力。

## 当前模板入口

当前仓库已提供变量与密钥模板：

- `deploy/release/environment-variable-template.md`
- `docs/operations/github-environment-setup.md`

建议以该模板为准，在 GitHub Environments、部署平台或密钥管理系统中逐项落地。

## 推荐最小实践

1. 为每个环境维护统一的变量清单。
2. 在部署流水线中显式注入配置与密钥。
3. 为敏感配置建立轮换负责人和轮换周期。
4. 在日志中禁止输出密钥、令牌和完整凭据。

## 审计要求

- 配置变更应可追溯到提交、工单或发布记录。
- 密钥变更应记录时间、责任人和影响范围。
- 紧急变更必须在事后补齐审计记录。

## 维护规则

- 新增配置项时，必须标明是否敏感、适用环境和默认值策略。
- 引入新的外部服务时，必须同步定义其凭据来源和轮换方式。
