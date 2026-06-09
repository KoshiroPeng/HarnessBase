---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 变更触发矩阵，统一说明代码、SQL、接口、发布与自动化变更发生时必须同步检查的文档。
---

# 变更触发矩阵

## 目标

本文档把 HarnessBase 当前已经分散在多份规范、reference、plans 和 release 文档中的“同步更新要求”收敛成一张执行矩阵。

## 触发矩阵

| 变更类型 | 典型目录或文件 | 至少同步检查这些文档 | 至少补充这些结果 |
| --- | --- | --- | --- |
| 新增业务功能或业务域 | `server/ruoyi-modules/**`、`web/src/views/**`、`web/src/api/**`、`server/sql/**` | [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)、[docs/architecture/boundaries.md](../architecture/boundaries.md)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) | 仓库影响图、结构化任务、验证证据 |
| 后端 Controller / API 变更 | `server/**/controller/**/*.java` | [docs/reference/README.md](../reference/README.md)、[docs/reference/api-spec.yaml](../reference/api-spec.yaml)、[docs/architecture/code-map.md](../architecture/code-map.md) | API 摘要、已知差异记录、必要验证证据 |
| 前端 API 客户端变更 | [web/src/api](../../web/src/api) | [docs/reference/README.md](../reference/README.md)、[docs/reference/api-spec.yaml](../reference/api-spec.yaml)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) | 前后端一致性检查 |
| 响应码 / 异常处理变更 | `R.java`、`HttpStatus.java`、异常处理器 | [docs/reference/error-codes.md](../reference/error-codes.md)、[docs/reference/README.md](../reference/README.md) | 错误码说明、返回体语义记录 |
| SQL 脚本变更 | [server/sql](../../server/sql) | [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)、[deploy/release/README.md](../../deploy/release/README.md) | SQL 脚本核对、发布与回滚影响说明 |
| 模块边界或目录结构变更 | `server/`、`web/`、`deploy/`、`.github/workflows/` | [docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/README.md](../architecture/README.md)、[docs/architecture/boundaries.md](../architecture/boundaries.md) | 代码地图更新、入口导航更新 |
| 认证、权限或租户变更 | auth、role、menu 相关后端或前端 | [docs/design/feature-auth.md](../design/feature-auth.md)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)、[docs/reference/error-codes.md](../reference/error-codes.md) | 权限影响说明、必要验证证据 |
| 发布、回滚或 workflow 变更 | `.github/workflows`、[deploy/release](../../deploy/release) | [.github/README.md](../../.github/README.md)、[deploy/release/README.md](../../deploy/release/README.md)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md) | 发布路径核对、脚本入口核对 |

## 最小判断规则

如果不确定某次改动属于哪类，至少先判断三件事：

1. 是否改了接口契约
2. 是否改了 SQL / 数据结构
3. 是否改了发布、回滚或 workflow 路径

只要任意一项为“是”，就不能只改代码而不核对对应文档。

如果是新增业务功能，即使暂时不改 SQL 或发布材料，也必须先补一份最小仓库影响图，避免后续实现只落在单点文件里。
