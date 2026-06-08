# ProjectPilot

ProjectPilot 是一个面向中小企业的在线项目管理 Web 产品。当前仓库的主线目标不是继续扩展“交付平台化”能力，而是先完成登录、项目、任务、成员与权限这些核心协作场景的第一阶段 MVP。

当前仓库已经具备后端工程骨架、基础架构约束、评审清单、测试规范、API 与错误码文档，以及一套可继续复用的发布与可观测性材料；真正还需要重点推进的是 `web/` 前端工程与前后端业务闭环。

命名上，文档、产品说明和接口标题统一使用 `ProjectPilot`；脚本、服务名、制品名和类名中的 `herness-demo`、`Harness-demo`、`HernessDemo` 暂视为历史技术标识保留。

## 快速入口

- [AGENTS.md](AGENTS.md)：AI 协作规则与工程硬约束入口
- [docs/README.md](docs/README.md)：按任务场景组织的统一文档导航
- [docs/design/web-mvp-roadmap.md](docs/design/web-mvp-roadmap.md)：当前 Web MVP 主线
- [docs/conventions/task-startup-checklist.md](docs/conventions/task-startup-checklist.md)：开发、评审、测试、发布任务启动清单
- [docs/plans/task-status-template.md](docs/plans/task-status-template.md)：统一记录任务执行状态
- [docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md)：统一沉淀验证证据
- [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md)：Harness Engineering 在本项目中的正确用法
- [docs/architecture/harness-engineering-reference.md](docs/architecture/harness-engineering-reference.md)：Harness Engineering 完整参考手册与当前 Codex 协作环境映射
- [docs/plans/current-sprint.md](docs/plans/current-sprint.md)：当前迭代计划
- [docs/reviews/README.md](docs/reviews/README.md)：需求、设计、代码、测试评审入口
- [deploy/release/README.md](deploy/release/README.md)：发布与回滚材料入口
- [deploy/observability/README.md](deploy/observability/README.md)：本地可观测性材料入口

## 当前主线

当前阶段优先完成以下产品闭环：

- 登录与会话校验
- 项目列表与项目详情
- 任务列表、创建、编辑与状态流转
- 成员与角色的最小权限控制
- 前后端联调与 MVP 验收路径

工程方法上，继续参考 Harness Engineering，但只把它当作“工程约束、导航和验证方法”，不再把它当作当前产品范围本身。

建议先阅读：

- [docs/design/web-mvp-roadmap.md](docs/design/web-mvp-roadmap.md)
- [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md)
- [docs/architecture/harness-engineering-reference.md](docs/architecture/harness-engineering-reference.md)
- [docs/plans/task-status-template.md](docs/plans/task-status-template.md)
- [docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md)
- [docs/design/README.md](docs/design/README.md)
- [docs/plans/current-sprint.md](docs/plans/current-sprint.md)

## 工程支撑材料

如果当前任务是发布、回滚、主机初始化、环境变量准备或上线后验证，直接看：

- [deploy/release/README.md](deploy/release/README.md)
- [deploy/release/release-checklist.md](deploy/release/release-checklist.md)
- [deploy/release/environment-variable-template.md](deploy/release/environment-variable-template.md)

如果当前任务是本地观测、指标采集和日志采集，直接看：

- [deploy/observability/README.md](deploy/observability/README.md)

## 评审入口

如果要在需求、设计、代码或测试阶段使用评审清单，直接看：

- [docs/reviews/README.md](docs/reviews/README.md)

如果要按“开发前读什么、开发后怎么自检、评审时看什么”快速导航，直接看：

- [docs/README.md](docs/README.md)

## 后端验证

本机如果不是 JDK 1.8 + Maven 3.6.3，可临时跳过 Enforcer 做结构性验证：

```bash
cd server
mvn -Denforcer.skip=true verify
```

标准开发环境与 CI 应使用项目基线：

```bash
cd server
mvn verify
```

## 本地启动

本地没有数据库时，可以使用 `local` profile 启动健康检查与指标端点：

```bash
cd server
mvn spring-boot:run -Dspring-boot.run.profiles=local
```

启动后可访问：

- `http://localhost:8080/actuator/health`
- `http://localhost:8080/actuator/prometheus`

## 当前缺口

当前最需要继续建设的是：

- `web/` 前端工程
- 核心业务模块实现
- 页面、路由与交互结构
- 前后端联调能力
- MVP 验收路径

## 可观测性

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

- Grafana：`http://localhost:3001`
- Prometheus：`http://localhost:9090`
- Loki：`http://localhost:3100`
