---
last_updated: 2026-06-08
status: draft
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

- `AGENT_NOT_FOUND`
- `CALL_EVENT_DUPLICATED`
- `CTI_ADAPTER_UNAVAILABLE`

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

## 坐席

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `AGENT_NOT_FOUND` | 404 | 坐席不存在 |
| `AGENT_STATUS_INVALID` | 422 | 坐席状态不合法 |
| `AGENT_STATUS_TRANSITION_DENIED` | 422 | 坐席状态流转不允许 |

## 通话与 CTI

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `CALL_NOT_FOUND` | 404 | 通话不存在 |
| `CALL_EVENT_INVALID` | 400 | 通话事件格式不合法 |
| `CALL_EVENT_DUPLICATED` | 409 | 通话事件重复 |
| `CTI_ADAPTER_UNAVAILABLE` | 503 | CTI 适配器不可用 |
| `CTI_EVENT_UNSUPPORTED` | 422 | CTI 事件类型不支持 |

## 来电弹屏

| 错误码 | HTTP 状态 | 说明 |
| --- | --- | --- |
| `SCREEN_POP_QUERY_INVALID` | 400 | 弹屏查询条件不合法 |
| `SCREEN_POP_CUSTOMER_NOT_FOUND` | 404 | 未匹配到客户资料 |
| `SCREEN_POP_SOURCE_UNAVAILABLE` | 503 | 客户资料来源不可用 |

## 维护要求

- 错误码一经对外发布，不应随意改名。
- 废弃错误码时先标记废弃，再在下一个大版本删除。
- 错误响应不得暴露堆栈、SQL 或敏感配置。
