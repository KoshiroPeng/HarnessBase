---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# Services

本目录存放从 CallCenter 合并进来的独立 Service。它们作为 Harness Engineering 视角下的独立可交付单元管理，不覆盖根目录现有的 `server/` 工程。

## Service 清单

| Service | 路径 | 技术栈 | 构建入口 |
| --- | --- | --- | --- |
| `callcenter-server` | [callcenter-server](callcenter-server) | Java 17 + Spring Boot 3.5.14 + RuoYi-Vue-Plus 裁剪版 | `cd services/callcenter-server && mvn -DskipTests package` |
| `callcenter-web` | [callcenter-web](callcenter-web) | Vue 3 + TypeScript + Vite + Element Plus + pnpm | `cd services/callcenter-web && pnpm install && pnpm build:prod` |

## 边界

- `services/callcenter-server` 和 `services/callcenter-web` 保留 CallCenter 原始工程结构，便于后续作为独立 Service 接入 CI/CD。
- 根目录 `server/` 仍是 HernessDemo 的 Java 8 + Spring Boot 2.7 后端骨架，继续使用原有质量门禁。
- 不要把 CallCenter 的 Java 17 / Spring Boot 3 规则套到根 `server/`，也不要把根 `server/` 的 Java 8 规则套到 CallCenter 服务。

