---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 命名规范

## 通用原则

- 名称使用业务语义，避免无意义缩写。
- 同一概念在代码、数据库、API 和文档中使用同一术语。
- 英文命名保持简洁，但不要牺牲可读性。
- 布尔变量使用 `is`、`has`、`can`、`should` 等前缀表达语义。

## Java 包名

包名使用小写英文，按职责分层组织：

```text
org.dromara.callcenter.domain
org.dromara.callcenter.adapter
org.dromara.callcenter.service
org.dromara.callcenter.mapper
org.dromara.callcenter.controller
```

实际根包名以后端 Maven 项目为准，但分层命名必须保持清晰。

## Java 类名

| 类型 | 命名示例 |
| --- | --- |
| Controller | `AgentStatusController` |
| Service 接口 | `CallEventService` |
| Service 实现 | `CallEventServiceImpl` |
| Mapper | `CallRecordMapper` |
| 配置类 | `SecurityConfig` |
| 请求对象 | `ReceiveCallEventRequest` |
| 响应对象 | `AgentStatusResponse` |
| 查询对象 | `ScreenPopQuery` |
| 异常类 | `AgentNotFoundException` |

## 方法名

- 查询单个对象：`getAgentStatus`、`findCallRecord`。
- 查询列表：`listCallRecords`、`searchCustomersForScreenPop`。
- 创建：`createCallSummary`。
- 更新：`updateAgentStatus`。
- 删除或归档：`archiveCallRecord`。
- 校验：`validateAgentAccess`。

不要使用 `doSomething`、`handleData`、`processInfo` 等含义模糊的方法名。

## 数据库命名

- 表名使用小写下划线，例如 `call_record`。
- 字段名使用小写下划线，例如 `created_at`。
- 主键字段默认使用 `id`。
- 创建时间使用 `created_at`。
- 更新时间使用 `updated_at`。
- 逻辑删除字段使用 `deleted_at` 或 `deleted`，具体方案在落地时统一。

SQL 语法必须对齐当前部署数据库版本和客户现场约束。

## API 命名

- URL 使用小写连字符或小写路径段。
- 资源名使用复数或清晰业务路径，例如 `/agents`、`/calls`。
- 请求和响应字段使用 `camelCase`。
- 分页参数推荐使用 `page`、`pageSize`。

示例：

```text
GET /api/v1/agents/{agentId}/status
POST /api/v1/calls/events
GET /api/v1/screen-pop
```

## 测试命名

测试类以 `Test` 结尾，例如 `CallEventServiceTest`。

测试方法命名应说明场景和期望：

```text
receiveCallEvent_shouldAcceptEvent_whenPayloadValid
updateAgentStatus_shouldRejectTransition_whenTransitionInvalid
```
