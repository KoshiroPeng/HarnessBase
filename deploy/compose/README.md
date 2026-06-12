---
last_updated: 2026-06-12
status: active
owner: "@PengKang"
description: HarnessBase docker-compose 部署入口，汇总当前容器化部署主线、前置条件、脚本、配置文件与最小验证步骤。
---

# docker-compose 部署入口

## 目标

本文档把 HarnessBase 当前新增的 `docker-compose` 部署方式收敛为一条正式可执行的发布路径，重点解决以下问题：

1. 让现有微服务工程具备“一次编排，多服务协同启动”的部署方式。
2. 把原本分散在 [server/docker](../../server/docker) 下的容器化资产，收口到当前 [deploy](../) 发布主线中。
3. 为生产或准生产环境提供比单服务 SSH 发布更适合整套微服务联动验证的交付方式。

## 当前部署范围

当前 `docker-compose` 方案编排的服务包括：

- `ruoyi-mysql`
- `ruoyi-redis`
- `ruoyi-nacos`
- `ruoyi-auth`
- `ruoyi-system`
- `ruoyi-gen`
- `ruoyi-job`
- `ruoyi-file`
- `ruoyi-monitor`
- `ruoyi-gateway`
- `ruoyi-nginx`

其中：

- MySQL 通过 [server/sql/ry_20260321.sql](../../server/sql/ry_20260321.sql) 与 [server/sql/ry_config_20260311.sql](../../server/sql/ry_config_20260311.sql) 初始化业务库和 Nacos 配置库。
- `deploy/compose/mysql/initdb/30_ry_config_compose_20260610.sql` 会把 Nacos 中默认写死的 `localhost` 配置修正为容器网络服务名，并同步修正 compose 场景下的数据库连接密码。
- 前端仍按当前 Vue 2 产物构建后，由 Nginx 统一托管并通过 `/prod-api/` 反向代理到网关。
- MySQL、Redis 与 Nacos 日志当前采用 Docker named volume 持久化，减少在 Windows + WSL 场景下直接挂载 `/mnt/d/...` 可写目录带来的权限与健康检查问题。

## 目录说明

| 路径 | 作用 |
| --- | --- |
| [docker-compose.yml](docker-compose.yml) | 当前容器编排主文件 |
| [.env.example](.env.example) | 环境变量模板 |
| [.env.prod.example](.env.prod.example) | 生产环境模板示例 |
| [build-compose-artifacts.sh](build-compose-artifacts.sh) | 构建后端 Jar 和前端 dist |
| [manage-compose.sh](manage-compose.sh) | `docker compose` 常用操作封装 |
| [verify-compose-stack.sh](verify-compose-stack.sh) | 最小部署验证脚本 |
| [backup-compose-release.sh](backup-compose-release.sh) | 远端部署前创建 compose 回滚快照 |
| [backup-compose-data.sh](backup-compose-data.sh) | 对 MySQL、Redis、Nacos 日志和上传目录做数据级备份 |
| [deploy-compose-via-ssh.sh](deploy-compose-via-ssh.sh) | 把 compose 部署包同步到远端并执行编排 |
| [rollback-compose-via-ssh.sh](rollback-compose-via-ssh.sh) | 按远端快照恢复 compose 部署 |
| [restore-compose-data.sh](restore-compose-data.sh) | 从远端数据备份归档恢复 MySQL、Redis、Nacos 日志和上传目录 |
| [docker/backend.Dockerfile](docker/backend.Dockerfile) | 后端微服务统一运行镜像 |
| [docker/frontend-nginx.Dockerfile](docker/frontend-nginx.Dockerfile) | 前端 Nginx 镜像 |
| [docker/backend-entrypoint.sh](docker/backend-entrypoint.sh) | 后端容器等待 Nacos 后再启动 |
| [nginx/nginx.conf](nginx/nginx.conf) | 前端反向代理配置 |
| [nacos/conf/application.properties](nacos/conf/application.properties) | Nacos 容器配置 |
| [mysql/initdb/30_ry_config_compose_20260610.sql](mysql/initdb/30_ry_config_compose_20260610.sql) | docker-compose 专用 Nacos 配置修正 |

