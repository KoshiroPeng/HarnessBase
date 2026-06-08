# AGENTS.md

本文件是 HernessDemo 仓库的唯一 AI 协作规则入口。所有 agent 在读取或修改本仓库前，必须先阅读并遵守本文档。

## 回复与编码

- 默认使用简体中文回复。
- GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释必须使用简体中文。
- 代码标识符、API 名称、命令、错误信息和原文引用可以保留英文。
- 涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。

## 项目简介

HernessDemo 是一个面向中小企业的在线项目管理平台。当前仓库包含根目录 `server/` 的 Java 8 + Spring Boot 2.7 后端骨架，以及从 CallCenter 合并进来的 `services/callcenter-server` 和 `services/callcenter-web` 两个独立 Service。交付文档按 Harness Engineering 的 Application、Service、Environment、Artifact、Pipeline、Verification 和 Rollback 对象模型组织。

## 技术栈基线

以下技术栈是根目录 `server/` 的兼容性基线，不允许擅自升级：

- JDK: 1.8，禁止使用 Java 9+ 语法，例如 `record`、`var`、text blocks。
- Spring Boot: 2.7.x，禁止升级到 3.x，因为 Spring 6 要求 JDK 17。
- Maven: 3.6.3，由 Maven Enforcer 强制校验。
- 数据库: MySQL 5.7，字符集使用 `utf8mb4`，禁止升级到 8.x，因为生产环境为 5.7。
- 持久化: MyBatis-Plus 3.5.x，基于 MyBatis 3.5。
- 数据库迁移: Flyway，包含 `flyway-mysql` 子模块。
- 禁止引入 JPA 或 Hibernate。

从 CallCenter 合并进来的 Service 使用独立基线：

- `services/callcenter-server`: Java 17 + Spring Boot 3.5.14 + RuoYi-Vue-Plus 裁剪版。
- `services/callcenter-web`: Node >= 20.19.0 + pnpm 11.5.2 + Vue 3 + TypeScript + Vite。
- 修改这些 Service 时，优先遵循其自身 `README.md`、`pom.xml`、`package.json` 和锁文件，不要套用根 `server/` 的 Java 8 限制。

## Harness Engineering 原则

以下原则是本仓库的项目级强制规则，所有新增 Service、环境、交付脚本、CI/CD workflow、部署材料和运维文档都必须遵守。

1. 所有可交付能力必须映射到 Harness Engineering 对象模型：`Application`、`Service`、`Environment`、`Infrastructure`、`Artifact`、`Pipeline`、`Verification`、`Rollback`。
2. `HernessDemo` 是当前唯一 `Application`；`server`、`callcenter-server`、`callcenter-web` 是独立 `Service`。不要把“源码目录”“Maven 模块”或“前端页面”误当成可交付 Service。
3. 新增或拆分可部署单元时，必须先明确 Service 边界、构建入口、制品格式、部署目标和回滚边界，再修改代码或 workflow。
4. 环境差异必须通过 `Environment`、配置、密钥和部署参数表达，禁止把环境专属逻辑散落在业务代码或临时脚本中。
5. 每个 `Artifact` 必须可追溯到 Git commit、构建编号、目标 Service 和构建参数，禁止部署无版本标识的本地手工产物。
6. 每条 `Pipeline` 必须显式绑定 Service、Environment、Infrastructure 和 Artifact，并包含可执行的 Verification 与 Rollback 路径。
7. `Verification` 是发布闭环的一部分，不是可选动作；发布、回滚或环境初始化后必须留下可审计的验证结果。
8. 交付相关变更不得只写在脚本或 CI 平台配置里；涉及 Service、Environment、Infrastructure、Artifact、Pipeline、Verification 或 Rollback 的变化，必须同步更新 `docs/delivery/`、`docs/operations/` 或 `docs/governance/` 中对应文档。

## 快速导航

如果下列文档尚不存在，新增相关能力时应优先创建或补齐对应文档，而不是让规则散落在代码或对话中。

