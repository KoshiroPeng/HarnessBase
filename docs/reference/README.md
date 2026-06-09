---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 参考文档目录入口，汇总当前 API 摘要、响应码、错误消息与共享事实材料。
---

# 参考文档总览

## 目标

本目录沉淀 HarnessBase 的接口、响应码、错误消息和共享事实材料。当前系统的完整接口文档主要由 SpringDoc 从后端代码生成；本目录只维护仓库级摘要、响应模型和人工协作时必须核对的事实。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| API 摘要 | [docs/reference/api-spec.yaml](api-spec.yaml) |
| 响应码与错误消息 | [docs/reference/error-codes.md](error-codes.md) |
| SQL 脚本变更清单 | [docs/reference/sql-change-checklist.md](sql-change-checklist.md) |

## 事实来源

- 网关与认证入口：[server/ruoyi-gateway](../../server/ruoyi-gateway)、[server/ruoyi-auth](../../server/ruoyi-auth)
- 后台业务 Controller：[server/ruoyi-modules](../../server/ruoyi-modules)
- 前端接口客户端：[web/src/api](../../web/src/api)
- SQL 脚本：[server/sql](../../server/sql)

## 使用建议

- 判断接口事实前，先看 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 判断某个接口属于哪个服务时，补看 [server/README.md](../../server/README.md)。
- 修改接口前，核对 Controller、前端 `web/src/api` 和运行时文档生成结果。
- 修改响应码、异常处理或 i18n 消息时，同步更新 [docs/reference/error-codes.md](error-codes.md)。
- 修改 SQL 相关行为时，同步检查 [server/sql](../../server/sql) 和 [docs/reference/sql-change-checklist.md](sql-change-checklist.md)。

## 维护规则

- API 摘要不能写入不存在的业务接口。
- 如果接口由 SpringDoc 动态生成且不在摘要中列入，应在文档中说明范围。
- 响应码文档必须对齐当前统一响应和异常处理实现。