## 前置条件

执行前至少确认：

1. 目标主机已安装 Docker Engine 与 Docker Compose Plugin。
2. 目标主机可在当前仓库根目录执行 `docker compose`。
3. 若使用源码构建镜像，先确认宿主机磁盘空间足以容纳 Maven、npm 和 Docker 构建缓存。
4. 若使用默认 `.env.example` 或 `.env.prod.example`，必须在正式环境先复制为 `.env` 并替换敏感值，尤其是：
   - `MYSQL_ROOT_PASSWORD`
   - `NACOS_AUTH_TOKEN`
   - 对外暴露端口
   - `FILE_UPLOAD_PATH`
5. 若通过 GitHub Actions 远端部署 compose，建议把 `APP_DEPLOY_DIR` 配成独立目录，例如 `/opt/harness-base-compose`，不要与单服务 SSH 发布目录共用。

## 推荐操作顺序

### 1. 准备环境变量

优先使用自定义环境文件：

```bash
cp deploy/compose/.env.example deploy/compose/.env
```

然后按目标环境修改 `deploy/compose/.env` 中的端口、密码、上传目录和对外访问地址。

如果目标是生产环境，建议从下面的模板开始：

```bash
cp deploy/compose/.env.prod.example deploy/compose/.env
```

### 2. 构建业务制品

```bash
bash deploy/compose/build-compose-artifacts.sh
```

脚本会执行：

- [server](../../server) 下 `mvn -B -DskipTests package`
- [web](../../web) 下 `npm install`
- [web](../../web) 下 `npm run build:prod`

如果前端依赖已经安装完成，可用下面方式跳过重复安装：

```bash
SKIP_FRONTEND_INSTALL=true bash deploy/compose/build-compose-artifacts.sh
```

### 3. 启动基础设施

```bash
bash deploy/compose/manage-compose.sh up-base
```

该步骤会先启动：

- MySQL
- Redis
- Nacos

### 4. 启动业务服务与前端入口

```bash
bash deploy/compose/manage-compose.sh up-apps
```

若希望一步拉起整套服务，可直接执行：

```bash
bash deploy/compose/manage-compose.sh up-all
```

### 5. 执行最小验证

```bash
bash deploy/compose/manage-compose.sh verify
```

默认验证内容包括：

- `docker compose ps`
- 前端入口 `http://127.0.0.1:${NGINX_HTTP_PORT}`
- 网关健康检查 `http://127.0.0.1:${GATEWAY_HTTP_PORT}/actuator/health`
- 监控服务健康检查 `http://127.0.0.1:${MONITOR_HTTP_PORT}/actuator/health`

当前 `docker-compose.yml` 还为 MySQL、Redis、各后端微服务、网关和 Nginx 增加了容器级 `healthcheck`，可用于判断依赖顺序和运行状态。

## 本地联调实测结论

截至 2026-06-12，当前 compose 方案已经在 `Windows 11 + Docker Desktop + WSL2 Ubuntu 24.04` 环境完成一轮真实联调验证，验证通过的最小链路如下：

```bash
bash deploy/compose/build-compose-artifacts.sh
bash deploy/compose/manage-compose.sh up-base
bash deploy/compose/manage-compose.sh up-apps
bash deploy/compose/manage-compose.sh verify
```

本轮验证通过后，默认可访问入口包括：

- 前端入口：`http://127.0.0.1:${NGINX_HTTP_PORT}`
- 网关健康检查：`http://127.0.0.1:${GATEWAY_HTTP_PORT}/actuator/health`
- 监控服务健康检查：`http://127.0.0.1:${MONITOR_HTTP_PORT}/actuator/health`
- Nacos 控制台：`http://127.0.0.1:${NACOS_HTTP_PORT}/nacos`

