---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 参考文档目录入口，汇总当前 API 摘要、响应码、错误消息与共享事实资料。
---

# 参考文档总览

## 目标

本目录沉淀 HernessDemo 的接口、响应码、错误消息和共享事实资料。当前系统的完整接口文档主要由 SpringDoc 从后端代码生成；本目录只维护仓库级摘要、响应模型和人工协作时必须核对的事实。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| API 摘要 | [docs/reference/api-spec.yaml](api-spec.yaml) |
| 响应码与错误消息 | [docs/reference/error-codes.md](error-codes.md) |
| SQL 脚本变更清单 | [docs/reference/sql-change-checklist.md](sql-change-checklist.md) |

## 事实来源

接口和错误模型必须优先核对这些真实入口：

- SpringDoc 配置：[server/ruoyi-admin/src/main/resources/application.yml](../../server/ruoyi-admin/src/main/resources/application.yml)、[SpringDocConfig.java](../../server/ruoyi-common/ruoyi-common-doc/src/main/java/org/dromara/common/doc/config/SpringDocConfig.java)
- 认证与验证码 Controller：[server/ruoyi-admin/src/main/java/org/dromara/web/controller](../../server/ruoyi-admin/src/main/java/org/dromara/web/controller)
- 后台业务 Controller：[server/ruoyi-modules](../../server/ruoyi-modules)
- 前端接口客户端：[web/src/api](../../web/src/api)
- 统一响应和分页响应：[R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/domain/R.java)、[TableDataInfo.java](../../server/ruoyi-common/ruoyi-common-mybatis/src/main/java/org/dromara/common/mybatis/core/page/TableDataInfo.java)
- 异常处理：[GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-web/src/main/java/org/dromara/common/web/handler/GlobalExceptionHandler.java)、[SaTokenExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-satoken/src/main/java/org/dromara/common/satoken/handler/SaTokenExceptionHandler.java)

## 使用建议

- 判断接口事实前，先看 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 修改接口前，核对 Controller、前端 [web/src/api](../../web/src/api) 和 SpringDoc 生成结果。
- 修改响应码、异常处理或 i18n 消息时，同步更新 [docs/reference/error-codes.md](error-codes.md)。
- 修改 SQL 相关行为时，同步检查 [server/script/sql](../../server/script/sql) 和 [docs/reference/sql-change-checklist.md](sql-change-checklist.md)。

## 已知差异

当前仅记录已经从真实代码核对出的接口差异，后续代码修复或删除前端残留时需要同步更新本节：

| 差异 | 当前事实 | 处理要求 |
| --- | --- | --- |
| `web/src/api/workflow/definition/index.ts` 中仍有 `/workflow/definition/definitionXml/{definitionId}` | 后端 [FlwDefinitionController.java](../../server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java) 当前没有该接口，真实可用入口是 `/workflow/definition/xmlString/{id}` | 后续只改文档时不得把 `definitionXml` 写入 API 摘要；代码修复任务应决定删除前端残留或补回后端接口 |

## 推荐阅读顺序

1. [docs/architecture/code-map.md](../architecture/code-map.md)
2. [docs/architecture/data-flow.md](../architecture/data-flow.md)
3. [docs/reference/api-spec.yaml](api-spec.yaml)
4. [docs/reference/error-codes.md](error-codes.md)
5. [docs/reference/sql-change-checklist.md](sql-change-checklist.md)

## 维护规则

- API 摘要不能写入不存在的业务接口。
- 若接口由 SpringDoc 动态生成且不在摘要中列全，应在文档中说明范围。
- 响应码文档必须对齐 `R`、`HttpStatus`、`GlobalExceptionHandler` 和 i18n 消息。
- 发现前后端接口不一致时，先记录在“已知差异”，不要为了让摘要完整而虚构接口。
- SQL 变更必须明确初始化脚本、升级脚本、多数据库兼容和发布验证影响。
