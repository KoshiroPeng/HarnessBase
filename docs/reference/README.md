---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 参考文档总览

## 目标

本目录沉淀 HernessDemo 的对外协议和共享参考资料，帮助开发、测试和评审快速找到接口契约和错误码基线。

当前阶段，本目录遵循“Web MVP 主线优先、后续能力边界预留”的维护原则。也就是说，接口和错误码可以先描述能力边界，但不应误导为所有能力都已进入当前迭代实现。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| API 规范 | [docs/reference/api-spec.yaml](api-spec.yaml) |
| 错误码 | [docs/reference/error-codes.md](error-codes.md) |

## 使用建议

- 如果要先判断接口是否属于当前实现范围，先阅读 [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)。
- 如果要判断某个 API 或错误码是否存在范围偏航，先阅读 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)。
- 如果要理解为什么本目录要作为“事实参考层”维护，可补充阅读 [docs/architecture/harness-engineering-reference.md](../architecture/harness-engineering-reference.md)。
- 开发接口前，先阅读 API 规范和错误码文档。
- 需求、设计、代码和测试评审若涉及接口协议，优先把本目录作为统一依据。
- 涉及错误响应、状态码或接口字段变化时，必须同步更新本目录。

## 推荐阅读顺序

1. [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)
2. [docs/reference/api-spec.yaml](api-spec.yaml)
3. [docs/reference/error-codes.md](error-codes.md)
4. [docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md)

## 维护规则

- API 变更必须同步更新 [docs/reference/api-spec.yaml](api-spec.yaml)。
- 错误码变更必须同步更新 [docs/reference/error-codes.md](error-codes.md)。

## 与开发评审的关系

- 开发接口前，先读 [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md) 判断是否属于当前主线。
- 做后端设计评审时，结合 [docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md) 使用本目录。
- 做后端代码自检时，若改动涉及响应结构、状态码或异常映射，结合 [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md) 一起检查。