相比直接执行 `up-all`，更推荐按 `up-base -> up-apps -> verify` 的顺序启动，这样更容易定位是基础设施问题还是业务服务问题。

## 首次初始化与失败重建

以下场景建议重建 MySQL 数据卷后再重新启动：

- 首次引入或修改 [mysql/initdb/30_ry_config_compose_20260610.sql](mysql/initdb/30_ry_config_compose_20260610.sql)
- 调整了 `MYSQL_ROOT_PASSWORD`
- Nacos 已能启动，但业务服务仍从配置中心读取到旧的数据库地址、旧密码或旧文件路径

推荐步骤：

```bash
docker compose --env-file deploy/compose/.env -f deploy/compose/docker-compose.yml down
docker volume rm -f harness-base_ruoyi-mysql-data
bash deploy/compose/manage-compose.sh up-base
bash deploy/compose/manage-compose.sh up-apps
bash deploy/compose/manage-compose.sh verify
```

原因是：Nacos 配置库会在 MySQL 首次初始化时导入默认配置，后续即使你修改了初始化 SQL，已经落库的旧配置也不会自动覆盖。

## 常见排障

### `ruoyi-mysql` 启动异常或长时间不健康

- 先确认没有把 MySQL 数据目录直接绑定到 Windows 的高风险可写目录。
- 当前默认方案已经改为 Docker named volume；如果你曾经用过旧版 bind mount 配置，建议执行一次“失败重建”流程。

### `ruoyi-system`、`ruoyi-gen`、`ruoyi-job` 启动失败，日志提示数据库认证失败

- 先查看日志：`bash deploy/compose/manage-compose.sh logs ruoyi-system`
- 如果错误类似 `Access denied for user 'root'`，通常不是容器没连上 MySQL，而是 Nacos 中保存的数据库密码仍是旧值。
- 这种情况需要按上面的“失败重建”流程清掉 `harness-base_ruoyi-mysql-data` 后重新导入配置。

### `verify` 失败但容器看起来已经启动

- 先执行 `bash deploy/compose/manage-compose.sh ps` 确认是否所有服务都已 `healthy`。
- 再分别检查：
  - `http://127.0.0.1:${NGINX_HTTP_PORT}`
  - `http://127.0.0.1:${GATEWAY_HTTP_PORT}/actuator/health`
  - `http://127.0.0.1:${MONITOR_HTTP_PORT}/actuator/health`
- 如果某个服务仍处于 `starting`，优先看该服务日志，而不是立即判断整套部署失败。

## GitHub Actions 触发方式

仓库现在已经补充了 compose 发布 workflow：

- [compose-release.yml](../../.github/workflows/compose-release.yml)
- [compose-rollback.yml](../../.github/workflows/compose-rollback.yml)
- [compose-data-ops.yml](../../.github/workflows/compose-data-ops.yml)

推荐顺序：

1. 在 GitHub Actions 手动触发 `Compose Release`
2. 选择目标 `Environment`
3. 选择 `.env.example` 或 `.env.prod.example`
4. 先用 `dry_run=true` 看远端部署计划
5. 再执行真实部署

当前 workflow 的交付方式是：

- CI 先构建受控制品：后端 Jar 与前端 dist
- 将 compose 部署包上传为 workflow artifact
- 在远端主机执行 `docker compose build`、`up` 与 `verify`

这条主线的特点是：远端不再重新跑 Maven 和 npm 构建，更适合生产交付。

## 快照与回滚

当前 compose 发布链路已经补充了远端快照与回滚能力：

