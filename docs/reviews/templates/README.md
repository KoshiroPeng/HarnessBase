---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 评审输出模板

本目录只提供评审结论输出格式。评审规则以 [docs/reviews/README.md](../README.md) 和对应清单为准。

## 当前模板

| 场景 | 模板 |
| --- | --- |
| 需求评审 | [requirement-review-template.md](requirement-review-template.md) |
| 后台设计评审 | [backend-design-review-template.md](backend-design-review-template.md) |
| 后台代码评审 | [backend-code-review-template.md](backend-code-review-template.md) |
| 测试用例评审 | [testcase-review-template.md](testcase-review-template.md) |

## 维护规则

- 新增评审场景时补对应模板。
- 长期不用的字段应收敛。
- `services/callcenter-web` 已合并，后续如前端评审需要固定输出格式，应补充前端设计和前端代码评审模板。
