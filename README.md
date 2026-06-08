# ProjectPilot

ProjectPilot 是一个面向中小企业的在线项目管理 Web 产品。当前仓库已经明确把主线切换到 `JDK 17 + Spring Boot 3.x + Vue 3 + TypeScript + Vite`，并吸收 `D:\dev\workspace\CallCenter` 中成熟的 Web 工程分区、模块化单体和部署支撑思路，用来重构本项目的目标架构。

需要特别说明的是：当前仓库仍可能保留历史命名、目录结构和少量升级后待收敛内容。这里是在说明“当前仍有遗留”，不是在重申现行约束。`server/` 已经完成 `JDK 17 + Spring Boot 3.3.x` 的最小迁移验证，`compile`、`test` 和 `verify` 已在新基线下通过；更完整的结构收敛与 `web/` 落地仍需继续推进。迁移步骤见 [docs/plans/jdk17-springboot3-migration-roadmap.md](docs/plans/jdk17-springboot3-migration-roadmap.md)。

命名上，文档、产品说明和接口标题统一使用 `ProjectPilot`；脚本、服务名、制品名和类名中的 `herness-demo`、`Harness-demo`、`HernessDemo` 暂视为历史技术标识保留。

## 快速入口

- [AGENTS.md](AGENTS.md)：AI 协作规则、目标技术基线与工程护栏入口
- [docs/README.md](docs/README.md)：按任务场景组织的统一文档导航
- [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)：新的技术基线定义
- [docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md)：如何吸收 CallCenter 的工程结构参考
- [docs/plans/jdk17-springboot3-migration-roadmap.md](docs/plans/jdk17-springboot3-migration-roadmap.md)：JDK 17 / Spring Boot 3 迁移路线
- [docs/design/web-mvp-roadmap.md](docs/design/web-mvp-roadmap.md)：当前 Web MVP 主线
- [docs/reviews/README.md](docs/reviews/README.md)：需求、设计、代码、测试评审入口
- [deploy/release/README.md](deploy/release/README.md)：发布与回滚支撑材料
- [deploy/observability/README.md](deploy/observability/README.md)：可观测性支撑材料

## 当前目标技术栈

### 后端

- JDK 17 LTS
- Spring Boot 3.x
- Maven 3.9+
- MyBatis-Plus + Flyway
- MySQL 8.x
- SpringDoc / OpenAPI
- Micrometer + Actuator

### 前端

- Vue 3
- TypeScript
- Vite
- Vue Router
- Pinia
- Node 20 LTS+
- `pnpm`

### 部署

- Docker Compose
- Nginx
- GitHub Actions + SSH 发布骨架
- 渐进式观测与发布验证材料

## 这次融合吸收了什么

来自 `CallCenter` 的有效参考主要有三类：

1. 顶层目录继续按 `docs / server / web / deploy` 分区，强化可导航性。
2. 后端目标结构切到“模块化单体 + adapter 隔离”，避免继续围绕旧脚手架堆积。
3. 前端明确采用现代 Web 工具链，并为 `apps / packages / tooling` 结构预留空间。

对应说明见 [docs/architecture/callcenter-reference-adaptation.md](docs/architecture/callcenter-reference-adaptation.md)。

## 当前主线

当前阶段优先推进以下几件事：

- 完成文档主线从旧基线到新基线的统一切换
- 明确后端模块化单体目标结构
- 明确前端 `web/` 的目标工程形态
- 为后续 JDK 17 / Spring Boot 3 代码迁移准备路线、边界和验证标准
- 继续让 Harness Engineering 服务于“更稳地交付 Web 产品”，而不是把项目重新推回平台化主线

## 当前缺口

当前最需要继续推进的是：

- `server/` 从“已完成基线升级”继续收敛到目标模块化单体结构
- `web/` 目标工程初始化与页面主链路落地
- 前后端联调闭环
- 发布、联调、观测材料与新基线对齐

## 可观测性

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

- Grafana：`http://localhost:3001`
- Prometheus：`http://localhost:9090`
- Loki：`http://localhost:3100`
