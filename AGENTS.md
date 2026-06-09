---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 仓库级 AI 协作规则、当前微服务代码事实、开发导航入口、架构护栏与文档治理要求。
---

# AGENTS.md

本文件是 HarnessBase 仓库唯一的 AI 协作规则入口。所有 agent 在读取、修改或提交本仓库前，必须先阅读并遵守本文档。

## 回复与编码

- 默认使用简体中文回复。
- GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释必须使用简体中文。
- 代码标识符、API 名称、命令、错误信息和原文引用可以保留英文。
- 涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。

## 当前项目事实

HarnessBase 当前是基于若依微服务体系整理的后台管理系统微服务工程。

真实代码主线：

- 后端 Maven 根：[server/pom.xml](server/pom.xml)。
- 网关服务：[server/ruoyi-gateway](server/ruoyi-gateway)。
- 认证服务：[server/ruoyi-auth](server/ruoyi-auth)。
- 业务服务集合：[server/ruoyi-modules](server/ruoyi-modules)。
- 远程接口定义：[server/ruoyi-api](server/ruoyi-api)。
- 公共能力模块：[server/ruoyi-common](server/ruoyi-common)。
- 可视化监控服务：[server/ruoyi-visual](server/ruoyi-visual)。
- 数据库脚本目录：[server/sql](server/sql)。
- Docker 与启动辅助材料：[server/docker](server/docker)、[server/bin](server/bin)。
- 前端应用：[web](web)。
- 发布与观测支撑：[deploy](deploy)。

当前后端业务服务包括：

- 系统服务：[server/ruoyi-modules/ruoyi-system](server/ruoyi-modules/ruoyi-system)
- 代码生成服务：[server/ruoyi-modules/ruoyi-gen](server/ruoyi-modules/ruoyi-gen)
- 定时任务服务：[server/ruoyi-modules/ruoyi-job](server/ruoyi-modules/ruoyi-job)
- 文件服务：[server/ruoyi-modules/ruoyi-file](server/ruoyi-modules/ruoyi-file)

命名语境说明：

- `HarnessBase` 是当前仓库协作名。
- `ruoyi`、`RuoYi-Cloud`、`com.ruoyi` 可能分别出现在仓库内容、上游脚手架、包名和制品语境中。
- 新增文档必须明确所处语境，不要把仓库名、上游名、包名和业务名混写。

## 当前技术基线

- 后端运行时：JDK 17。
- 后端框架：Spring Boot 4.0.3、Spring Cloud 2025.1.0、Spring Cloud Alibaba 2025.1.0.0。
- 构建工具：Maven。
- 包命名主线：`com.ruoyi.*`。
- 持久化：MyBatis、PageHelper、dynamic-datasource、Druid。
- 服务治理与配置：Nacos、Spring Cloud Gateway、OpenFeign。
- 缓存与会话：Redis。
- 鉴权：JWT、网关鉴权、认证中心。
- 接口文档：SpringDoc。
- 前端：Vue 2、Vue CLI、Element UI、Vuex、Vue Router 3、JavaScript。
- 测试：后端 JUnit 5；前端仓库当前未见 Vitest/Jest 测试基线，新增前端测试前需先核对实际工具链。

当前没有落地 Flyway migration；涉及数据库结构变更时，应优先沿用 [server/sql](server/sql) 的脚本体系，除非本次任务明确引入并验证新的迁移方案。

## 快速导航

| 你想做什么 | 去哪里看 |
| --- | --- |
| 了解统一文档导航 | [docs/README.md](docs/README.md) |
| 了解真实代码地图 | [docs/architecture/code-map.md](docs/architecture/code-map.md) |
| 了解系统架构总览 | [docs/architecture/overview.md](docs/architecture/overview.md) |
| 了解目标技术基线 | [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md) |
| 了解模块边界和依赖规则 | [docs/architecture/boundaries.md](docs/architecture/boundaries.md) |
| 了解新增业务功能如何闭环落地 | [docs/architecture/business-extension-baseline.md](docs/architecture/business-extension-baseline.md) |
| 了解 Harness Engineering 在本仓库中的用法 | [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md) |
| 了解后端工程入口 | [server/README.md](server/README.md) |
| 了解前端工程入口 | [web/README.md](web/README.md) |
| 了解 GitHub workflow 入口 | [.github/README.md](.github/README.md) |
| 了解开发前看什么、开发后怎么自检 | [docs/conventions/development-execution-guide.md](docs/conventions/development-execution-guide.md) |
| 了解编码规范 | [docs/conventions/README.md](docs/conventions/README.md) |
| 了解 API 事实入口 | [docs/reference/README.md](docs/reference/README.md) |
| 了解响应码与错误消息 | [docs/reference/error-codes.md](docs/reference/error-codes.md) |
| 了解 SQL 变更检查 | [docs/reference/sql-change-checklist.md](docs/reference/sql-change-checklist.md) |
| 了解测试规范 | [docs/conventions/testing.md](docs/conventions/testing.md) |
| 了解评审清单入口 | [docs/reviews/README.md](docs/reviews/README.md) |
| 了解发布支撑材料 | [deploy/release/README.md](deploy/release/README.md) |
| 了解可观测性材料 | [deploy/observability/README.md](deploy/observability/README.md) |

## 代码结构规则

