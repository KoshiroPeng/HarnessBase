---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 工程规范目录入口，汇总编码、测试、日志、命名、技术基线与任务启动规则。
---

# 编码规范总览

本目录记录 ProjectPilot 的工程规范。根规则以 [AGENTS.md](../../AGENTS.md) 为准，本文档负责把日常开发细则拆分到可维护的位置。

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
| 文档元数据规范 | [docs/conventions/document-metadata.md](document-metadata.md) |
| Harness 自动化落地方案 | [docs/conventions/harness-automation-roadmap.md](harness-automation-roadmap.md) |
| 任务启动清单 | [docs/conventions/task-startup-checklist.md](task-startup-checklist.md) |
| 评审清单总览 | [docs/reviews/README.md](../reviews/README.md) |
| 验证证据模板 | [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) |
| API 规范 | [docs/reference/api-spec.yaml](../reference/api-spec.yaml) |
| 错误码 | [docs/reference/error-codes.md](../reference/error-codes.md) |
| 发布材料 | [deploy/release/README.md](../../deploy/release/README.md) |
| 可观测性材料 | [deploy/observability/README.md](../../deploy/observability/README.md) |

## 目标技术基线

- 后端使用 JDK 17 LTS。
- Spring Boot 使用 3.x。
- Maven 使用 3.9+。
- MySQL 使用 8.x，字符集 `utf8mb4`。
- 持久化使用 MyBatis-Plus Boot 3 + Flyway。
- Web 使用 Vue 3 + TypeScript + Vite。
- Node 使用 20 LTS+，推荐 `pnpm`。
- 测试使用 JUnit 5 与 Vitest。

详细说明见 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)。

## 基本原则

- 优先遵循项目已有模式。
- 不为局部需求引入新框架或全局抽象。
- 后端依赖方向保持 `bootstrap -> adapter -> application -> domain -> shared`。
- 新增业务代码必须同步测试。
- 外部系统接入必须通过 adapter 或 `ApiClient`。
- 涉及 API、错误码、数据库结构、发布流程或架构边界的变更必须同步文档。

## 代码规模

- 单个 `.java` 文件不超过 300 行。
- 单个方法不超过 50 行。
- 超限前优先拆分职责，而不是靠格式压缩规避限制。

## 注入与命名空间规范

- 禁止字段级 `@Autowired`。
- 必须使用构造器注入。
- 推荐 Lombok `@RequiredArgsConstructor`。
- 新代码统一使用 `jakarta.*` 命名空间。
- auth、log、telemetry、外部 API 客户端等横切能力必须通过 Spring 注入。

## 提交前自检

提交前至少确认：

- 代码可以编译。
- 新增或变更业务逻辑有对应测试。
- 没有 `System.out.println` 或 `e.printStackTrace()`。
- 没有直接裸用第三方 HTTP 客户端绕过统一适配器。
- 相关文档已经同步更新。

如果需要按任务查看“开发前必读 + 开发后自检 + 评审清单”，统一入口见 [docs/README.md](../README.md)。

如果需要一份更短的“开始执行任务”入口，优先看 [docs/conventions/task-startup-checklist.md](task-startup-checklist.md)。

## 典型阅读路径

如果你现在要开发后端代码，建议按下面顺序阅读：

1. [AGENTS.md](../../AGENTS.md)
2. [docs/architecture/README.md](../architecture/README.md)
3. [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
4. [docs/plans/jdk17-springboot3-migration-roadmap.md](../plans/jdk17-springboot3-migration-roadmap.md)
5. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)

如果你现在要做开发后自检，建议至少同时对照：

1. [docs/conventions/testing.md](testing.md)
2. [docs/conventions/error-handling.md](error-handling.md)
3. [docs/conventions/logging.md](logging.md)
4. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
5. [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
6. [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
