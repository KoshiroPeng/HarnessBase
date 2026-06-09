---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 模块边界和依赖规则，约束当前若依微服务结构下的服务拆分、前端落位与依赖方式。
---

# 模块边界和依赖规则

## 目标

本文档约束 HarnessBase 在当前若依微服务结构下如何继续扩展，避免文档写一套、代码走另一套。

## 当前模块边界

```text
ruoyi-gateway
  -> 路由到 ruoyi-auth / ruoyi-modules/* / ruoyi-visual/*
ruoyi-auth
  -> ruoyi-api/*
  -> ruoyi-common/*
ruoyi-modules/*
  -> ruoyi-api/*
  -> ruoyi-common/*
ruoyi-visual/*
  -> ruoyi-common/*
web/src/views
  -> web/src/api
  -> 后端 HTTP API
```

| 层级 | 当前路径 | 主要职责 |
| --- | --- | --- |
| 网关入口 | [server/ruoyi-gateway](../../server/ruoyi-gateway) | 网关路由、统一过滤、入口拦截 |
| 认证中心 | [server/ruoyi-auth](../../server/ruoyi-auth) | 登录、鉴权、认证相关流程 |
| 远程接口 | [server/ruoyi-api](../../server/ruoyi-api) | 服务间接口定义和共享模型 |
| 公共能力 | [server/ruoyi-common](../../server/ruoyi-common) | core、redis、security、swagger、datasource、log 等 |
| 业务服务 | [server/ruoyi-modules](../../server/ruoyi-modules) | `system`、`gen`、`job`、`file` |
| 可视化监控 | [server/ruoyi-visual](../../server/ruoyi-visual) | 监控与可视化服务 |
| 前端接口 | [web/src/api](../../web/src/api) | 按功能域封装接口请求 |
| 前端页面 | [web/src/views](../../web/src/views) | 按 `system`、`monitor`、`tool` 等功能域组织页面 |

## 新增后端能力放置规则

- 新增网关入口、过滤、统一流量逻辑，优先评估是否属于 `ruoyi-gateway`。
- 新增登录、认证、令牌、密码、验证码等能力，优先放入 `ruoyi-auth`。
- 新增系统管理类业务能力，优先评估是否属于 `ruoyi-system`。
- 新增代码生成能力，优先放入 `ruoyi-gen`。
- 新增任务调度能力，优先放入 `ruoyi-job`。
- 新增文件管理或对象存储接入能力，优先放入 `ruoyi-file`。
- 新增通用基础设施能力，优先放入对应 `ruoyi-common-*`；没有合适模块时再新增 common 子模块。
- 新增服务间共享 DTO、Feign 接口或远程契约，优先放入 `ruoyi-api-*`。
- 新增独立监控或可视化能力，才考虑 `ruoyi-visual/*`。

## 新增前端能力放置规则

- API 请求封装放在 [web/src/api](../../web/src/api) 对应功能域下。
- 页面放在 [web/src/views](../../web/src/views) 对应功能域下。
- 跨页面共享组件放在 [web/src/components](../../web/src/components)。
- 路由接入按现有 [web/src/router](../../web/src/router) 模式处理。
- 状态管理按现有 [web/src/store](../../web/src/store) Vuex 模块处理。

## 禁止事项

- 禁止把旧单体结构或不存在的目标结构当成当前落地事实。
- 禁止在 Controller 中堆叠复杂业务规则。
- 禁止跨服务直接复制对方内部实现替代远程接口协作。
- 禁止业务代码散落第三方 SDK 初始化逻辑；应进入 common、adapter 或明确封装类。
- 禁止新增 `javax.*` 命名空间。
- 禁止新增字段级 `@Autowired`。

## 数据边界

- 当前数据库结构由 [server/sql](../../server/sql) 维护。
- 表结构调整必须同步对应 SQL 脚本。
- Mapper、实体和 XML 不能替代数据库脚本。
- 多数据源能力通过 dynamic-datasource 和既有配置接入，不能在业务代码中临时创建裸数据源。

## 新增模块检查清单

新增模块前必须确认：

- 是否已有 `ruoyi-common-*`、`ruoyi-api-*` 或 `ruoyi-modules/*` 能承载该能力。
- 是否需要同步前端 [web/src/api](../../web/src/api) 与 [web/src/views](../../web/src/views)。
- 是否需要同步 SQL 脚本、API 文档、响应码文档和测试。
- 是否会影响 [docs/architecture/code-map.md](code-map.md)。