- 每次真实执行 [deploy-compose-via-ssh.sh](deploy-compose-via-ssh.sh) 时，默认会先调用 [backup-compose-release.sh](backup-compose-release.sh) 在远端创建一份快照。
- 快照默认保存在 `APP_DEPLOY_DIR/backups/<时间戳-版本号>/`。
- 快照内容聚焦当前 `docker-compose.yml`、`.env`、环境模板和 compose 初始化补丁，便于恢复部署编排状态。

如果需要手动回滚，可执行：

```bash
bash deploy/compose/rollback-compose-via-ssh.sh
```

若通过 GitHub Actions 回滚，可手动触发：

- [compose-rollback.yml](../../.github/workflows/compose-rollback.yml)

回滚时需要提供：

- `target_environment`
- `rollback_backup`
- `rollback_reason`
- `dry_run`

## 数据备份与恢复

当前 compose 方案还额外补充了“数据目录级”操作能力，和配置快照分开：

- [backup-compose-data.sh](backup-compose-data.sh)：备份 MySQL、Redis、Nacos 日志和文件上传目录
- [restore-compose-data.sh](restore-compose-data.sh)：恢复上述数据目录并重新拉起服务
- 数据备份归档默认保存在 `APP_DEPLOY_DIR/data-backups/<时间戳或标签>/`，和编排快照目录分开维护

GitHub Actions 对应入口：

- [compose-data-ops.yml](../../.github/workflows/compose-data-ops.yml)

推荐理解方式：

- `backup-compose-release.sh` / `rollback-compose-via-ssh.sh` 解决“编排与配置状态回滚”
- `backup-compose-data.sh` / `restore-compose-data.sh` 解决“数据目录归档与恢复”

如果生产环境需要完整恢复，通常应组合使用这两组能力，而不是只做其中一种。

## 常用命令

```bash
# 查看容器状态
bash deploy/compose/manage-compose.sh ps

# 查看全部日志
bash deploy/compose/manage-compose.sh logs

# 查看单个服务日志
bash deploy/compose/manage-compose.sh logs ruoyi-gateway

# 重启整套服务
bash deploy/compose/manage-compose.sh restart

# 停止并删除容器网络
bash deploy/compose/manage-compose.sh down
```

## 与现有 SSH 发布方式的关系

当前仓库现在同时保留两条部署路径：

- [deploy/release](../release)：适合按单个微服务模块做 SSH 发布、回滚和审批门禁。
- [deploy/compose](.)：适合整套微服务协同部署、环境重建和联调整体验证。

建议使用场景：

- 单服务热更新、快速回滚：优先用 [deploy/release](../release)。
- 新环境搭建、整套联调、准生产环境演练：优先用 [deploy/compose](.)。

## 当前限制与后续建议

当前这套 `docker-compose` 方案已经可以作为正式仓库主线的一种部署方式，但仍有三个现实限制需要明确：

1. 当前 workflow 仍然是“上传受控制品到远端后现场 build 镜像”，尚未接入独立镜像仓库分发主线。
2. 当前数据级备份是“目录归档恢复”方案，适合单机 compose 场景，但尚未细化到数据库逻辑备份、增量备份或跨主机容灾。
3. `ruoyi-file-dev.yml` 与自动复制出来的 `ruoyi-file-prod.yml` 中，文件服务公网域名默认仍偏本地示例，正式环境应在 Nacos 中进一步改成实际域名或网关地址。

如果后续要继续强化生产可用性，建议下一步优先补：

1. 基于 CI 构建并推送镜像到私有仓库。
2. 为 MySQL 增加逻辑备份或物理热备策略，而不只依赖目录归档。
3. 为网关、Nacos、MySQL、Redis 增加更细粒度的健康检查和备份策略。

## 配套入口

- [deploy/release/README.md](../release/README.md)
- [deploy/release/release-checklist.md](../release/release-checklist.md)
- [deploy/observability/README.md](../observability/README.md)
- [docs/architecture/code-map.md](../../docs/architecture/code-map.md)
- [docs/conventions/development-execution-guide.md](../../docs/conventions/development-execution-guide.md)
