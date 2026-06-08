---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 当前迭代计划

## 迭代目标

建立 HernessDemo 的第一版工程与交付基线，让后续开发能够围绕统一的架构、规范、设计、交付治理和参考文档推进。

## 本迭代范围

| 优先级 | 事项 | 产出 |
| --- | --- | --- |
| P0 | 建立项目协作规则 | `AGENTS.md` |
| P0 | 建立架构文档 | `docs/architecture/` |
| P0 | 建立编码规范 | `docs/conventions/` |
| P1 | 建立功能设计占位 | `docs/design/` |
| P1 | 建立 API 与错误码参考 | `docs/reference/` |
| P1 | 建立交付治理文档 | `docs/delivery/`、`docs/operations/`、`docs/governance/` |
| P1 | 建立 GitHub Actions 交付骨架 | `.github/workflows/` |
| P1 | 建立远端主机初始化、发布与回滚脚本 | `deploy/release/` |

## 开发约束

- 不升级 JDK、Spring Boot、Maven、MySQL 或持久化框架。
- 不引入 JPA 或 Hibernate。
- 新增业务代码必须有 JUnit 5 测试。
- 涉及数据库结构时必须通过 Flyway migration 管理。

## 验收标准

- 文档目录结构完整。
- 架构边界能指导后端分层。
- 编码规范覆盖命名、错误、测试和日志。
- API 和错误码有可演进的基线。
- 交付治理覆盖环境、发布、验证、回滚和运行手册。
- 仓库内存在可演练的主机初始化、发布和回滚 workflow 骨架。
- 后续任务可以从 backlog 中拆出。

## 风险

- 当前仓库虽已具备交付治理骨架，但尚未接入真实生产环境与成熟部署平台。
- 功能设计需要在真实需求、数据模型和前端交互确定后继续细化。
- 当前发布与回滚仍依赖最小 SSH/systemd 方案，后续可能演进到更成熟的部署平台。
