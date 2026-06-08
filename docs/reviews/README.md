---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 评审清单总览

## 目标

本目录用于沉淀 HernessDemo 在需求、设计、代码和测试阶段的评审清单，作为项目交付过程中的统一检查入口。

这些清单的目标不是替代需求文档、详细设计文档、测试用例或代码规范，而是帮助评审人员在关键阶段快速检查高风险遗漏项。

## 使用原则

- 需求评审使用需求评审清单。
- 后台详细设计评审使用后台设计评审清单。
- 前端详细设计评审使用前端设计评审清单。
- 后台代码评审使用后台代码评审清单。
- 前端代码评审使用前端代码评审清单。
- 测试用例评审使用测试用例评审清单。
- 需要输出评审结论时，优先使用 [docs/reviews/templates/README.md](templates/README.md) 中的统一模板。

## 与现有文档的关系

本目录中的清单负责“评审时要检查什么”，现有文档负责“项目已经规定了什么”。

例如：

- 命名规范：见 [docs/conventions/naming.md](../conventions/naming.md)
- 错误处理：见 [docs/conventions/error-handling.md](../conventions/error-handling.md)
- 测试规范：见 [docs/conventions/testing.md](../conventions/testing.md)
- 交付流程：见 [docs/delivery/](../delivery/)
- 配置与密钥：见 [docs/operations/config-and-secrets.md](../operations/config-and-secrets.md)

因此，清单中涉及这些主题时，优先引用已有规范，不重复发明另一套规则。

## 目录索引

| 阶段 | 文档 |
| --- | --- |
| 需求评审 | [docs/reviews/requirement-review-checklist.md](requirement-review-checklist.md) |
| 后台设计评审 | [docs/reviews/backend-design-review-checklist.md](backend-design-review-checklist.md) |
| 前端设计评审 | [docs/reviews/frontend-design-review-checklist.md](frontend-design-review-checklist.md) |
| 后台代码评审 | [docs/reviews/backend-code-review-checklist.md](backend-code-review-checklist.md) |
| 前端代码评审 | [docs/reviews/frontend-code-review-checklist.md](frontend-code-review-checklist.md) |
| 测试用例评审 | [docs/reviews/testcase-review-checklist.md](testcase-review-checklist.md) |
| 评审输出模板 | [docs/reviews/templates/README.md](templates/README.md) |

## 当前项目适配说明

结合当前仓库现状，使用这些清单时需注意：

- 当前仓库已包含 `services/callcenter-web` 前端 Service，前端评审清单可用于该 Service 的代码与设计评审。
- 后台设计评审应优先对齐 MySQL 5.7、Spring Boot 2.7、MyBatis-Plus、Flyway 和现有分层架构约束。
- 涉及外部调用时，必须遵守 `ApiClient` 抽象和错误处理规范。
- 涉及交付、配置、发布、回滚时，应同步参考 [docs/delivery/](../delivery/) 与 [docs/operations/](../operations/)。

## 维护规则

- 新增评审阶段时，在本目录补充对应清单。
- 若项目已有规范已覆盖某项检查，评审清单应引用规范而不是重复定义。
- 若评审中反复暴露同一问题，应考虑把该项上升为强制规范或自动化检查。
