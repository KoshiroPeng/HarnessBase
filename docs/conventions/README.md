---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 编码规范总览

本目录记录 HernessDemo 的工程规范。根规则以 `AGENTS.md` 为准，本文档负责把日常开发细则拆分到可维护的位置。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 命名规范 | [docs/conventions/naming.md](naming.md) |
| 错误处理 | [docs/conventions/error-handling.md](error-handling.md) |
| 测试规范 | [docs/conventions/testing.md](testing.md) |
| 日志规范 | [docs/conventions/logging.md](logging.md) |
| 文件规模 | [docs/conventions/file-size.md](file-size.md) |
| 方法规模 | [docs/conventions/method-size.md](method-size.md) |
| 文档链接规范 | [docs/conventions/document-links.md](document-links.md) |
| 交付模型 | [docs/delivery/delivery-model.md](../delivery/delivery-model.md) |
| 环境治理 | [docs/delivery/environments.md](../delivery/environments.md) |
| 流水线设计 | [docs/delivery/pipelines.md](../delivery/pipelines.md) |
| 部署策略 | [docs/delivery/deployment-strategies.md](../delivery/deployment-strategies.md) |
| 发布验证 | [docs/operations/release-verification.md](../operations/release-verification.md) |
| 配置与密钥 | [docs/operations/config-and-secrets.md](../operations/config-and-secrets.md) |
| 发布治理 | [docs/governance/release-governance.md](../governance/release-governance.md) |
| 评审清单总览 | [docs/reviews/README.md](../reviews/README.md) |
| API 规范 | [docs/reference/api-spec.yaml](../reference/api-spec.yaml) |
| 错误码 | [docs/reference/error-codes.md](../reference/error-codes.md) |

## 技术基线

- Java 使用 JDK 1.8，禁止 Java 9+ 语法。
- Spring Boot 使用 2.7.x。
- Maven 使用 3.6.3。
- MySQL 使用 5.7，字符集 `utf8mb4`。
- 持久化使用 MyBatis-Plus 3.5.x + Flyway。
- 测试使用 JUnit 5。

## 基本原则

- 优先遵循项目已有模式。
- 不为局部需求引入新框架或全局抽象。
- 依赖方向保持 `domain -> config -> mapper -> service -> controller`。
- 新增业务代码必须同步测试。
- 涉及 API、错误码、数据库结构或架构边界的变更必须同步文档。

## 代码规模

- 单个 `.java` 文件不超过 300 行。
- 单个方法不超过 50 行。
- 超限前优先拆分职责，而不是通过格式压缩规避限制。

## 注入规范

- 禁止字段级 `@Autowired`。
- 必须使用构造器注入。
- 推荐 Lombok `@RequiredArgsConstructor`。
- auth、log、telemetry、外部 API 客户端等横切能力必须通过 Spring 注入。

## 提交前自检

提交前至少确认：

- 代码可以编译。
- 新增或变更业务逻辑有对应测试。
- 没有 `System.out.println` 或 `e.printStackTrace()`。
- 没有裸用 `RestTemplate` 或 `HttpURLConnection`。
- 相关文档已经同步更新。

如果需要按任务查看“开发前必读 + 开发后自检 + 评审清单”，统一入口见 [docs/README.md](../README.md)。
