---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 评审输出模板总览

## 目标

本目录提供 HernessDemo 在需求评审、设计评审、代码评审和测试用例评审中的统一输出模板，帮助 AI 与人工评审都按相同结构记录结论、问题和后续动作。

## 使用原则

- 清单负责“检查什么”。
- 模板负责“如何输出结果”。
- 模板不重复定义规则，规则仍以 [docs/reviews/README.md](../README.md) 及相关规范文档为准。

## 模板索引

| 场景 | 模板 |
| --- | --- |
| 需求评审输出 | [docs/reviews/templates/requirement-review-template.md](requirement-review-template.md) |
| 后台设计评审输出 | [docs/reviews/templates/backend-design-review-template.md](backend-design-review-template.md) |
| 后台代码评审输出 | [docs/reviews/templates/backend-code-review-template.md](backend-code-review-template.md) |
| 测试用例评审输出 | [docs/reviews/templates/testcase-review-template.md](testcase-review-template.md) |

## 使用建议

- AI 在执行评审或自检时，应优先套用对应模板，再引用相关清单逐项填写。
- 若评审结果需要沉淀到 issue、PR 评论、评审纪要或测试记录中，优先复用模板结构，不要临时自由发挥。
- 若后续启用 `web/` 前端应用，再补充前端设计评审和前端代码评审模板。

## 维护规则

- 新增评审场景时，应同步补齐对应模板。
- 若模板中的字段长期无人使用，应收敛而不是继续扩张。
