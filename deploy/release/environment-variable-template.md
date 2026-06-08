---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 环境变量与密钥模板

本文件用于沉淀 ProjectPilot 各环境的变量和密钥清单，便于在 GitHub Environments、部署平台或密钥管理系统中统一维护。

本文档属于发布支撑材料，目标是减少环境准备的不确定性，而不是扩张新的平台范围。

## 公共变量

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `APP_PROFILE` | variable | 否 | `test` | Spring profile 名称 |
| `VERIFY_BASE_URL` | variable | 否 | `https://staging.example.com` | 发布后验证访问地址 |
| `OBSERVATION_MINUTES` | variable | 否 | `15` | 发布后观察窗口分钟数 |
| `RELEASE_OWNER` | variable | 否 | `backend-team` | 发布负责人 |
| `ONCALL_CONTACT` | variable | 否 | `oncall@example.com` | 值班联系人 |
| `APP_DEPLOY_DIR` | variable | 否 | `/opt/herness-demo` | 远端部署目录 |
| `APP_DEPLOY_PORT` | variable | 否 | `22` | SSH 端口 |
| `APP_DEPLOY_STRATEGY` | variable | 否 | `systemd` | 远端启动策略，支持 `systemd` 或 `nohup` |
| `APP_SERVICE_NAME` | variable | 否 | `herness-demo` | systemd 服务名 |

## 后端部署变量

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `SERVER_PORT` | variable | 否 | `8080` | 服务端口 |
| `JAVA_OPTS` | variable | 否 | `-Xms256m -Xmx512m` | JVM 运行参数 |
| `LOG_LEVEL_ROOT` | variable | 否 | `INFO` | 根日志级别 |
| `APP_PROFILE` | variable | 否 | `staging` | 目标环境使用的 Spring profile |

## 后端密钥

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `DB_URL` | secret | 是 | `jdbc:mysql://...` | 数据库连接串 |
| `DB_USERNAME` | secret | 是 | `app_user` | 数据库账号 |
| `DB_PASSWORD` | secret | 是 | `***` | 数据库密码 |
| `JWT_SIGNING_KEY` | secret | 是 | `***` | JWT 签名密钥 |
| `API_CLIENT_TOKEN` | secret | 是 | `***` | 外部 API 调用令牌 |
| `APP_DEPLOY_HOST` | secret | 是 | `server.example.com` | 远端部署主机 |
| `APP_DEPLOY_USER` | secret | 是 | `deploy` | 远端部署账号 |
| `APP_DEPLOY_KEY` | secret | 是 | `***` | SSH 私钥内容 |

## 环境填写建议

### test

- 优先补齐验证链路所需最小变量。
- 不使用生产凭据。

### staging

- 尽量与生产配置结构一致。
- 验证回滚和发布检查清单。

### prod

- 所有敏感信息必须来自受控 secrets。
- 严禁使用临时人工口头分发的凭据。

## 维护规则

- 新增配置项时，同步补充到本模板。
- 删除配置项时，同步清理对应环境中的遗留变量和密钥。
- 如果某项变量暂时不直接服务当前 Web MVP 发布链路，应谨慎新增，避免配置面持续膨胀。

## 配套脚本

- 主机初始化：[deploy/release/bootstrap-remote-host.sh](bootstrap-remote-host.sh)
- 远端部署：[deploy/release/deploy-via-ssh.sh](deploy-via-ssh.sh)
- 发布后验证：[deploy/release/verify-release.sh](verify-release.sh)
- 发布前后检查：[deploy/release/release-checklist.md](release-checklist.md)
