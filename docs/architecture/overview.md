---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 系统架构概览

## 项目定位

HernessDemo 是一个面向中小企业的在线项目管理 Web 产品，核心目标是支撑项目、任务、成员、权限、搜索和计费等协作场景。

当前阶段的建设主线是 Web 产品 MVP，而不是继续扩展交付平台能力。发布、回滚、环境与可观测性材料仍然保留，但在当前阶段属于支撑层。

如果需要判断 Harness Engineering 在本项目里的正确落点，先阅读 [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)。

项目基线由根目录 [AGENTS.md](../../AGENTS.md) 定义：

- JDK 1.8
- Spring Boot 2.7.x
- Maven 3.6.3
- MySQL 5.7，字符集 `utf8mb4`
- MyBatis-Plus 3.5.x + Flyway
- JUnit 5

## 推荐目录结构

```text
.
├── AGENTS.md
├── README.md
├── docs/
├── server/
├── web/
└── deploy/
```

- `docs/`：架构、规范、设计、计划、参考与评审文档。
- `docs/design/`：产品功能设计与 Web MVP 路线图。
- `docs/README.md`：按任务组织的统一文档导航入口。
- `server/`：Spring Boot 后端服务。
- `web/`：前端应用。
- `deploy/`：发布、回滚、环境变量、可观测性等支撑材料。

## 后端包结构

后端 Spring Boot 工程放在 `server/` 下，标准包根路径为：

```text
server/src/main/java/com/example/app/
├── domain/
│   ├── model/
│   └── dto/
├── config/
├── mapper/
├── service/
├── controller/
└── infrastructure/
```

- `domain/model`：MyBatis-Plus Entity、Value Object 和领域模型。
- `domain/dto`：Request、Response、Command、Query。
- `config`：Spring 配置、属性绑定、扫描与基础设施装配。
- `mapper`：MyBatis-Plus Mapper 接口。
- `service`：业务逻辑、事务边界和领域规则编排。
- `controller`：REST Controller、参数校验和统一异常映射。
- `infrastructure`：ApiClient、日志、指标、安全、审计和外部系统适配器。

## 分层依赖

后端采用分层架构，依赖方向必须保持单向：

```text
domain -> config -> mapper -> service -> controller
```

各层职责如下：

- `domain`：领域模型、值对象、常量和核心业务语义。
- `config`：Spring 配置、Bean 装配和横切能力接入。
- `mapper`：数据库访问与 SQL 映射。
- `service`：业务用例与事务编排。
- `controller`：HTTP 输入输出适配。
- `infrastructure`：可注入的基础设施能力，不承载业务用例。

更细的依赖规则见 [docs/architecture/boundaries.md](boundaries.md)。

## 数据与迁移

数据库使用 MySQL 5.7，所有结构变更必须通过 Flyway migration 管理。业务代码、实体和 SQL 片段不能替代数据库迁移脚本。

当前 Flyway migration 目录入口：

- [server/src/main/resources/db/migration/](/D:/dev/workspace/Harness-demo/server/src/main/resources/db/migration/)

迁移脚本应满足：

- 可以在空库上顺序执行。
- 可以在测试环境重复验证。
- 不使用 MySQL 8.x 独有语法。
- 涉及兼容性风险时，在文档中说明回滚方案或补偿方案。

## 外部交互

外部系统调用必须通过 `ApiClient` 抽象接入，禁止在业务代码中裸用 `RestTemplate` 或 `HttpURLConnection`。

认证、日志、审计、telemetry 等横切能力必须通过 Spring 注入，不允许手动 `new` 实例化。

## 质量门禁

新增业务代码必须满足：

- 使用构造器注入，禁止字段级 `@Autowired`。
- 单个 `.java` 文件不超过 300 行。
- 单个方法不超过 50 行。
- 使用 SLF4J `Logger`，禁止 `System.out.println` 和 `e.printStackTrace()`。
- 有对应 JUnit 5 测试，行覆盖率不低于 80%。

## 文档维护规则

- API 变更同步更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- 错误码变更同步更新 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 模块边界、依赖方向或部署方式变化同步更新 [docs/architecture/README.md](README.md) 与对应架构文档。
- 发布、回滚、环境变量或上线验证变化同步更新 [deploy/release/README.md](../../deploy/release/README.md)。
- 监控、日志采集或本地观测方案变化同步更新 [deploy/observability/README.md](../../deploy/observability/README.md)。
- 新增功能设计优先放在 [docs/design/README.md](../design/README.md) 对应专题下，再进入 [docs/plans/README.md](../plans/README.md) 排期。

## 相关入口

- [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)
- [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)
- [docs/README.md](../README.md)
- [deploy/release/README.md](../../deploy/release/README.md)
