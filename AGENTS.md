---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 仓库级 AI 协作规则、目标技术基线、架构护栏与文档治理入口。
---

# AGENTS.md

本文件是 ProjectPilot 项目仓库唯一的 AI 协作规则入口。所有 agent 在读取或修改本仓库前，必须先阅读并遵守本文档。

## 回复与编码

- 默认使用简体中文回复。
- GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释必须使用简体中文。
- 代码标识符、API 名称、命令、错误信息和原文引用可以保留英文。
- 涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。

## 项目简介

ProjectPilot 是一个面向中小企业的在线项目管理 Web 产品，核心目标是支撑登录、项目、任务、成员、权限、搜索和计费等协作场景。

当前项目主线是 Web 产品研发，不是继续扩张交付平台本体。Harness Engineering 在本仓库中的定位是工程方法，用于加强导航、护栏、评审和验证，而不是替代产品范围。

项目命名口径说明：

- 对外文档、产品说明和接口标题统一使用 `ProjectPilot`。
- 仓库目录名、部署名、服务名、日志名、制品名、脚本名和类名中的 `herness-demo`、`Harness-demo`、`HernessDemo` 视为历史技术标识，当前阶段允许保留。
- 当前仓库仍可能存在历史 `Java 8 / Spring Boot 2.7` 配置残留；从现在起，文档与后续改造一律以新主线基线收敛，不再继续扩张旧基线。

## 目标技术基线

以下基线是当前项目的目标主线，新增设计、文档和后续代码迁移必须遵守：

- 后端运行时：JDK 17 LTS。
- 后端框架：Spring Boot 3.x / Spring Framework 6。
- 构建工具：Maven 3.9+。
- 数据库：MySQL 8.x，字符集 `utf8mb4`。
- 持久化：MyBatis-Plus Boot 3 体系 + Flyway。
- Web 前端：Vue 3 + TypeScript + Vite。
- Node 工具链：Node 20 LTS+，推荐 `pnpm`。
- API 文档：OpenAPI / SpringDoc。
- 测试：JUnit 5、前端单元测试使用 Vitest，按风险补齐集成测试。

默认不采用：

- 继续把 Java 8 / Spring Boot 2.7 当作新主线扩展。
- `javax.*` 新增依赖或新代码继续沿用旧命名空间。
- JPA / Hibernate 作为默认持久化方案。
- 为了“平台化”而提前引入微服务、Kubernetes 或过重治理体系。

详细基线见 [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)。

## 快速导航

如果下列文档尚不存在，新增相关能力时应优先创建或补齐对应文档，而不是让规则散落在代码或对话中。

| 你想做什么 | 去哪里看 |
| --- | --- |
| 了解统一文档导航 | [docs/README.md](docs/README.md) |
| 了解系统架构总览 | [docs/architecture/overview.md](docs/architecture/overview.md) |
| 了解目标技术基线 | [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md) |
| 了解如何吸收 CallCenter 的工程结构参考 | [docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md) |
| 了解 Harness Engineering 在本项目中的正确用法 | [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md) |
| 了解模块边界和依赖规则 | [docs/architecture/boundaries.md](docs/architecture/boundaries.md) |
| 了解编码规范 | [docs/conventions/README.md](docs/conventions/README.md) |
| 了解当前迭代任务 | [docs/plans/current-sprint.md](docs/plans/current-sprint.md) |
| 了解 JDK 17 / Spring Boot 3 迁移路线 | [docs/plans/jdk17-springboot3-migration-roadmap.md](docs/plans/jdk17-springboot3-migration-roadmap.md) |
| 了解 API 规范 | [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml) |
| 了解错误码 | [docs/reference/error-codes.md](docs/reference/error-codes.md) |
| 了解测试规范 | [docs/conventions/testing.md](docs/conventions/testing.md) |
| 了解评审清单入口 | [docs/reviews/README.md](docs/reviews/README.md) |
| 了解发布支撑材料 | [deploy/release/README.md](deploy/release/README.md) |
| 了解可观测性材料 | [deploy/observability/README.md](deploy/observability/README.md) |

## 代码结构规则

