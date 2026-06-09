---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 变更触发矩阵，统一说明代码、SQL、接口、发布与自动化变更发生时必须同步检查的文档。
---

# 变更触发矩阵

## 目标

本文档把 HarnessBase 当前已经分散在多份规范、reference、plans 与 release 文档中的“同步更新要求”收敛成一张执行矩阵，方便后续开发、评审、发布和 AI 协作直接按表判断：

- 改了什么
- 必须联读哪些文档
- 至少要同步检查哪些材料

## 使用方式

- 开始动手前，先按本次改动类型查一遍本文档。
- 评审、自检和发布前，再按本文确认有没有漏改文档。
- 若某类变更经常重复触发相同同步动作，应优先把该条规则留在本文，而不是散落到对话里。

## 触发矩阵

| 变更类型 | 典型目录或文件 | 至少同步检查这些文档 | 至少补充这些结果 |
| --- | --- | --- | --- |
| 后端 Controller / API 变更 | `server/**/controller/**/*.java` | [docs/reference/README.md](../reference/README.md)、[docs/reference/api-spec.yaml](../reference/api-spec.yaml)、[docs/architecture/code-map.md](../architecture/code-map.md) | API 摘要、已知差异记录、必要验证证据 |
| 前端 API 客户端变更 | [web/src/api](../../web/src/api) | [docs/reference/README.md](../reference/README.md)、[docs/reference/api-spec.yaml](../reference/api-spec.yaml)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) | 前后端一致性检查、必要时登记已知差异 |
| 响应码 / 异常处理变更 | `GlobalExceptionHandler.java`、`SaTokenExceptionHandler.java`、`R.java`、`TableDataInfo.java`、`i18n` 消息 | [docs/reference/error-codes.md](../reference/error-codes.md)、[docs/reference/README.md](../reference/README.md) | 错误码说明、返回体语义变化记录、验证证据 |
| SQL 脚本变更 | [server/script/sql](../../server/script/sql) | [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)、[deploy/release/README.md](../../deploy/release/README.md) | 初始化脚本 / 升级脚本核对、发布与回滚影响说明 |
| 模块边界或目录结构变更 | `server/`、`web/`、`deploy/`、`.github/workflows/` 结构级调整 | [docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/README.md](../architecture/README.md)、[docs/architecture/boundaries.md](../architecture/boundaries.md) | 代码地图更新、入口导航更新、边界说明更新 |
| 认证、权限、租户变更 | auth、tenant、role、menu 相关后端或前端 | [docs/design/feature-auth.md](../design/feature-auth.md)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)、[docs/reference/error-codes.md](../reference/error-codes.md) | 设计说明、权限影响说明、必要验证证据 |
| 工作流、代码生成、系统管理主功能变更 | system、workflow、tool/gen、monitor、demo | [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)、[docs/reference/README.md](../reference/README.md) | 功能域说明、接口差异记录、必要验证证据 |
| 发布、回滚、远端初始化变更 | `.github/workflows`、[deploy/release](../../deploy/release) | [.github/README.md](../../.github/README.md)、[deploy/release/README.md](../../deploy/release/README.md)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md) | 发布路径核对、脚本入口核对、必要验证证据 |
| 可观测性变更 | [deploy/observability](../../deploy/observability)、Actuator、日志采集 | [deploy/observability/README.md](../../deploy/observability/README.md)、[docs/conventions/logging.md](logging.md)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md) | 观测入口说明、验证方式、发布影响说明 |
| 自动化检查规则或 CI 提醒变更 | 自动化文档、CI 护栏文档、后续 workflow 相关实现 | [docs/plans/automation-delivery-map.md](../plans/automation-delivery-map.md)、[docs/plans/automation-phase-acceptance-checklist.md](../plans/automation-phase-acceptance-checklist.md)、[docs/conventions/automation-check-catalog.md](automation-check-catalog.md)、[docs/conventions/automation-message-guidelines.md](automation-message-guidelines.md) | 阶段说明、试运行结果、验收结论或阻断策略调整 |
| 导航型文档或规则文档变更 | `AGENTS.md`、`docs/**/README.md`、规范类 Markdown | [docs/README.md](../README.md)、对应目录 `README.md`、[docs/conventions/document-links.md](document-links.md)、[docs/conventions/document-metadata.md](document-metadata.md) | 入口同步、标头更新、链接校验 |

## 最小判断规则

如果不确定某次改动属于哪类，至少先判断三件事：

1. 是否改了接口契约
2. 是否改了 SQL / 数据结构
3. 是否改了发布、回滚或 workflow 路径

只要任意一项为“是”，就不能只改代码而不核对对应文档。

## 推荐联读

- [docs/conventions/task-startup-checklist.md](task-startup-checklist.md)
- [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
- [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 维护规则

- 若新增一种高频变更类型，应优先在本文档补充触发条目。
- 若某个同步要求已经失效，应先修改本文档，再修改引用它的任务清单或评审文档。
- 若后续把某些同步动作做成自动提醒，也应保留本文作为人工规则来源。

## 一句话结论

后续真正开发时，不要靠记忆判断“这次还要改哪些文档”，直接按本文的触发矩阵执行。
