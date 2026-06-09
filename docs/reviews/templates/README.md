---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 评审输出模板目录入口，汇总通用评审输出模板与验证证据模板。
---

# 评审输出模板总览

## 目标

本目录提供 HarnessBase 的通用评审输出模板和验证证据模板，帮助 AI 与人工评审按同一结构记录结论、问题、验证结果和后续动作。

## 使用原则

- 清单负责“检查什么”。
- 模板负责“如何输出结果”。
- 模板不重复定义规则，规则仍以 [docs/reviews/README.md](../README.md) 及相关规范文档为准。

## 模板索引

| 场景 | 模板 |
| --- | --- |
| 通用评审输出 | [docs/reviews/templates/review-output-template.md](review-output-template.md) |
| 验证证据输出 | [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md) |

## 使用建议

- AI 在执行评审或自检时，应先选择对应评审清单，再使用通用模板记录结论。
- 若评审结果需要沉淀到 issue、PR 评论、评审纪要或测试记录中，优先复用模板结构，不要临时自由发挥。
- 功能开发、自检、测试验证、发布验证完成后，建议额外使用 [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md) 统一沉淀验证结果。
- 自动化检查脚本试运行、CI 检查结果回顾或阻断策略评估时，直接使用 [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md) 记录结论。
- 若评审或验证涉及 SQL、workflow、发布路径或前端结构调整，建议在模板中显式写出“是否匹配当前代码事实”和“还需补哪些验证证据”。

## 推荐阅读顺序

1. [docs/reviews/README.md](../README.md)
2. 对应阶段的评审清单
3. [docs/reviews/templates/review-output-template.md](review-output-template.md)
4. 对应的设计、规范、API 或发布支撑文档

## 维护规则

- 新增评审场景时，优先新增或调整评审清单，不要为每个阶段新增独立输出模板。
- 若模板中的字段长期无人使用，应继续收敛而不是扩张。
