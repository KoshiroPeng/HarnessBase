---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase SQL 脚本变更模板与验证清单，用于约束初始化脚本、升级脚本、多数据库兼容和发布检查。
---

# SQL 脚本变更清单

## 目标

本文档用于约束 HarnessBase 的数据库脚本变更。当前仓库没有 Flyway migration，数据库结构事实入口是 [server/script/sql](../../server/script/sql)，因此任何表结构、初始化数据、字典、菜单、权限和工作流数据变更，都必须明确同步初始化脚本和升级脚本。

## 当前脚本入口

| 脚本范围 | 路径 | 说明 |
| --- | --- | --- |
| MySQL 初始化 | [server/script/sql/ry_vue_5.X.sql](../../server/script/sql/ry_vue_5.X.sql)、[server/script/sql/ry_job.sql](../../server/script/sql/ry_job.sql)、[server/script/sql/ry_workflow.sql](../../server/script/sql/ry_workflow.sql) | 默认优先核对的主脚本 |
| MySQL 升级 | [server/script/sql/update](../../server/script/sql/update) | 版本升级脚本 |
| Oracle | [server/script/sql/oracle](../../server/script/sql/oracle)、[server/script/sql/update/oracle](../../server/script/sql/update/oracle) | Oracle 初始化与升级脚本 |
| PostgreSQL | [server/script/sql/postgres](../../server/script/sql/postgres)、[server/script/sql/update/postgres](../../server/script/sql/update/postgres) | PostgreSQL 初始化与升级脚本 |
| SQL Server | [server/script/sql/sqlserver](../../server/script/sql/sqlserver)、[server/script/sql/update/sqlserver](../../server/script/sql/update/sqlserver) | SQL Server 初始化与升级脚本 |

## 变更模板

每次 SQL 变更至少记录以下信息，可写入 PR 描述、评审记录或验证证据：

| 字段 | 内容 |
| --- | --- |
| 变更目标 | 新增表、改字段、改索引、改菜单、改字典、改初始化数据或修复历史数据 |
| 影响模块 | 对应 `ruoyi-system`、`ruoyi-generator`、`ruoyi-job`、`ruoyi-workflow`、`ruoyi-demo` 或公共能力 |
| 脚本范围 | 初始化脚本、`update/` 升级脚本、多数据库兼容脚本 |
| 向后兼容 | 旧数据是否可直接升级，是否需要补默认值或数据修复 |
| 回滚方式 | 是否可回滚，回滚时是否保留数据，是否需要人工确认 |
| 联动文档 | API、错误码、发布清单、数据流、设计或测试文档是否需要同步 |
| 验证方式 | 语法检查、空库初始化、旧库升级、关键查询、应用启动或业务探针 |

## 发布前检查

- [ ] 已确认变更属于哪个数据库类型，默认优先核对 MySQL。
- [ ] 初始化脚本已同步，空库部署不会缺表、缺字段、缺菜单或缺字典。
- [ ] `update/` 升级脚本已同步，旧环境升级路径明确。
- [ ] 多数据库兼容脚本是否受影响已判断；受影响时同步对应目录。
- [ ] 表名、字段名、索引名符合 [docs/conventions/naming.md](../conventions/naming.md)。
- [ ] 新增字段对历史数据有默认值、可空策略或数据补齐策略。
- [ ] 删除字段、表、菜单或字典前已确认没有前端页面、后端 Mapper、SQL XML 或导出模板继续引用。
- [ ] 涉及接口、响应码、发布、观测或回滚时，相关文档已同步。

## 验证建议

按风险从低到高选择验证方式：

| 场景 | 建议验证 |
| --- | --- |
| 只改菜单、字典或初始化配置 | SQL 语法检查 + 页面菜单或字典读取验证 |
| 新增字段或索引 | 初始化脚本检查 + 升级脚本检查 + 关键查询验证 |
| 新增表或改表关系 | 空库初始化 + 旧库升级 + 对应 Service/Mapper 链路验证 |
| 改工作流、定时任务或租户基础数据 | 对应模块启动检查 + 最小业务探针 |
| 删除或重命名结构 | 引用扫描 + 回滚方案 + 发布窗口人工确认 |

## 非目标

- 本文档不是 Flyway 引入方案。
- 不要求每次 SQL 变更都支持所有数据库，但必须明确是否影响 Oracle、PostgreSQL、SQL Server 兼容脚本。
- 不用本文档替代真实数据库验证；它只定义变更时必须说明和检查的内容。

## 维护规则

- 新增数据库脚本目录、版本升级策略或支持的数据库类型时，同步更新本文档。
- 如果后续引入 Flyway 或其他迁移工具，必须先更新 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)、[docs/architecture/data-flow.md](../architecture/data-flow.md) 和本文档。
- 发布清单中涉及 SQL 的检查项应与本文保持一致。