- 顶层目录保持清晰：`docs/` 放文档，`server/` 放后端，`web/` 放前端，`deploy/` 放发布与观测材料。
- 根目录只保留项目入口文件、仓库说明和必要配置。
- 不要新增第二个 agent 规则文件；本仓库只使用 `AGENTS.md`。
- 新增后端能力优先按现有若依微服务模块体系放置：网关进 `ruoyi-gateway`，认证进 `ruoyi-auth`，公共能力进 `ruoyi-common-*`，远程接口进 `ruoyi-api-*`，业务能力进 `ruoyi-modules/*`，监控与可视化能力进 `ruoyi-visual/*`。
- 新增前端能力优先按现有 `web/src/api`、`web/src/views`、`web/src/router`、`web/src/store` 结构扩展。

## 硬性规则

1. 新增代码必须先确认现有模块边界，不要绕过 `ruoyi-common-*`、`ruoyi-api-*`、`ruoyi-modules/*`、`web/src/api` 等既有抽象。
2. 微服务之间禁止为了方便直接跨服务复制业务逻辑；跨服务协作优先通过网关、Feign、远程 API 模块或明确的适配层完成。
3. 外部系统调用必须通过已有 common 能力、adapter、client 或明确封装类接入，禁止把第三方 SDK 零散扩散到业务方法中。
4. 禁止新增 `javax.*` 依赖或旧命名空间；新代码统一使用当前 Spring Boot 4/Jakarta 体系。
5. 横切关注点，例如 auth、log、gateway filter、cache、审计、限流、远程调用，只能通过 Spring 注入或已有公共模块接入，禁止手动 `new` 扩散。
6. 禁止新增字段级 `@Autowired`，必须使用构造器注入。
7. 禁止新增 `System.out.println` 和 `e.printStackTrace()`，统一使用日志框架。
8. 新增业务代码必须有对应测试；缺陷修复必须补回归测试。
9. 数据库结构变更必须同步维护 [server/sql](server/sql) 下的相关脚本，并同步更新相关文档。
10. 涉及 API 变更时，同步更新 [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml) 或说明为什么由 SpringDoc / 实际服务接口定义覆盖。
11. 涉及响应码、异常处理或 i18n 消息变更时，同步更新 [docs/reference/error-codes.md](docs/reference/error-codes.md)。
12. 导航型文档、目录索引页和关键流程说明必须使用可点击 Markdown 链接，不要只保留纯文本路径。
13. 任何会影响“开发、测试、评审、发布”主路径的文档变更，都必须同步更新 [docs/README.md](docs/README.md) 或对应目录 `README.md`。
14. 新增内部治理型 Markdown 文档时，必须在文件头部增加统一元数据标头：`last_updated`、`status`、`owner`、`description`；根目录 [README.md](README.md) 可作为对外入口文档豁免此要求。上游模板、资源目录占位 Markdown 或非治理用途说明文件按 [docs/conventions/document-metadata.md](docs/conventions/document-metadata.md) 判定是否豁免。
15. 修改带有元数据标头的 Markdown 文档时，必须同步更新该文档标头中的 `last_updated` 日期。

## 历史边界提醒

以下词汇只允许出现在历史扫描、误用检查或迁移说明语境中，不应再作为当前项目入口事实继续扩写：

- `RuoYi-Vue-Plus`
- `ruoyi-admin`
- `ruoyi-extend`
- `org.dromara`
- `server/script/sql`

## Harness Engineering 闭环要求

Harness Engineering 在本仓库中的含义是：用清晰入口、真实代码地图、可执行验证和自动化护栏，降低微服务协作、重构和发布的不确定性。

执行任务时默认遵守：

1. 开始前先完成统一入口阅读：`AGENTS.md` -> [docs/README.md](docs/README.md) -> [docs/architecture/code-map.md](docs/architecture/code-map.md) -> 对应任务场景文档。
2. 如果任务涉及架构、服务边界、发布、数据库脚本或 workflow，必须先核对真实文件，不允许只凭说明性文档判断。
3. 如果任务涉及新增业务功能或业务域，必须先核对 [docs/architecture/business-extension-baseline.md](docs/architecture/business-extension-baseline.md)，确认后端、前端、SQL、权限、API、测试和验证证据的纵向闭环。
4. 阅读文档时只按当前任务场景展开必要链接；当已经明确代码落位、影响范围和验证方式后，必须停止递归追踪导航链接，进入代码或文档实施。
5. 禁止为了“读完所有文档”而循环阅读目录索引、导航页或互相引用的规则文档；文档用于定位任务，不替代真实代码核对。
6. 如果任务跨多个文档、模块或阶段，优先使用 [docs/plans/task-status-template.md](docs/plans/task-status-template.md) 记录目标、进展、风险和待补文档。
7. 完成前如果任务涉及功能、缺陷、评审、测试、发布或重要文档治理，优先使用 [docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md) 记录验证方式、结果和未覆盖风险。
8. 新增规范、清单、模板或导航页后，必须让它能够从 [docs/README.md](docs/README.md) 或目录索引页直接进入。
9. 如果任务涉及自动化检查，优先核对 [docs/conventions/automation-check-catalog.md](docs/conventions/automation-check-catalog.md) 和 [.github/scripts/doc_guardrails.py](.github/scripts/doc_guardrails.py)；试运行结果记录到验证证据、PR、CI 或提交说明，不再新增阶段过程文档。

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