| 你想做什么 | 去哪里看 |
| --- | --- |
| 了解系统架构 | [docs/architecture/overview.md](docs/architecture/overview.md) |
| 了解统一文档导航 | [docs/README.md](docs/README.md) |
| 开发后端代码并做自检 | [docs/README.md#开发后端代码](docs/README.md#开发后端代码) |
| 做后台代码评审 | [docs/reviews/backend-code-review-checklist.md](docs/reviews/backend-code-review-checklist.md) |
| 了解模块边界和依赖规则 | [docs/architecture/boundaries.md](docs/architecture/boundaries.md) |
| 了解编码规范 | [docs/conventions/README.md](docs/conventions/README.md) |
| 了解当前迭代任务 | [docs/plans/current-sprint.md](docs/plans/current-sprint.md) |
| 了解 API 规范 | [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml) |
| 了解错误码 | [docs/reference/error-codes.md](docs/reference/error-codes.md) |
| 了解测试规范 | [docs/conventions/testing.md](docs/conventions/testing.md) |
| 了解交付模型 | [docs/delivery/delivery-model.md](docs/delivery/delivery-model.md) |
| 了解环境治理 | [docs/delivery/environments.md](docs/delivery/environments.md) |
| 了解流水线设计 | [docs/delivery/pipelines.md](docs/delivery/pipelines.md) |
| 了解交付全景入口 | [docs/delivery/delivery-operations-map.md](docs/delivery/delivery-operations-map.md) |
| 了解评审清单入口 | [docs/reviews/README.md](docs/reviews/README.md) |
| 了解部署策略 | [docs/delivery/deployment-strategies.md](docs/delivery/deployment-strategies.md) |
| 了解发布验证与回滚 | [docs/operations/release-verification.md](docs/operations/release-verification.md) |
| 了解配置与密钥治理 | [docs/operations/config-and-secrets.md](docs/operations/config-and-secrets.md) |
| 了解发布权限与审批 | [docs/governance/release-governance.md](docs/governance/release-governance.md) |

## 代码结构规则

- 推荐顶层目录保持清晰：`docs/` 放文档，`server/` 放 HernessDemo 后端骨架，`services/` 放独立可交付 Service，`deploy/` 放部署材料。
- `services/callcenter-server` 和 `services/callcenter-web` 是从 CallCenter 合并进来的独立 Service，不要覆盖或混入根 `server/`。
- 根目录只保留项目入口文件、构建入口、仓库说明和必要配置。
- 不要同时保留多个 agent 规则文件；本仓库只使用 `AGENTS.md`。
- 新增模块前，先检查 [docs/architecture/boundaries.md](docs/architecture/boundaries.md) 中的模块边界和依赖方向。

## 硬性规则

以下代码规则默认约束根目录 `server/` 和后续新增 HernessDemo 业务代码；交付和部署变更同时受上方 Harness Engineering 原则约束。`services/callcenter-server` 与 `services/callcenter-web` 是迁入的既有工程，合并当下不做大规模机械重构；后续修改这些 Service 时，应优先遵守其自身工程约定，并逐步补齐对应 CI、测试和发布门禁。

1. 根 `server/` 的依赖方向必须保持单向：主业务链路为 `domain/config/mapper -> service -> controller`，`infrastructure` 仅作为横切基础设施由 `config` 装配、由 `service` 使用，禁止被 `controller` 绕过调用。
2. 横切关注点，例如 auth、log、telemetry，只能通过 Spring 注入，禁止用 `new` 手动实例化。
3. 根 `server/` 新增 `.java` 文件不超过 300 行，单个方法不超过 50 行。
4. 禁止使用 `System.out.println` 和 `e.printStackTrace()`，统一使用 SLF4J `Logger`。
5. 禁止裸用 `RestTemplate` 或 `HttpURLConnection`，外部调用必须通过 `ApiClient` 抽象。
6. 禁止字段级 `@Autowired`，必须使用构造器注入，推荐 Lombok `@RequiredArgsConstructor`。
7. 根 `server/` 新增业务代码必须有对应 JUnit 5 测试，行覆盖率不低于 80%；CallCenter Service 按自身测试体系逐步补齐。
8. 禁止为了绕过测试或编译错误而降低校验标准、删除断言或跳过必要测试。

## 开发流程

- 修改前先阅读相关导航文档；文档缺失时，结合现有代码判断，并在本次变更中补齐必要说明。
- 如果任务涉及多个阶段文档，优先从 [docs/README.md](docs/README.md) 选择对应场景的文档组合。
- 如果任务是“开发代码”，至少要同时完成编码规范阅读和代码评审清单自检，不要只看其中一份文档。
- 优先遵循项目已有模式，不要为局部需求引入新的框架、全局抽象或不必要依赖。
- 涉及数据库结构变更时，必须通过 Flyway migration 管理，不要只修改实体或 SQL 片段。
- 涉及 API 变更时，同步更新 [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml)。
- 涉及错误码变更时，同步更新 [docs/reference/error-codes.md](docs/reference/error-codes.md)。
- 涉及模块边界、依赖方向或部署方式变化时，同步更新 [docs/architecture/](docs/architecture/) 下的相关文档。
- 涉及环境、流水线、制品、部署策略或回滚机制变化时，同步更新 [docs/delivery/](docs/delivery/) 下的相关文档。
- 涉及发布验证、配置密钥、运行手册或服务目标变化时，同步更新 [docs/operations/](docs/operations/) 下的相关文档。
- 涉及审批、权限和审计流程变化时，同步更新 [docs/governance/](docs/governance/) 下的相关文档。

## 测试要求

- 根 `server/` 新增代码默认使用 JUnit 5 编写测试。
- 业务服务、Mapper、Controller 和外部接口适配器都应有与风险匹配的测试覆盖；CallCenter Service 按其自身 Maven / pnpm 测试入口逐步纳入。
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
