---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 模块边界和依赖规则，约束模块化单体下的内外层依赖方向与适配器边界。
---

# 模块边界和依赖规则

## 目标

本文档用于约束 ProjectPilot 在目标架构下的模块边界和依赖方向，避免仓库继续沿着旧脚手架结构自然扩张。

## 总体依赖方向

后端整体采用模块化单体，依赖只能从外向内流动：

```text
bootstrap -> adapter -> application -> domain -> shared
```

含义是：

- 左侧可以依赖右侧。
- 右侧不能反向依赖左侧。
- 共享基础能力是最稳定、最内层的公共依赖。

## 分层职责

| 层级 | 主要职责 | 禁止事项 |
| --- | --- | --- |
| `shared` | 稳定公共契约、基础类型、通用工具、统一错误模型 | 禁止承载具体业务流程 |
| `domain` | 领域模型、枚举、值对象、核心业务语义 | 禁止依赖 Web、数据库适配器和第三方 SDK |
| `application` | 业务用例、事务边界、规则编排、跨聚合协作 | 禁止直接处理 HTTP 协议细节 |
| `adapter` | Web 输入输出、持久化、第三方系统接入 | 禁止反向定义领域规则 |
| `bootstrap` | Spring Boot 启动、自动配置、Bean 装配、运行时拼装 | 禁止写具体业务规则 |

## 模块内结构

单个业务模块推荐形态：

```text
modules/project/
├── domain/
├── application/
└── adapter/
    ├── in/web/
    └── out/persistence/
```

推荐理解：

- `adapter/in/*` 负责接住外部输入。
- `application` 负责用例编排。
- `domain` 负责稳定业务语义。
- `adapter/out/*` 负责数据库和外围系统接出。

## 允许的依赖

- `bootstrap` 可以装配所有模块和基础设施 Bean。
- `adapter/in/web` 可以依赖同模块 `application`。
- `adapter/out/persistence` 可以依赖同模块 `domain` 与共享契约。
- `application` 可以依赖同模块 `domain`、`shared`，以及通过接口暴露的外部端口。
- `domain` 可以依赖 `shared` 中稳定的基础类型。
- `integration` 中的第三方适配器可以通过接口为 `application` 提供能力。

## 禁止的依赖

- `domain` 禁止依赖 `application`、`adapter`、`bootstrap`。
- `application` 禁止直接依赖其他模块的 `adapter` 或数据库表实现。
- `adapter/in/web` 禁止直接调用其他模块的持久化层。
- `adapter/out/persistence` 禁止编排业务流程。
- 模块之间禁止直接跨模块调用 `controller`、`mapper` 或 HTTP 接口作为内部耦合方式。
- 禁止在业务代码中直接创建第三方 SDK 客户端并绕过统一适配器。
- 禁止继续新增 `javax.*` 旧命名空间新代码。

## 跨模块协作

跨模块协作建议使用以下方式之一：

1. 共享应用服务接口。
2. 共享查询服务或稳定读模型。
3. 领域事件或应用事件。
4. 共享基础契约对象。

不建议使用：

1. 直接跨模块调用 `mapper`。
2. 直接依赖其他模块数据库表的实现细节。
3. 为了方便在模块间复制 Controller 风格接口。

## 外部系统边界

对象存储、支付、搜索、通知、短信、第三方登录等外围能力都视为外部系统，统一通过 adapter 或 `ApiClient` 抽象接入：

```text
application -> port/interface -> adapter/out/external -> third-party system
```

这样做的目的是：

- 避免第三方 SDK 污染核心业务模块。
- 让测试可以 mock 或 stub。
- 让未来替换供应商时影响范围可控。

## 事务边界

事务边界应放在 `application` 层。

- 单个业务用例对应一个明确事务边界。
- 查询接口默认不创建写事务。
- Web 适配层不声明事务。
- 持久化适配层不承载事务编排。

## 新增模块检查清单

新增模块前必须确认：

- 模块职责能用一句话说清。
- 新模块没有破坏 `bootstrap -> adapter -> application -> domain -> shared` 依赖方向。
- 所需配置、数据迁移、API、错误码和测试文档已经同步。
- 新增 `.java` 文件和方法长度符合 [AGENTS.md](../../AGENTS.md)。
