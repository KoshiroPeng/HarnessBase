---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 目标技术基线文档，定义 JDK 17、Spring Boot 3.x、Web 工程与部署主线约束。
---

# 目标技术基线

## 目标

本文档定义 ProjectPilot 的目标技术基线，用于替代历史 `Java 8 / Spring Boot 2.7 / MySQL 5.7` 约束，作为后续文档、设计、迁移和代码收敛的统一依据。

如果需要查看迁移步骤，继续阅读 [docs/plans/jdk17-springboot3-migration-roadmap.md](../plans/jdk17-springboot3-migration-roadmap.md)。

## 后端基线

- JDK 17 LTS。
- Spring Boot 3.x。
- Spring Framework 6。
- Maven 3.9+。
- MyBatis-Plus Boot 3 体系。
- Flyway 管理数据库迁移。
- SpringDoc / OpenAPI 作为接口文档基线。
- Micrometer + Actuator 作为运行时观测基础。

## 数据与基础设施基线

- MySQL 8.x，字符集统一使用 `utf8mb4`。
- Redis 作为可选缓存、分布式锁或会话支撑组件。
- 对象存储、短信、第三方登录等外围能力按需引入，但必须通过 adapter 隔离。
- 部署形态优先支持 Docker Compose + Nginx 的单仓库交付方式。

## Web 基线

- Vue 3。
- TypeScript。
- Vite。
- Vue Router。
- Pinia。
- 组件层优先沿用成熟后台 UI 体系，但不把某个脚手架命名硬绑定为长期架构边界。
- Node 20 LTS+。
- 推荐 `pnpm` 作为包管理器。
- 默认补齐 ESLint、Prettier、Vitest 等基础工程能力。

## 架构约束

- 后端采用模块化单体，避免在业务尚未稳定前过早拆微服务。
- 模块内依赖按 `domain -> application -> adapter` 收敛。
- 模块间依赖通过共享契约、应用服务接口或事件完成，禁止跨模块直接调用控制器或持久化层。
- 外部系统调用必须走 adapter，不把第三方 SDK 直接扩散进业务主流程。
- 新代码统一使用 `jakarta.*`，不再继续扩张 `javax.*` 旧命名空间。

## 不再沿用的旧主线限制

以下旧约束不再作为当前项目文档主线继续维护：

- 强制停留在 JDK 1.8。
- 强制停留在 Spring Boot 2.7。
- 以 MySQL 5.7 兼容性作为新增设计默认前提。
- 因历史运行环境而冻结前端工程结构。

## 当前现状说明

当前仓库代码与工程材料仍可能存在历史残留，例如：

- `server/` 虽已完成 `JDK 17 + Spring Boot 3.3.x` 的最小验证闭环，但模块结构、命名和部分注释仍有过渡期残留。
- 目录与脚本中仍存在历史命名。
- `web/` 目标工程尚未完整建立。

因此，本文档描述的是“当前目标主线”，也是后端当前已验证通过的版本基线；但它不代表所有代码和工程结构都已经完成最终形态迁移。实际迁移进度见 [docs/plans/current-sprint.md](../plans/current-sprint.md) 与 [docs/plans/jdk17-springboot3-migration-roadmap.md](../plans/jdk17-springboot3-migration-roadmap.md)。

## 与 Harness Engineering 的关系

Harness Engineering 在这里的作用，是把技术基线显式化、可导航化、可验证化：

- 让开发者和 AI 不再在旧基线和新基线之间摇摆。
- 让评审、测试、发布围绕同一套目标主线收敛。
- 让升级迁移不只停留在口头讨论，而是进入可执行的文档闭环。
