---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 设计文档

本目录保留功能设计文档。当前 CallCenter 主线事实来源优先使用 [docs/specs/](../specs/)；新增呼叫中心领域能力时，应在 `docs/specs/` 或后续领域设计文档中补齐边界，再修改 `services/callcenter-server/` 或 `services/callcenter-web/`。

## 当前文档状态

| 方向 | 文档 | 当前状态 |
| --- | --- | --- |
| 认证与权限 | [feature-auth.md](feature-auth.md) | 历史设计草稿，需按 CallCenter 权限模型重新校准 |
| 搜索 | [feature-search.md](feature-search.md) | 历史设计草稿，非当前呼叫中心主线 |
| 计费 | [feature-billing.md](feature-billing.md) | 历史设计草稿，非第一阶段目标 |

## 维护规则

- CallCenter 新业务实现前，先补最小领域设计，再改 `services/callcenter-server/` 或 `services/callcenter-web/`。
- 电话、坐席、CTI、实时通道、聊天、录音、质检、AI、报表不能只按页面或 CRUD 拆分。
- 设计影响 API、错误码、交付或运维时，同步更新对应目录。
- 废弃设计应标记状态或合并结论，不保留无用草稿。
