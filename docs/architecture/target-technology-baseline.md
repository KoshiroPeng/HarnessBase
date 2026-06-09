---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 当前真实技术基线，记录若依微服务后端、Vue 2 前端、SQL 脚本和自动化入口的事实约束。
---

# 技术基线

## 目标

本文档只记录当前仓库已经落地的真实技术事实，作为开发、测试、评审、发布和文档治理的共同基线。它回答的是“当前项目基于什么技术栈与版本运行”，而不是未来可能采用什么方案。

判断优先级如下：

1. 真实代码与配置
2. 本文档
3. 其他说明性文档

如果代码、构建配置与本文档冲突，必须先核对真实文件，再回写本文档。

## 后端基线

事实来源：

- [server/pom.xml](../../server/pom.xml)
- [server/README.md](../../server/README.md)
- [docs/architecture/code-map.md](code-map.md)

当前后端基线如下：

| 类别 | 当前事实 |
| --- | --- |
| 工程形态 | 若依微服务 |
| 根坐标 | `com.ruoyi:ruoyi:3.6.8` |
| Java | JDK 17 |
| 框架 | Spring Boot 4.0.3 |
| 微服务 | Spring Cloud 2025.1.0 |
| 注册配置中心 | Spring Cloud Alibaba / Nacos |
| 构建工具 | Maven 多模块 |
| 网关 | Spring Cloud Gateway |
| 认证 | JWT、认证中心、Spring Security 体系 |
| 持久化 | MyBatis、PageHelper、dynamic-datasource、Druid |
| 分布式事务 | Seata 相关公共模块已存在 |
| 缓存 | Redis |
| 接口契约 | SpringDoc + 仓库内参考文档 |

建议联读：

- [docs/architecture/overview.md](overview.md)
- [docs/architecture/code-map.md](code-map.md)
- [server/README.md](../../server/README.md)

当前顶层后端模块：

- [server/ruoyi-auth](../../server/ruoyi-auth)
- [server/ruoyi-gateway](../../server/ruoyi-gateway)
- [server/ruoyi-visual](../../server/ruoyi-visual)
- [server/ruoyi-modules](../../server/ruoyi-modules)
- [server/ruoyi-api](../../server/ruoyi-api)
- [server/ruoyi-common](../../server/ruoyi-common)

## 模块基线

当前真实模块分层如下：

| 层次 | 当前事实 |
| --- | --- |
| 认证入口 | `ruoyi-auth` |
| 网关入口 | `ruoyi-gateway` |
| 监控入口 | `ruoyi-visual/ruoyi-monitor` |
| 业务服务 | `ruoyi-modules/ruoyi-system`、`ruoyi-gen`、`ruoyi-job`、`ruoyi-file` |
| 服务间契约 | `ruoyi-api/ruoyi-api-system` |
| 公共能力 | `ruoyi-common-*` |

当前公共模块：

- `ruoyi-common-core`
- `ruoyi-common-datascope`
- `ruoyi-common-datasource`
- `ruoyi-common-log`
- `ruoyi-common-redis`
- `ruoyi-common-seata`
- `ruoyi-common-security`
- `ruoyi-common-sensitive`
- `ruoyi-common-swagger`

## 前端基线

事实来源：

- [web/package.json](../../web/package.json)
- [web/README.md](../../web/README.md)

当前前端基线如下：

| 类别 | 当前事实 |
| --- | --- |
| 框架 | Vue 2 |
| 语言 | JavaScript |
| 构建工具 | Vue CLI |
| UI 组件库 | Element UI |
| 状态管理 | Vuex |
| 路由 | Vue Router 3 |
| 包管理 | npm |
| 运行命令 | `npm run dev` |
| 生产构建 | `npm run build:prod` |

建议联读：

- [web/README.md](../../web/README.md)
- [docs/architecture/code-map.md](code-map.md)

当前前端目录主入口：

- [web/src/api](../../web/src/api)
- [web/src/views](../../web/src/views)
- [web/src/router](../../web/src/router)
- [web/src/store](../../web/src/store)

## 数据库与脚本基线

事实来源：

- [server/sql](../../server/sql)
- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)

当前数据库结构以 SQL 脚本维护为准，真实目录是 [server/sql](../../server/sql)。

当前脚本示例：

- [server/sql/quartz.sql](../../server/sql/quartz.sql)
- [server/sql/ry_20260321.sql](../../server/sql/ry_20260321.sql)
- [server/sql/ry_config_20260311.sql](../../server/sql/ry_config_20260311.sql)
- [server/sql/ry_seata_20210128.sql](../../server/sql/ry_seata_20210128.sql)

当前未发现 Flyway 已落地事实。涉及数据库变更时，默认要求：

1. 更新对应 SQL 脚本。
2. 更新 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)。
3. 如影响发布或回滚，同步更新 [deploy/release/README.md](../../deploy/release/README.md) 或相关发布材料。

## 自动化与 CI 基线

事实来源：

- [.github/workflows](../../.github/workflows)
- [.github/README.md](../../.github/README.md)

当前仓库已存在的 workflow：

- `agent-guardrails.yml`
- `bootstrap-remote-host.yml`
- `server-release.yml`
- `server-rollback.yml`

自动化治理主线以文档护栏、路径护栏和同步提醒为主，入口见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 和 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)。

当前已验证的本地执行链包括：

- `python .github/scripts/doc_guardrails.py`
- `server` 下 `mvn -B -DskipTests package`
- `web` 下 `npm.cmd install`
- `web` 下 `npm.cmd run build:prod`

## 开发约束

- 新增后端能力必须按当前微服务边界落位，不要再按单体后台目录组织。
- 新增前端能力必须按现有 `web/src/api`、`web/src/views`、`web/src/router`、`web/src/store` 结构扩展。
- 新增代码统一面向 JDK 17 和 Spring Boot 4 兼容面编写。
- 新增 Jakarta 相关能力时，禁止回退到旧 EE Web 命名空间。
- SQL 相关变更必须以 [server/sql](../../server/sql) 为事实目录。

## 与 Harness Engineering 的关系

Harness Engineering 在本仓库的落点不是再造一套架构，而是让这套真实基线可快速定位、可持续校验、可用于协作：

- 真实结构由 [docs/architecture/code-map.md](code-map.md) 固定
- 开发导航由 [docs/README.md](../README.md) 固定
- 规则护栏由 [AGENTS.md](../../AGENTS.md) 和 [docs/conventions/README.md](../conventions/README.md) 固定
- 自动化规则由 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 固定，实际入口由 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 和 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 固定
