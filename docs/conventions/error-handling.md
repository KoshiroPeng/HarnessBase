---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 错误处理规范

## 基本原则

- 业务错误使用明确的业务异常表达。
- 系统异常由统一异常处理器转换为标准错误响应。
- 禁止吞掉异常后只打印日志。
- 禁止使用 `e.printStackTrace()`。
- 对外响应不暴露堆栈、SQL、密钥或内部实现细节。

## 错误响应格式

HTTP API 使用统一错误响应：

```json
{
  "code": "PROJECT_NOT_FOUND",
  "message": "项目不存在",
  "traceId": "req-20260607-000001"
}
```

字段说明：

- `code`: 稳定错误码，登记在 `docs/reference/error-codes.md`。
- `message`: 面向用户或调用方的简短说明。
- `traceId`: 请求追踪 ID，用于排查问题。

## 异常分类

| 分类 | 场景 | HTTP 状态 |
| --- | --- | --- |
| 参数错误 | 请求字段缺失、格式不合法 | 400 |
| 认证失败 | 未登录、令牌无效 | 401 |
| 权限不足 | 无权访问资源 | 403 |
| 资源不存在 | 项目、任务、成员不存在 | 404 |
| 冲突错误 | 重复创建、状态冲突 | 409 |
| 业务规则错误 | 不满足业务约束 | 422 |
| 系统错误 | 未预期异常 | 500 |

## Service 层规则

- Service 层抛出业务异常，不直接构造 HTTP 响应。
- 业务异常必须携带错误码。
- 事务内出现异常时，应保证数据一致性。
- 不要用返回 `null` 表示业务失败。

## Controller 层规则

- Controller 负责参数校验和调用 Service。
- Controller 不写复杂业务分支。
- Controller 不直接捕获所有异常后返回普通成功响应。
- 异常到响应的映射交给统一异常处理器。

## 错误码维护

新增、删除或变更错误码时，必须同步更新 `docs/reference/error-codes.md`。

错误码命名建议：

```text
MODULE_REASON
```

示例：

- `PROJECT_NOT_FOUND`
- `TASK_STATUS_INVALID`
- `AUTH_TOKEN_EXPIRED`
