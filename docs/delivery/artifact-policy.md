---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 制品与版本治理

## 目标

本文档用于定义 CallCenter 的构建产物、版本规则和可追溯要求，确保每次部署都能明确追溯到源码、构建过程和配置上下文。

## 制品范围

当前阶段至少应治理以下制品：

- `callcenter-server` 的可部署 Jar 包或 Docker 镜像。
- `callcenter-web` 的前端静态构建产物或 Docker 镜像。
- CI 构建元数据。
- 发布 workflow 上传的 release bundle。
- 数据库初始化和迁移脚本版本集合。
- 部署描述文件和环境配置模板。
- 历史骨架 `server` 的兼容构建产物。

## 版本原则

- 每个可部署制品必须有唯一版本号。
- 版本号必须可映射到唯一 Git commit。
- 禁止直接部署本地手工编译且无版本标识的产物。
- 同一版本在不同环境中部署时，应用二进制应保持一致，环境差异只来自配置与密钥。

## 推荐版本信息

建议每个制品至少记录：

- Git commit SHA。
- 构建时间。
- 构建分支。
- 构建流水线编号。
- 服务名称。
- 语义版本或发布批次号。

## 当前制品映射

| 制品 | 来源 | 用途 |
| --- | --- | --- |
| `services/callcenter-server/**/target/*.jar` | CallCenter Maven 构建 | CallCenter 后端发布候选制品 |
| `services/callcenter-web/dist/**` | pnpm + Vite 构建 | CallCenter 前端发布候选制品 |
| `callcenter-admin:local` | `deploy/compose.app.yml` | 本地后端应用镜像 |
| `callcenter-web:local` | `deploy/compose.app.yml` | 本地前端应用镜像 |
| `artifacts/build-metadata.txt` | `agent-guardrails.yml` | CI 构建追踪 |
| `release-output/release-metadata.txt` | `server-release.yml` | 发布批次追踪 |
| `release-output/release-plan.md` | `render-release-plan.sh` | 发布计划与审批摘要 |
| `release-output/server-artifact.sha256` | `server-release.yml` | Jar 完整性校验 |
| `deploy/release/**` | 仓库脚本 | 发布、回滚、验证执行材料 |

## 制品发布要求

- 构建成功后统一发布到受控制品仓库。
- 制品仓库必须保留历史版本。
- 部署只能引用仓库中的正式制品，不允许重新本地打包替换。
- 制品元数据必须可用于故障回溯和审计。

## 当前缺口

当前仓库已有 Maven、pnpm 和本地 Compose 构建入口，但尚未定义：

- 制品仓库目标位置。
- 发布批次与提交记录的映射方式。
- 多 Service 场景下的制品仓库分区、版本命名和保留策略。
- 回滚候选制品的自动发现和保留策略。

## 最小落地建议

1. 为 CallCenter 后端、前端和镜像制品定义统一命名格式。
2. 在 CI 中输出构建元数据文件。
3. 在部署记录中显式写入制品版本号。
4. 为回滚场景保留最近稳定版本清单。

## 维护规则

- 新增可部署单元时，必须先定义其制品格式和版本规则。
- 变更版本策略时，必须同步更新流水线文档和发布运行手册。
