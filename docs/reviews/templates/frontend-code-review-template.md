---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 前端代码评审输出模板，用于统一记录前端代码评审结论与整改项。
---

# 前端代码评审输出模板

关联清单：

- [docs/reviews/frontend-code-review-checklist.md](../frontend-code-review-checklist.md)
- [docs/design/backend-admin-roadmap.md](../../design/backend-admin-roadmap.md)
- [docs/conventions/task-startup-checklist.md](../../conventions/task-startup-checklist.md)

```md
# 前端代码评审结论

## 基本信息

- 变更名称：
- 评审时间：
- 评审人：
- 关联需求或缺陷：
- 关联代码范围：

## 评审结论

- 结论：通过 / 有条件通过 / 不通过
- 结论说明：

## 核心检查结果

- 命名、注释与结构是否清晰：
- 表单校验、接口结果校验与异常提示是否完整：
- 定时器、事件监听、异步请求是否安全可控：
- DOM 操作与返回数据量是否存在性能风险：
- 公共组件或公共方法变更是否评估影响范围：
- 是否补齐必要的测试、验证或回归说明：
- 是否符合当前 Vue 2 / JavaScript / Vue CLI 与现有 `web/src` 边界：

## 发现问题

| 序号 | 问题描述 | 严重级别 | 建议动作 | 责任人 |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |
```
