---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 设计文档

本目录保存仍服务当前落地的功能设计。设计文档是业务实现前的事实来源，不做过程档案馆。

## 当前文档

| 方向 | 文档 |
| --- | --- |
| 认证与权限 | [feature-auth.md](feature-auth.md) |
| 搜索 | [feature-search.md](feature-search.md) |
| 计费 | [feature-billing.md](feature-billing.md) |

## 维护规则

- 新业务实现前，先补最小设计，再改 `server/`。
- 设计影响 API、错误码、交付或运维时，同步更新对应目录。
- 废弃设计应标记状态或合并结论，不保留无用草稿。
