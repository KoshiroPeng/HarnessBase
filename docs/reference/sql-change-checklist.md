---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase SQL 脚本变更模板与验证清单，用于约束当前 SQL 目录、兼容性与发布检查。
---

# SQL 脚本变更清单

## 目标

本文档用于约束 HarnessBase 的数据库脚本变更。当前仓库没有 Flyway migration，数据库结构事实入口是 [server/sql](../../server/sql)，因此任何表结构、初始化数据、字典、菜单或权限数据变更，都必须明确同步脚本与验证说明。

## 当前脚本入口

| 脚本范围 | 路径 | 说明 |
| --- | --- | --- |
| Quartz | [server/sql/quartz.sql](../../server/sql/quartz.sql) | 调度相关脚本 |
| 主业务脚本 | [server/sql/ry_20260321.sql](../../server/sql/ry_20260321.sql) | 当前主业务脚本 |
| 配置脚本 | [server/sql/ry_config_20260311.sql](../../server/sql/ry_config_20260311.sql) | 配置相关脚本 |
| Seata 脚本 | [server/sql/ry_seata_20210128.sql](../../server/sql/ry_seata_20210128.sql) | Seata 相关脚本 |

## 变更模板

每次 SQL 变更至少记录以下信息：

| 字段 | 内容 |
| --- | --- |
| 变更目标 | 新增表、改字段、改索引、改菜单、改字典或修复初始化数据 |
| 影响模块 | 对应 `ruoyi-system`、`ruoyi-gen`、`ruoyi-job`、`ruoyi-file` 或公共能力 |
| 脚本范围 | 变更了哪些脚本 |
| 向后兼容 | 历史数据是否可直接升级，是否需要补默认值或数据修复 |
| 回滚方式 | 是否可回滚，是否需要人工确认 |
| 联动文档 | API、错误码、发布清单、数据流或设计文档是否需要同步 |
| 验证方式 | 语法检查、空库初始化、旧库升级、关键查询或应用启动验证 |

## 发布前检查

- [ ] 已确认当前变更对应的真实 SQL 脚本
- [ ] 表名、字段名、索引名符合命名规范
- [ ] 新增字段对历史数据有兼容策略
- [ ] 涉及删除或重命名前，已确认没有代码或页面继续引用
- [ ] 涉及接口、响应码、发布或回滚时，相关文档已同步

## 维护规则

- 新增脚本目录、升级策略或支持的数据类型变化时，同步更新本文档。
- 如果后续引入 Flyway 或其他迁移工具，必须先更新 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)、[docs/architecture/data-flow.md](../architecture/data-flow.md) 和本文档。
