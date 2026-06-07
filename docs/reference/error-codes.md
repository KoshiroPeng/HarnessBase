---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 错误码

错误码是 API 契约的一部分。新增、删除或变更错误码时，必须同步更新本文档和相关测试。

## 命名规则

错误码使用大写英文和下划线：

```text
MODULE_REASON
```

示例：

- `PROJECT_NOT_FOUND`
- `AUTH_TOKEN_EXPIRED`
- `BILLING_PLAN_NOT_FOUND`

## 通用错误码

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `COMMON_BAD_REQUEST` | 400 | 请求参数错误 |
| `COMMON_VALIDATION_FAILED` | 400 | 参数校验失败 |
| `COMMON_NOT_FOUND` | 404 | 通用资源不存在 |
| `COMMON_CONFLICT` | 409 | 通用资源冲突 |
| `COMMON_INTERNAL_ERROR` | 500 | 未预期系统错误 |

## 认证与授权

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `AUTH_REQUIRED` | 401 | 需要登录 |
| `AUTH_TOKEN_EXPIRED` | 401 | 登录状态已过期 |
| `AUTH_TOKEN_INVALID` | 401 | 登录凭证无效 |
| `AUTH_FORBIDDEN` | 403 | 权限不足 |

## 项目与任务

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `PROJECT_NOT_FOUND` | 404 | 项目不存在 |
| `PROJECT_NAME_DUPLICATED` | 409 | 项目名称重复 |
| `PROJECT_ACCESS_DENIED` | 403 | 无权访问项目 |
| `TASK_NOT_FOUND` | 404 | 任务不存在 |
| `TASK_STATUS_INVALID` | 422 | 任务状态不合法 |

## 搜索

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `SEARCH_QUERY_INVALID` | 400 | 搜索条件不合法 |
| `SEARCH_PAGE_SIZE_EXCEEDED` | 400 | 分页大小超过限制 |

## 计费

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `BILLING_PLAN_NOT_FOUND` | 404 | 套餐不存在 |
| `BILLING_SUBSCRIPTION_INACTIVE` | 422 | 订阅未激活 |
| `BILLING_INVOICE_NOT_FOUND` | 404 | 账单不存在 |
| `BILLING_PROVIDER_UNAVAILABLE` | 503 | 外部计费渠道不可用 |

## 维护要求

- 错误码一经对外发布，不应随意改名。
- 废弃错误码时先标记废弃，再在下一个大版本删除。
- 错误响应不得暴露堆栈、SQL 或敏感配置。
