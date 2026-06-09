---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 任务启动清单，帮助业务扩展、开发、评审、测试、发布和文档治理任务快速找到联读文档。
---

# 任务启动清单

## 目标

本文档提供“开始做事前先读什么、动手后要补什么、结束前怎么自检”的最小启动路径，并把高频任务直接对应到真实模块、规范和验证入口。

## 通用起步顺序

无论当前任务是什么，建议先完成下面步骤：

1. 阅读 [AGENTS.md](../../AGENTS.md)
2. 阅读 [docs/README.md](../README.md)
3. 阅读 [docs/architecture/code-map.md](../architecture/code-map.md)
4. 阅读 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
5. 根据任务类型跳到下方对应清单

## 文档阅读停止条件

阅读任务文档时，满足以下条件后应停止追踪更多导航链接，进入代码、配置、SQL 或文档实施：

- 已经明确本次任务要改哪些目录或文件。
- 已经明确是否涉及后端、前端、SQL、API、权限、测试、发布或观测。
- 已经明确本次验证方式和未覆盖风险记录位置。

## 新增业务功能

开始前建议依次阅读：

1. [docs/architecture/business-extension-baseline.md#仓库影响图](../architecture/business-extension-baseline.md#仓库影响图)
2. [docs/architecture/boundaries.md](../architecture/boundaries.md)
3. [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
4. [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
5. [docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md)
6. [docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md)

动手时重点确认：

- 是否已经写出最小仓库影响图，并能回到真实文件验证。
- 当前功能是扩展现有功能域，还是需要新增正式业务模块。
- 后端 Controller、Service、Mapper、SQL 和权限注解是否形成闭环。
- 前端 API、页面、路由、菜单、按钮权限和后端契约是否一致。
- 是否需要同步 API 摘要、错误码、SQL 脚本、测试、发布材料和验证证据。

## 开发后端代码

开始前建议依次阅读：

1. [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)
2. [docs/architecture/boundaries.md](../architecture/boundaries.md)
3. [docs/architecture/data-flow.md](../architecture/data-flow.md)
4. [docs/conventions/README.md](README.md)
5. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
6. [docs/conventions/testing.md](testing.md)

动手时重点确认：

- 当前改动属于 `ruoyi-gateway`、`ruoyi-auth`、`ruoyi-api-*`、`ruoyi-common-*`、`ruoyi-modules/*` 还是 `ruoyi-visual/*`。
- 是否已经明确后端改动对应的前端、SQL、API、发布或验证影响。
- 是否涉及 API、响应码、SQL 脚本、菜单权限或发布影响。
- 是否新增 `javax.*`、字段级 `@Autowired`、`System.out.println` 或 `e.printStackTrace()`。
- 是否需要同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 或 [docs/reference/error-codes.md](../reference/error-codes.md)。

## 开发前端代码

开始前建议依次阅读：

1. [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)
2. [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)
3. [docs/conventions/README.md](README.md)
4. [docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md)
5. [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
6. [docs/conventions/testing.md](testing.md)

动手时重点确认：

- API 封装是否放在 [web/src/api](../../web/src/api) 对应功能域。
- 页面是否放在 [web/src/views](../../web/src/views) 对应功能域。
- 是否已经明确前端改动对应的后端 API、权限、菜单、store 或验证影响。
- 路由、权限、store 和后端菜单配置是否同步。
- 是否需要同步检查 [web/README.md](../../web/README.md) 中的目录职责和运行命令。

## 修复前后端接口差异

开始前建议依次阅读：

1. [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)
2. [docs/reference/README.md](../reference/README.md)
3. [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
4. [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
5. [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
6. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)

动手时重点确认：

- 先判断差异来自前端残留、后端缺口还是产品需求变化。
- 不要把后端不存在的前端残留路径写入 API 摘要。
- 如果删除前端残留，同步检查页面调用点和构建。
- 如果补齐后端接口，同步检查权限、审计日志、测试、API 摘要和发布风险。

## 数据库脚本变更

开始前建议依次阅读：

1. [docs/architecture/data-flow.md](../architecture/data-flow.md)
2. [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
3. [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
4. [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)

动手时重点确认：

- 当前变更是否更新对应 SQL 脚本。
- 是否影响发布、回滚或数据修复说明。

## 做需求或设计评审

开始前建议依次阅读：

1. [docs/design/README.md](../design/README.md)
2. [docs/reviews/requirement-review-checklist.md](../reviews/requirement-review-checklist.md)
3. [docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md)
4. [docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md)

## 做代码评审或开发后自检

开始前建议依次阅读：

1. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
2. [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
3. [docs/conventions/naming.md](naming.md)
4. [docs/conventions/error-handling.md](error-handling.md)
5. [docs/conventions/logging.md](logging.md)
6. [docs/conventions/testing.md](testing.md)

## 做测试设计、补测试或测试用例评审

开始前建议依次阅读：

1. [docs/conventions/testing.md](testing.md)
2. [docs/reviews/testcase-review-checklist.md](../reviews/testcase-review-checklist.md)
3. [docs/reference/error-codes.md](../reference/error-codes.md)

## 做发布回滚或上线验证

开始前建议依次阅读：

1. [deploy/release/README.md](../../deploy/release/README.md)
2. [deploy/release/environment-variable-template.md](../../deploy/release/environment-variable-template.md)
3. [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
4. [deploy/observability/README.md](../../deploy/observability/README.md)

执行前重点确认：

- workflow 是否仍指向真实 [server](../../server)、[web](../../web) 与 [deploy](../../deploy) 路径。
- 制品路径是否与当前实际构建产物一致。
- API、响应码、SQL 和环境变量是否已同步。
- 是否需要同步回写 [docs/plans/backlog.md](../plans/backlog.md) 或验证证据模板。
