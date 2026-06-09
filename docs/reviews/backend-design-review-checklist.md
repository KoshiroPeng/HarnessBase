---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 后台设计评审清单，用于检查数据库、接口、服务边界与后端逻辑设计。
---

# 后台设计评审清单

## 评审重点

1. 数据库设计
2. 接口设计
3. 后端逻辑说明

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 是否按模板要求编写详细设计说明书？ |
| 必选 | 2 | 表结构设计是否有主键和合理索引？ |
| 必选 | 3 | 表名、字段名、索引名命名是否符合规范？ |
| 必选 | 4 | 是否存在冗余字段或一致性风险？ |
| 必选 | 5 | 字段类型和长度是否合理？ |
| 必选 | 6 | 新增表是否考虑历史数据处理方式？ |
| 必选 | 7 | 新增字段是否考虑历史数据处理方式？ |
| 必选 | 8 | 每个功能是否有明确接口设计？ |
| 必选 | 9 | 接口名、参数名是否规范且不冲突？ |
| 必选 | 10 | 请求方式是否合理？ |
| 必选 | 11 | 入参和出参描述是否清晰？ |
| 必选 | 12 | 返回结果数量和分页是否评估过？ |
| 必选 | 13 | 若涉及缓存、消息或 WebSocket，结构是否合理？ |
| 必选 | 14 | 是否复用已有公共方法或公共能力？ |
| 必选 | 15 | 接口逻辑是否考虑输入与结果错误检查？ |
| 必选 | 16 | 是否考虑外部调用失败、异常和响应时长？ |
| 必选 | 17 | 是否存在频繁操作数据库的情况？ |
| 必选 | 18 | 若涉及数据变动，是否考虑缓存更新逻辑？ |
| 必选 | 19 | 是否有现有接口或 SQL 被调整，调整内容是否说明清楚？ |

## 当前项目适配说明

- 表结构与 SQL 应以 [server/sql](../../server/sql) 的当前脚本体系为事实来源，并按 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 评估兼容性和回滚影响。
- 后端模块必须遵守 [docs/architecture/boundaries.md](../architecture/boundaries.md) 中的真实微服务边界。
- 设计涉及系统、监控、工具或认证能力时，应先核对 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) 和 [docs/design/feature-auth.md](../design/feature-auth.md)。
