---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 后续待办，聚焦真实业务开发前仍需持续维护的结构护栏、文档同步、质量和发布事项。
---

# Backlog

## P0：真实结构护栏

- 持续防止 `.github/workflows` 回退引用旧目录、旧服务名或错误制品路径。
- 持续清理活跃文档中对旧单体结构、旧包名、旧 SQL 路径和旧前端技术栈的误用传播。
- 统一“仓库名、服务名、制品名、部署名”的命名语境，避免把历史名称混写成当前业务名称。
- 控制新增文档数量，优先维护现有入口，不为一次性过程新建长期文档。

## P1：文档事实同步

- 基于 [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md) 持续沉淀当前微服务项目的纵向切片模板。
- 持续校准 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)，确保与真实 Controller、网关入口和 [web/src/api](../../web/src/api) 保持一致。
- 持续维护 [docs/reference/error-codes.md](../reference/error-codes.md)，确保其与 `R`、`TableDataInfo`、异常处理器和 i18n 事实对齐。
- 持续维护 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)，确保其与 [server/sql](../../server/sql) 脚本体系一致。
- 如果再次发现前后端接口漂移，先在 [docs/reference/README.md](../reference/README.md) 记录事实，再按 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) 拆分修复任务。

## P2：代码与质量硬化

- 按风险补齐后端单元测试和集成测试。
- 结合当前前端工具链，补齐适合 Vue 2 / JavaScript 项目的前端测试基线说明和最小覆盖策略。
- 持续扫描直接跨层调用、绕过公共契约或绕过服务边界的实现。
- 持续收敛过长文件、过长方法、重复逻辑和日志输出不规范问题。

## P3：发布与运维入口

- 校准 GitHub Actions 中的构建、发布、回滚路径，使其与当前微服务结构一致。
- 核对发布材料中涉及的服务清单、启动顺序、回滚口径和 SQL 执行说明。
- 核对 [deploy/observability](../../deploy/observability) 中的内容是否与当前网关、认证、监控和业务服务结构一致。

## P4：Harness 自动化接入

- 维护已接入的 A01-A08 检查，规则口径统一以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。
- 持续校准 A04 历史事实误用扫描的命中词和忽略语境。
- 持续校准 A06-A08 API、错误码、SQL 和发布材料同步提醒的触发范围和提示文案。
- 如果新增自动化检查，先更新检查目录和实际脚本，不再新增阶段 brief。

## 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 涉及架构或边界变化的任务，必须同步 [docs/architecture/code-map.md](../architecture/code-map.md) 和相关入口文档。
- 涉及 API 的任务，必须同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 或明确说明由运行时文档覆盖。
- 涉及错误码、异常处理或 i18n 的任务，必须同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 涉及 SQL 的任务，必须同步 [server/sql](../../server/sql)、[docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 与相关发布材料。
