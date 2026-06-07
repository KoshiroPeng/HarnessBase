---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 模块边界和依赖规则

## 依赖方向

项目后端依赖方向固定为：

```text
domain -> config -> mapper -> service -> controller
```

该方向表示右侧可以依赖左侧已经暴露的能力，左侧不得反向依赖右侧。

## 分层职责

| 层级 | 主要职责 | 禁止事项 |
| --- | --- | --- |
| `domain` | 领域模型、枚举、值对象、领域常量 | 禁止依赖 Spring MVC、Mapper、Controller |
| `config` | Bean 装配、配置属性、横切能力接入 | 禁止承载业务流程 |
| `mapper` | MyBatis-Plus Mapper、SQL 映射、数据访问 | 禁止编排跨聚合业务流程 |
| `service` | 业务用例、事务边界、规则编排 | 禁止直接处理 HTTP 协议细节 |
| `controller` | HTTP 入参校验、响应封装、状态码映射 | 禁止写复杂业务逻辑 |
| `infrastructure` | ApiClient、日志、指标、安全、审计、外部系统适配器 | 禁止承载业务用例或被 Controller 绕过调用 |

## 允许的依赖

- `controller` 可以依赖 `service`。
- `service` 可以依赖 `mapper`、`domain` 和通过 Spring 注入的 `infrastructure` Bean。
- `mapper` 可以依赖 `domain` 中的数据模型或查询对象。
- `config` 可以装配跨层 Bean，但不承载业务分支。
- `domain` 应保持轻量，优先不依赖 Spring。
- `infrastructure` 可以依赖 `config` 暴露的配置属性和第三方 SDK，但对业务层只暴露稳定抽象。

## 禁止的依赖

- `domain` 禁止依赖 `controller`、`service`、`mapper`。
- `mapper` 禁止调用 `service`。
- `controller` 禁止直接调用 `mapper`。
- `controller` 禁止直接调用外部 ApiClient 或基础设施适配器。
- `infrastructure` 禁止反向调用 `controller` 或编排业务流程。
- 业务代码禁止用 `new` 创建 auth、log、telemetry 等横切对象。
- 业务代码禁止裸用 `RestTemplate` 或 `HttpURLConnection`。
- 禁止为了方便在任意层访问 Spring 上下文。

## 横切关注点

认证、授权、日志、审计、telemetry、外部 API 客户端都属于横切关注点，必须通过 Spring Bean 注入。

推荐方式：

- 配置类负责创建基础设施 Bean。
- Service 通过构造器注入使用。
- Controller 只负责调用业务用例，不直接拼装横切能力。

## 事务边界

事务边界应放在 `service` 层。

- 单个业务用例对应一个明确事务边界。
- 查询接口默认不创建写事务。
- Controller 不声明事务。
- Mapper 不承载事务编排。

## 新增模块检查清单

新增模块前必须确认：

- 模块职责能用一句话说清。
- 新模块没有破坏 `domain -> config -> mapper -> service -> controller` 依赖方向。
- 所需配置、数据迁移、API、错误码和测试文档已经同步。
- 新增 `.java` 文件和方法长度符合 `AGENTS.md`。
