---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 数据流说明，描述模块化单体目标结构下的请求、查询、写入、异常与外部集成流转。
---

# 数据流说明

## 请求处理主流程

典型 HTTP 请求按以下路径流转：

```text
Client
  -> Web Adapter
  -> Application Service
  -> Domain Rule
  -> Persistence Adapter
  -> MySQL 8
  -> Persistence Adapter
  -> Application Service
  -> Web Adapter
  -> Client
```

职责边界：

- Web Adapter 负责协议适配、参数校验和响应映射。
- Application Service 负责业务规则、事务和用例编排。
- Domain 承载领域模型、枚举和对象语义。
- Persistence Adapter 负责数据库访问。

## 写入数据流

写入类请求应遵循：

1. Web Adapter 接收请求对象并做基础校验。
2. Application Service 校验业务规则并开启事务。
3. Persistence Adapter 执行数据库写入。
4. Application Service 生成业务结果。
5. Web Adapter 将结果映射为统一响应。

数据库结构变更必须先由 Flyway migration 定义，再由业务代码使用。

## 查询数据流

查询类请求应遵循：

1. Web Adapter 接收分页、过滤和排序参数。
2. Application Service 进行权限、组织和业务条件约束。
3. Persistence Adapter 生成 MySQL 8 兼容查询。
4. Application Service 将持久化模型转换为业务响应。

禁止在 Web Adapter 中直接拼接查询条件或绕过应用层调用持久化层。

## 认证数据流

认证与授权能力属于横切关注点，应通过 Spring Boot 3 体系下的过滤器、拦截器或安全上下文进入业务流程。

```text
Request
  -> Auth Filter / Interceptor
  -> Security Context
  -> Web Adapter
  -> Application Service 权限校验
```

Web Adapter 不应自行解析复杂认证逻辑。Application Service 在执行业务用例时必须基于当前用户、组织或角色做权限校验。

## 外部 API 数据流

外部 API 调用统一通过 adapter 或 `ApiClient` 抽象：

```text
Application Service
  -> External Port
  -> External Adapter
  -> External System
```

禁止在 Web Adapter、Application Service 或 Domain 中裸用 HTTP 客户端或直接 new 第三方 SDK。

## 错误数据流

异常应统一映射为错误响应：

```text
Business Exception
  -> Global Exception Handler
  -> Error Code
  -> HTTP Response
```

错误码登记在 [docs/reference/error-codes.md](../reference/error-codes.md)。新增错误码时必须同步文档。

## 日志与审计数据流

日志使用 SLF4J `Logger`。审计、telemetry、cache 等能力通过 Spring Bean 注入。

日志中不得输出密码、令牌、身份证号、银行卡号或完整密钥。需要定位问题时使用请求 ID、用户 ID、项目 ID 等可控字段。