- 推荐顶层目录保持清晰：`docs/` 放文档，`server/` 放后端服务，`web/` 放前端应用，`deploy/` 放部署材料。
- 根目录只保留项目入口文件、构建入口、仓库说明和必要配置。
- 不要同时保留多个 agent 规则文件；本仓库只使用 `AGENTS.md`。
- 新增模块前，先检查 [docs/architecture/boundaries.md](docs/architecture/boundaries.md) 中的模块边界和依赖方向。

目标后端结构参考 CallCenter 的“分区清晰 + 模块化单体 + adapter 隔离”思路，但会结合当前项目做轻量化改造：

```text
server/
├── bootstrap/
├── shared/
├── modules/
│   ├── auth/
│   ├── organization/
│   ├── project/
│   ├── task/
│   └── billing/
├── integration/
└── script/
```

目标前端结构采用 Web 工程主线：

```text
web/
├── apps/
│   └── projectpilot-web/
├── packages/
│   ├── shared-ui/
│   ├── shared-api/
│   └── config/
└── tooling/
```

## 硬性规则

以下规则必须遵守。若 CI、静态检查或验证脚本尚未覆盖，应先按本文件人工执行，并在合适时补齐自动化校验。

1. 后端采用模块化单体，依赖只能从外向内流动：`bootstrap -> adapter -> application -> domain -> shared`。
2. 模块之间禁止直接跨模块调用 `controller`、`mapper` 或数据库表；跨模块协作应通过应用服务接口、领域事件或稳定共享契约完成。
3. 外部系统调用必须通过 adapter 或 `ApiClient` 抽象接入，禁止在业务代码中裸用 HTTP 客户端。
4. Spring Boot 3.x 主线下禁止新增 `javax.*` 依赖或沿用旧式命名空间，新代码统一使用 `jakarta.*`。
5. 横切关注点，例如 auth、log、telemetry、cache、审计，只能通过 Spring 注入，禁止用 `new` 手动实例化。
6. 单个 `.java` 文件不超过 300 行，单个方法不超过 50 行。
7. 禁止使用 `System.out.println` 和 `e.printStackTrace()`，统一使用 SLF4J `Logger`。
8. 禁止字段级 `@Autowired`，必须使用构造器注入，推荐 Lombok `@RequiredArgsConstructor`。
9. 新增业务代码必须有对应测试；后端默认 JUnit 5，前端默认 Vitest，缺陷修复必须补回归测试。
10. 数据库结构变更必须通过 Flyway migration 管理，不允许只改实体、Mapper 或零散 SQL。
11. 导航型文档、目录索引页和关键流程说明必须使用可点击 Markdown 链接，不要只保留纯文本路径。
12. 任何会影响“开发、测试、评审、发布”主路径的文档变更，都必须同步更新 [docs/README.md](docs/README.md) 或对应目录 `README.md`。
13. 新增内部 Markdown 文档时，必须在文件头部增加统一元数据标头：`last_updated`、`status`、`owner`、`description`；根目录 [README.md](README.md) 可作为对外入口文档豁免此要求。
14. 修改带有元数据标头的 Markdown 文档时，必须同步更新该文档标头中的 `last_updated` 日期。

## Harness 闭环要求

为避免只做“文档堆积”而没有形成工程闭环，执行任务时默认遵守以下最小 Harness 流程：

1. 开始前先完成统一入口阅读：`AGENTS.md` -> [docs/README.md](docs/README.md) -> [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md) -> 对应任务场景文档。
2. 如果任务涉及技术基线升级、Boot 迁移或架构融合，补充阅读 [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)、[docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md)、[docs/plans/jdk17-springboot3-migration-roadmap.md](docs/plans/jdk17-springboot3-migration-roadmap.md)。
3. 执行中如果任务跨多个文档、模块或阶段，优先使用 [docs/plans/task-status-template.md](docs/plans/task-status-template.md) 记录目标、进展、风险和待补文档。
4. 完成前如果任务涉及功能、缺陷、评审、测试、发布或重要文档治理，优先使用 [docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md) 记录验证方式、结果和未覆盖风险。
5. 新增规范、清单、模板或导航页后，必须让它能够从 [docs/README.md](docs/README.md) 或目录索引页直接进入，避免知识只停留在对话里。

## 任务场景联读要求

以下组合用于把 Harness Engineering 落到“做这类任务时必须一起看哪些文档”。

