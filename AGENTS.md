# AGENTS.md

本文件是 HernessDemo 仓库的唯一 AI 协作规则入口。所有 agent 在读取或修改本仓库前，必须先阅读并遵守本文档。

## 回复与编码

- 默认使用简体中文回复。
- GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释必须使用简体中文。
- 代码标识符、API 名称、命令、错误信息和原文引用可以保留英文。
- 涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。

## 项目简介

HernessDemo 是一个面向中小企业的在线项目管理平台，基于 Spring Boot 2.7、Java 1.8 和 MySQL 5.7 构建。

## 技术栈基线

以下技术栈是项目兼容性基线，不允许擅自升级：

- JDK: 1.8，禁止使用 Java 9+ 语法，例如 `record`、`var`、text blocks。
- Spring Boot: 2.7.x，禁止升级到 3.x，因为 Spring 6 要求 JDK 17。
- Maven: 3.6.3，由 Maven Enforcer 强制校验。
- 数据库: MySQL 5.7，字符集使用 `utf8mb4`，禁止升级到 8.x，因为生产环境为 5.7。
- 持久化: MyBatis-Plus 3.5.x，基于 MyBatis 3.5。
- 数据库迁移: Flyway，包含 `flyway-mysql` 子模块。
- 禁止引入 JPA 或 Hibernate。

## 快速导航

如果下列文档尚不存在，新增相关能力时应优先创建或补齐对应文档，而不是让规则散落在代码或对话中。

| 你想做什么 | 去哪里看 |
| --- | --- |
| 了解系统架构 | `docs/architecture/overview.md` |
| 了解模块边界和依赖规则 | `docs/architecture/boundaries.md` |
| 了解编码规范 | `docs/conventions/README.md` |
| 了解当前迭代任务 | `docs/plans/current-sprint.md` |
| 了解 API 规范 | `docs/reference/api-spec.yaml` |
| 了解错误码 | `docs/reference/error-codes.md` |
| 了解测试规范 | `docs/conventions/testing.md` |
| 了解交付模型 | `docs/delivery/delivery-model.md` |
| 了解环境治理 | `docs/delivery/environments.md` |
| 了解流水线设计 | `docs/delivery/pipelines.md` |
| 了解交付全景入口 | `docs/delivery/delivery-operations-map.md` |
| 了解部署策略 | `docs/delivery/deployment-strategies.md` |
| 了解发布验证与回滚 | `docs/operations/release-verification.md` |
| 了解配置与密钥治理 | `docs/operations/config-and-secrets.md` |
| 了解发布权限与审批 | `docs/governance/release-governance.md` |

## 代码结构规则

- 推荐顶层目录保持清晰：`docs/` 放文档，`server/` 放后端服务，`web/` 放前端应用，`deploy/` 放部署材料。
- 根目录只保留项目入口文件、构建入口、仓库说明和必要配置。
- 不要同时保留多个 agent 规则文件；本仓库只使用 `AGENTS.md`。
- 新增模块前，先检查 `docs/architecture/boundaries.md` 中的模块边界和依赖方向。

## 硬性规则

以下规则必须遵守。若 CI、静态检查或验证脚本尚未覆盖，应先按本文件人工执行，并在合适时补齐自动化校验。

1. 依赖方向必须保持为 `domain -> config -> mapper -> service -> controller`，禁止反向依赖或跨层绕行。
2. 横切关注点，例如 auth、log、telemetry，只能通过 Spring 注入，禁止用 `new` 手动实例化。
3. 单个 `.java` 文件不超过 300 行，单个方法不超过 50 行。
4. 禁止使用 `System.out.println` 和 `e.printStackTrace()`，统一使用 SLF4J `Logger`。
5. 禁止裸用 `RestTemplate` 或 `HttpURLConnection`，外部调用必须通过 `ApiClient` 抽象。
6. 禁止字段级 `@Autowired`，必须使用构造器注入，推荐 Lombok `@RequiredArgsConstructor`。
7. 新增业务代码必须有对应 JUnit 5 测试，行覆盖率不低于 80%。
8. 禁止为了绕过测试或编译错误而降低校验标准、删除断言或跳过必要测试。

## 开发流程

- 修改前先阅读相关导航文档；文档缺失时，结合现有代码判断，并在本次变更中补齐必要说明。
- 优先遵循项目已有模式，不要为局部需求引入新的框架、全局抽象或不必要依赖。
- 涉及数据库结构变更时，必须通过 Flyway migration 管理，不要只修改实体或 SQL 片段。
- 涉及 API 变更时，同步更新 `docs/reference/api-spec.yaml`。
- 涉及错误码变更时，同步更新 `docs/reference/error-codes.md`。
- 涉及模块边界、依赖方向或部署方式变化时，同步更新 `docs/architecture/` 下的相关文档。
- 涉及环境、流水线、制品、部署策略或回滚机制变化时，同步更新 `docs/delivery/` 下的相关文档。
- 涉及发布验证、配置密钥、运行手册或服务目标变化时，同步更新 `docs/operations/` 下的相关文档。
- 涉及审批、权限和审计流程变化时，同步更新 `docs/governance/` 下的相关文档。

## 测试要求

- 新增代码默认使用 JUnit 5 编写测试。
- 业务服务、Mapper、Controller 和外部接口适配器都应有与风险匹配的测试覆盖。
- 修复缺陷时，必须先补充能复现问题的回归测试，再修复实现。
- 不要使用真实外部服务作为单元测试依赖；需要外部交互时应使用 mock、stub 或测试容器。

## Git 与提交

需要提交代码时，必须执行完整 GitHub 流程：

1. 先执行 `git status`，确认当前分支和工作区状态。
2. 再执行 `git add` 暂存本次相关改动。
3. 然后执行 `git commit`，提交信息必须使用简体中文，并遵守提交类型规范。
4. 最后推送当前分支到 `origin`。
5. 如果当前分支没有 upstream，使用 `git push -u origin 当前分支名`。

禁止使用 `git push --force`、`git reset --hard`、`git clean` 等可能破坏历史或删除改动的命令，除非用户明确要求。远程仓库未配置、无权限、存在冲突或当前分支不明确时，必须暂停并说明具体问题，不要猜测处理。

## 提交类型

- `feat`: 新功能
- `fix`: 修复
- `refactor`: 重构
- `docs`: 文档
- `test`: 测试

