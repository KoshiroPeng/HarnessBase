---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 错误处理规范，约束统一响应、异常处理、错误码文档和 i18n 消息的协作方式。
---

# 错误处理规范

## 当前响应模型

当前 HTTP API 主要使用统一响应对象 `R<T>`：

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {}
}
```

事实入口：

- [R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/domain/R.java)
- [TableDataInfo.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/com/ruoyi/common/core/web/page/TableDataInfo.java)
- [GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-security/src/main/java/com/ruoyi/common/security/handler/GlobalExceptionHandler.java)
- [docs/reference/error-codes.md](../reference/error-codes.md)

分页列表接口通常返回 `TableDataInfo`，字段为 `code`、`msg`、`rows`、`total`。

## 基本原则

- 业务错误应使用明确异常或统一失败响应表达。
- 系统异常由统一异常处理器转换成标准响应。
- 禁止吞掉异常后只打印日志。
- 禁止新增 `e.printStackTrace()`。
- 对外响应不暴露堆栈、SQL、密钥和内部实现细节。
- 修改错误提示时，同步检查 i18n 文案和 [docs/reference/error-codes.md](../reference/error-codes.md)。

## 状态码约定

详细映射以 [docs/reference/error-codes.md](../reference/error-codes.md) 为准。

常见语义：

| code | 含义 |
| --- | --- |
| `200` | 操作成功 |
| `400` | 请求参数或请求体错误 |
| `401` | 未授权或未登录 |
| `403` | 权限不足 |
| `404` | 资源不存在 |
| `409` | 资源冲突 |
| `500` | 系统错误 |

## Service 层规则

- Service 层负责业务语义，不直接处理 HTTP 协议细节。
- 事务内出现异常时，要优先保证数据一致性。
- 不要用返回 `null` 隐式表达业务失败。
- 批量操作要明确部分失败与全部失败语义。

## Controller 层规则

- Controller 负责接参与调用 Service。
- Controller 不写过多业务分支。
- 不要通过“捕获所有异常后返回成功”掩盖真实失败。
- 通用异常映射交给统一异常处理器。

## i18n 与错误消息

当前仓库已确认存在中文登录提示相关资源：

- 当前需以真实资源目录为准重新核对，不能沿用旧文档中的固定路径假设。

后续如果新增或扩展错误消息资源，必须：

1. 先核对真实资源文件位置。
2. 同步更新 [docs/reference/error-codes.md](../reference/error-codes.md) 中相关说明。
3. 在验证证据中说明本次是否只改中文，还是同步改了其他语种。

## 文档同步要求

涉及以下修改时，必须同步检查 [docs/reference/error-codes.md](../reference/error-codes.md)：

- `R.java`
- `TableDataInfo.java`
- `GlobalExceptionHandler.java`
- i18n 错误提示资源
- 统一认证失败、权限失败、参数失败处理逻辑
