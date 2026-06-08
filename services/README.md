---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# Services

本目录存放当前项目的正式前后台工程。CallCenter 后端与前端作为独立可交付 Service 管理。

## Service 清单

| Service | 路径 | 技术栈 | 构建入口 |
| --- | --- | --- | --- |
| `callcenter-server` | [callcenter-server](callcenter-server) | Java 17 + Spring Boot 3.5.14 + RuoYi-Vue-Plus 裁剪版 | `cd services/callcenter-server && mvn -DskipTests package` |
| `callcenter-web` | [callcenter-web](callcenter-web) | Vue 3 + TypeScript + Vite + Element Plus + pnpm | `cd services/callcenter-web && pnpm install && pnpm build:prod` |

## 边界

- `services/callcenter-server` 是当前项目完整后台，后续呼叫中心后端能力从这里扩展。
- `services/callcenter-web` 是当前项目前端，后续坐席工作台、话务条、来电弹屏和聊天界面从这里扩展。
- 根目录 `server/` 是历史工程骨架，不再作为当前项目主后台入口。
- 新增业务前先对齐 [docs/specs/](../docs/specs/) 或对应领域设计文档。
