---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 系统架构总览，说明目标基线、目标结构、当前现状与关键约束。
---

# 系统架构概览

## 项目定位

ProjectPilot 是一个面向中小企业的在线项目管理 Web 产品，核心目标是支撑项目、任务、成员、权限、搜索和计费等协作场景。

当前阶段的建设主线是 Web 产品 MVP，而不是继续扩展交付平台能力。发布、回滚、环境与可观测性材料仍然保留，但在当前阶段属于支撑层。

## 目标基线

当前项目目标基线由 [docs/architecture/target-technology-baseline.md](target-technology-baseline.md) 定义：

- JDK 17 LTS
- Spring Boot 3.x
- Maven 3.9+
- MySQL 8.x，字符集 `utf8mb4`
- MyBatis-Plus Boot 3 + Flyway
- Vue 3 + TypeScript + Vite
- Node 20 LTS+ + `pnpm`

## 当前现状说明

当前仓库文档主线已经切到新基线，后端最小可运行基线也已完成验证，但整体工程仍处于迁移收敛阶段：

- `server/` 已在 `JDK 17 + Spring Boot 3.3.x` 下完成 `compile`、`test` 和 `verify` 验证，但模块结构仍是过渡态。
- `web/` 目标工程尚未完整建立。
- 部署脚本与工作流仍带有历史命名。

因此，当前架构工作分成两层：

1. 文档与入口先统一目标方向。
2. 后端继续从“版本升级完成”收敛到“结构目标完成”。
3. 前端与交付链路再按迁移路线逐步补齐。

迁移步骤见 [docs/plans/jdk17-springboot3-migration-roadmap.md](../plans/jdk17-springboot3-migration-roadmap.md)。

## 推荐目录结构

```text
.
├── AGENTS.md
├── README.md
├── docs/
├── server/
├── web/
└── deploy/
```

- `docs/`：架构、规范、设计、计划、参考与评审文档。
- `server/`：后端服务与后端迁移主目录。
- `web/`：Web 前端应用与共享包。
- `deploy/`：发布、回滚、环境变量、可观测性等支撑材料。

## 目标后端结构

结合 CallCenter 的工程结构经验，ProjectPilot 的目标后端形态是轻量化模块化单体：

```text
server/
├── bootstrap/
├── shared/
├── modules/
│   ├── auth/
│   ├── organization/
│   ├── project/
│   ├── task/
│   └── billing/
├── integration/
└── script/
```

- `bootstrap/`：Spring Boot 启动、装配、统一配置入口。
- `shared/`：稳定的共享基础能力与公共契约。
- `modules/`：按业务边界组织的模块。
- `integration/`：第三方系统、对象存储、消息、支付等外围集成。
- `script/`：迁移、数据处理和运维辅助脚本。

## 目标前端结构

ProjectPilot 的 Web 工程吸收 CallCenter 的前端工程化思路，但按当前规模做轻量化启动：

```text
web/
├── apps/
│   └── projectpilot-web/
├── packages/
│   ├── shared-ui/
│   ├── shared-api/
│   └── config/
└── tooling/
```

- `apps/`：具体前端应用入口。
- `packages/shared-ui/`：共享 UI 组件与设计约束。
- `packages/shared-api/`：接口客户端、类型定义和请求适配。
- `packages/config/`：ESLint、TSConfig、构建共享配置。
- `tooling/`：脚本、生成器和本地开发辅助能力。

## 后端模块内部结构

单个模块建议按以下方式组织：

```text
modules/project/
├── domain/
├── application/
└── adapter/
    ├── in/web/
    └── out/persistence/
```

- `domain/`：领域模型、值对象、核心规则。
- `application/`：业务用例、事务边界、跨对象编排。
- `adapter/in/web/`：HTTP 输入适配。
- `adapter/out/persistence/`：数据库访问、Mapper 与持久化适配。

更细的依赖规则见 [docs/architecture/boundaries.md](boundaries.md)。

## 数据与迁移

数据库主线切换到 MySQL 8.x，所有结构变更必须通过 Flyway migration 管理。业务代码、实体和 SQL 片段不能替代数据库迁移脚本。

迁移脚本应满足：

- 可以在空库上顺序执行。
- 可以在测试环境重复验证。
- 优先使用项目主线允许的 MySQL 8 语法，但需评估索引、兼容性和回滚风险。
- 涉及兼容性风险时，在文档中说明回滚方案或补偿方案。

## 外部交互

外部系统调用必须通过 adapter 或 `ApiClient` 抽象接入，禁止在业务代码中裸用 HTTP 客户端或把第三方 SDK 直接扩散到核心模块。

认证、日志、审计、telemetry、cache 等横切能力必须通过 Spring 注入，不允许手动 `new` 实例化。

## 质量门禁

新增业务代码必须满足：

- 使用构造器注入，禁止字段级 `@Autowired`。
- 新代码统一使用 `jakarta.*` 命名空间。
- 单个 `.java` 文件不超过 300 行。
- 单个方法不超过 50 行。
- 使用 SLF4J `Logger`，禁止 `System.out.println` 和 `e.printStackTrace()`。
- 有对应测试；后端默认 JUnit 5，前端默认 Vitest。

## 相关入口

- [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)
- [docs/architecture/callcenter-reference-adaptation.md](callcenter-reference-adaptation.md)
- [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)
- [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md)
- [docs/plans/jdk17-springboot3-migration-roadmap.md](../plans/jdk17-springboot3-migration-roadmap.md)
