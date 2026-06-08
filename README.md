# HernessDemo

HernessDemo 是一个面向中小企业的在线项目管理平台。当前仓库已完成后端工程骨架、架构约束、质量门禁、交付治理文档、本地可观测性配置，以及面向 GitHub Environments 的主机初始化、发布和回滚 workflow 骨架。

当前业务功能仍处于第一版设计阶段。`server/` 已具备 Spring Boot 2.7 + Java 8 的基础工程、Actuator 指标端点、Maven 质量门禁和标准包边界；认证、搜索、计费等 API 目前以 `docs/design/` 和 `docs/reference/api-spec.yaml` 为目标契约，尚未在 Controller/Service/Mapper 中实现。

本仓库已经合并 `/Users/pengkang/Documents/workspace/CallCenter` 的前后台代码，并按 Harness Engineering 思想把它们作为独立 Service 放入 `services/`。这些 Service 保留 CallCenter 原始技术栈和工程结构，不覆盖根目录 `server/`。

## 目录

- [AGENTS.md](AGENTS.md): AI 协作与工程硬约束入口。
- [docs/](docs/): 架构、规范、设计、计划和参考文档。
- [docs/README.md](docs/README.md): 按任务组织的统一文档导航入口。
- [server/](server/): Spring Boot 2.7 + Java 8 后端工程。
- [services/](services/): 从 CallCenter 合并进来的独立 Service。
- [.github/workflows/](.github/workflows/): CI、远端主机初始化、发布和回滚 workflow。
- [deploy/release/](deploy/release/): SSH/systemd 发布、回滚和远端主机初始化脚本。
- [deploy/observability/](deploy/observability/): 本地 Prometheus、Loki、Promtail、Grafana 配置。

## 交付入口

当前交付文档按 Harness Engineering 的对象模型组织：

- `Application`: HernessDemo
- `Service`: `server`、`callcenter-server`、`callcenter-web`
- `Environment`: `dev`、`test`、`staging`、`prod`
- `Artifact`: Java Jar、前端静态产物、构建元数据、发布包
- `Pipeline`: CI、远端主机初始化、发布、回滚
- `Verification`: Actuator 健康检查、Prometheus 指标、业务探针

如果需要快速理解当前仓库的发布、回滚、主机初始化和环境治理入口，优先阅读：

- [docs/delivery/delivery-operations-map.md](docs/delivery/delivery-operations-map.md)

如果需要按“我要开发代码 / 做测试 / 做评审 / 做发布”快速找文档，优先阅读：

- [docs/README.md](docs/README.md)

当前已具备的主要 workflow：

- [.github/workflows/agent-guardrails.yml](.github/workflows/agent-guardrails.yml): CI 质量门禁
- [.github/workflows/bootstrap-remote-host.yml](.github/workflows/bootstrap-remote-host.yml): 首次远端主机初始化
- [.github/workflows/server-release.yml](.github/workflows/server-release.yml): 日常发布
- [.github/workflows/server-rollback.yml](.github/workflows/server-rollback.yml): 异常回滚

## 评审入口

如果需要在需求、设计、代码或测试阶段使用评审清单，优先阅读：

- [docs/reviews/README.md](docs/reviews/README.md)

如果需要按“开发前读什么、开发后怎么自检、评审时看什么”直接导航，优先阅读：

- [docs/README.md#开发后端代码](docs/README.md#开发后端代码)

## 后端验证

根目录 `server` 的 CI 和标准开发环境必须使用 Java 8 + Maven 3.6.3：

```bash
cd server
mvn -B clean verify
```

本机如果暂时不是 JDK 1.8 + Maven 3.6.3，只能在排查工程骨架时临时跳过 Enforcer，不得把该命令作为合并前验收依据：

```bash
cd server
mvn -Denforcer.skip=true verify
```

CallCenter 后端和前端使用独立基线：

```bash
cd services/callcenter-server
mvn -DskipTests package

cd services/callcenter-web
pnpm install
pnpm build:prod
```

## 本地启动

本地无数据库时可以使用 `local` profile 启动健康检查和指标端点。该 profile 会排除数据源和 Flyway 自动配置，只适合验证服务启动、Actuator 和本地观测链路：

```bash
cd server
mvn spring-boot:run -Dspring-boot.run.profiles=local
```

启动后可访问：

- `http://localhost:8080/actuator/health`
- `http://localhost:8080/actuator/prometheus`

## 可观测性

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

- Grafana: `http://localhost:3001`
- Prometheus: `http://localhost:9090`
- Loki: `http://localhost:3100`
