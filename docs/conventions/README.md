---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 编码规范

本目录只记录代码层面的工程规范。根规则以 [AGENTS.md](../../AGENTS.md) 为准，交付、运维、治理和评审入口统一从 [docs/README.md](../README.md) 进入。

## 当前文档

| 主题 | 文档 |
| --- | --- |
| 命名 | [naming.md](naming.md) |
| 错误处理 | [error-handling.md](error-handling.md) |
| 测试 | [testing.md](testing.md) |
| 日志 | [logging.md](logging.md) |
| 文件规模 | [file-size.md](file-size.md) |
| 方法规模 | [method-size.md](method-size.md) |
| 文档链接 | [document-links.md](document-links.md) |

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
- 业务主链路保持 `domain/config/mapper -> service -> controller`，`infrastructure` 只作为横切基础设施由 `config` 装配、由 `service` 使用。
- 新增业务代码必须同步测试。
- 涉及 API、错误码、数据库结构或架构边界的变更必须同步对应文档。

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

- 在标准环境执行 `cd server && mvn -B clean verify` 通过。
- 新增或变更业务逻辑有对应测试。
- 没有 `System.out.println` 或 `e.printStackTrace()`。
- 没有裸用 `RestTemplate` 或 `HttpURLConnection`。
- 相关文档已经同步更新。

如果需要按任务查看“开发前必读 + 开发后自检 + 评审清单”，统一入口见 [docs/README.md](../README.md)。