| 任务场景 | 至少联读这些文档 |
| --- | --- |
| 后端功能开发 | [docs/architecture/overview.md](docs/architecture/overview.md)、[docs/architecture/boundaries.md](docs/architecture/boundaries.md)、[docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)、[docs/conventions/README.md](docs/conventions/README.md)、[docs/reviews/backend-code-review-checklist.md](docs/reviews/backend-code-review-checklist.md) |
| Web 前端开发 | [docs/design/web-mvp-roadmap.md](docs/design/web-mvp-roadmap.md)、[docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md)、[docs/conventions/README.md](docs/conventions/README.md)、[docs/reviews/frontend-code-review-checklist.md](docs/reviews/frontend-code-review-checklist.md) |
| 技术基线升级或架构融合 | [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)、[docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md)、[docs/plans/jdk17-springboot3-migration-roadmap.md](docs/plans/jdk17-springboot3-migration-roadmap.md) |
| 需求评审 | [docs/reviews/requirement-review-checklist.md](docs/reviews/requirement-review-checklist.md)、[docs/design/README.md](docs/design/README.md)、[docs/plans/README.md](docs/plans/README.md) |
| 后端设计评审 | [docs/reviews/backend-design-review-checklist.md](docs/reviews/backend-design-review-checklist.md)、[docs/architecture/boundaries.md](docs/architecture/boundaries.md)、[docs/reference/api-spec.yaml](docs/reference/api-spec.yaml)、[docs/reference/error-codes.md](docs/reference/error-codes.md) |
| 代码评审或开发后自检 | [docs/conventions/README.md](docs/conventions/README.md)、[docs/reviews/backend-code-review-checklist.md](docs/reviews/backend-code-review-checklist.md)、[docs/reviews/frontend-code-review-checklist.md](docs/reviews/frontend-code-review-checklist.md)、[docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md) |
| 测试设计、补测试或用例评审 | [docs/conventions/testing.md](docs/conventions/testing.md)、[docs/reviews/testcase-review-checklist.md](docs/reviews/testcase-review-checklist.md)、[docs/reference/error-codes.md](docs/reference/error-codes.md) |
| 发布、回滚或上线验证 | [deploy/release/README.md](deploy/release/README.md)、[deploy/release/release-checklist.md](deploy/release/release-checklist.md)、[deploy/observability/README.md](deploy/observability/README.md) |
| 文档整理或规则治理 | [docs/README.md](docs/README.md)、[docs/conventions/document-links.md](docs/conventions/document-links.md)、[docs/conventions/document-metadata.md](docs/conventions/document-metadata.md)、[docs/plans/task-status-template.md](docs/plans/task-status-template.md) |

## 开发流程

- 修改前先阅读相关导航文档；文档缺失时，结合现有代码判断，并在本次变更中补齐必要说明。
- 如果任务属于产品功能开发，优先阅读 [docs/design/web-mvp-roadmap.md](docs/design/web-mvp-roadmap.md) 和 [docs/design/README.md](docs/design/README.md)。
- 如果任务刚开始、还不确定具体要读哪些文档，优先阅读 [docs/conventions/task-startup-checklist.md](docs/conventions/task-startup-checklist.md)。
- 如果任务提到 Harness Engineering，应先阅读 [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md)，确认是在做工程纠偏，而不是扩张平台范围。
- 如果任务提到技术架构融合或参考 CallCenter，补充阅读 [docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md)。
- 涉及数据库结构变更时，必须通过 Flyway migration 管理。
- 涉及 API 变更时，同步更新 [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml)。
- 涉及错误码变更时，同步更新 [docs/reference/error-codes.md](docs/reference/error-codes.md)。
- 涉及模块边界、依赖方向或部署方式变化时，同步更新 [docs/architecture/README.md](docs/architecture/README.md) 与对应架构文档。
- 涉及发布、回滚、环境变量或上线验证变化时，同步更新 [deploy/release/README.md](deploy/release/README.md) 下的相关文档。
- 涉及监控、日志采集或本地观测方案变化时，同步更新 [deploy/observability/README.md](deploy/observability/README.md) 下的相关文档。

## 测试要求

- 后端测试默认使用 JUnit 5。
- 前端测试默认使用 Vitest，视页面风险补充组件测试或联调验证。
- 业务服务、Controller、持久化适配器和外部接口适配器都应有与风险匹配的测试覆盖。
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

- `feat`：新功能
- `fix`：修复
- `refactor`：重构
- `docs`：文档
- `test`：测试
