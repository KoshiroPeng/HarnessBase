---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 响应码与错误消息文档，统一说明 R、TableDataInfo、HttpStatus 与异常处理语义。
---

# 响应码与错误消息

## 当前模型

当前系统的普通 JSON API 主要使用 `R<T>` 作为统一响应结构。

事实入口：

- [R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/domain/R.java)
- [HttpStatus.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/constant/HttpStatus.java)
- [TableDataInfo.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/web/page/TableDataInfo.java)
- [GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-security/src/main/java/com/ruoyi/common/security/handler/GlobalExceptionHandler.java)

## 通用 code

| code | 语义 |
| --- | --- |
| `200` | 成功 |
| `400` | 请求错误 |
| `401` | 未授权 |
| `403` | 权限不足 |
| `404` | 不存在 |
| `500` | 失败或系统错误 |

## 维护要求

- 新增或修改错误语义时，同步更新本文档。
- 不要把旧单体里的错误码或历史业务错误码当成当前事实。
