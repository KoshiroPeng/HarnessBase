---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 通用评审输出模板，用于统一记录需求、设计、代码和测试用例评审结论。
---

# 通用评审输出模板

## 目标

本模板统一承载需求评审、后台设计评审、前端设计评审、后台代码评审、前端代码评审和测试用例评审的输出格式。

具体“检查什么”仍以对应评审清单为准；本模板只解决“如何记录结论、问题和后续动作”。

## 关联清单

- [docs/reviews/requirement-review-checklist.md](../requirement-review-checklist.md)
- [docs/reviews/backend-design-review-checklist.md](../backend-design-review-checklist.md)
- [docs/reviews/frontend-design-review-checklist.md](../frontend-design-review-checklist.md)
- [docs/reviews/backend-code-review-checklist.md](../backend-code-review-checklist.md)
- [docs/reviews/frontend-code-review-checklist.md](../frontend-code-review-checklist.md)
- [docs/reviews/testcase-review-checklist.md](../testcase-review-checklist.md)

```md
# 评审结论

## 基本信息

- 评审类型：需求 / 后台设计 / 前端设计 / 后台代码 / 前端代码 / 测试用例
- 对象名称：
- 评审时间：
- 评审人：
- 关联需求 / 缺陷 / 任务：
- 关联文档或代码范围：

## 评审结论

- 结论：通过 / 有条件通过 / 不通过
- 结论说明：

## 核心检查结果

- 是否匹配当前代码地图和技术基线：
- 是否符合当前模块边界：
- 是否覆盖接口、权限、SQL、错误码、发布或观测影响：
- 是否补齐测试、回归或验证证据：
- 是否存在历史路径、旧技术栈或过早平台化问题：

## 发现问题

| 序号 | 问题描述 | 风险等级 | 建议动作 | 责任人 |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

## 待补材料

- 

## 后续动作

- 
```

## 使用提醒

- 使用前先选择对应评审清单，不要只套模板不做检查。
- 如果结论是“有条件通过”，必须写清条件和责任人。
- 如果本次评审涉及高风险变更，补充 [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md)。
- 如果发现同类问题反复出现，优先回写规范或自动化检查，而不是继续增加新模板。
