# HernessDemo

HernessDemo 是一个面向中小企业的在线项目管理平台。当前仓库已完成后端工程骨架、架构约束、质量门禁、交付治理文档、本地可观测性配置，以及面向 GitHub Environments 的主机初始化、发布和回滚 workflow 骨架。

## 目录

- [AGENTS.md](AGENTS.md): AI 协作与工程硬约束入口。
- [docs/](docs/): 架构、规范、设计、计划和参考文档。
- [server/](server/): Spring Boot 2.7 + Java 8 后端工程。
- [deploy/observability/](deploy/observability/): 本地 Prometheus、Loki、Promtail、Grafana 配置。

## 交付入口

如果需要快速理解当前仓库的发布、回滚、主机初始化和环境治理入口，优先阅读：

- [docs/delivery/delivery-operations-map.md](docs/delivery/delivery-operations-map.md)

当前已具备的主要 workflow：

- [.github/workflows/agent-guardrails.yml](.github/workflows/agent-guardrails.yml): CI 质量门禁
- [.github/workflows/bootstrap-remote-host.yml](.github/workflows/bootstrap-remote-host.yml): 首次远端主机初始化
- [.github/workflows/server-release.yml](.github/workflows/server-release.yml): 日常发布
- [.github/workflows/server-rollback.yml](.github/workflows/server-rollback.yml): 异常回滚

## 后端验证

本机如果不是 JDK 1.8 + Maven 3.6.3，可临时跳过 Enforcer 做框架验证：

```bash
cd server
mvn -Denforcer.skip=true verify
```

CI 和标准开发环境应使用项目基线，直接执行：

```bash
cd server
mvn verify
```

## 本地启动

本地无数据库时可以使用 `local` profile 启动健康检查和指标端点：

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
