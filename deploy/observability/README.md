# 本地可观测性

本目录提供轻量级本地可观测性堆栈：

这些材料的定位是开发与发布支撑层，用于帮助定位问题、验证系统状态，不应替代当前 Web MVP 主线建设。

- Prometheus: `http://localhost:9090`
- Grafana: `http://localhost:3001`
- Loki: `http://localhost:3100`

启动可观测性组件：

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

启动后端时启用本地可观测性配置：

```bash
cd server
mvn spring-boot:run -Dspring-boot.run.profiles=local
```

Grafana 默认账号密码均为 `admin`。Prometheus 会抓取 `http://host.docker.internal:8080/actuator/prometheus`，Promtail 会采集 `server/logs/*.log` 并发送到 Loki。

## 配套入口

- [docs/README.md](../../docs/README.md)：按任务场景查看还需要联读哪些文档。
- [deploy/release/release-checklist.md](../release/release-checklist.md)：如果本次观测用于发布验证，和发布检查清单一起使用。
- [docs/conventions/logging.md](../../docs/conventions/logging.md)：查看日志输出规范。
- [docs/conventions/testing.md](../../docs/conventions/testing.md)：查看测试与验证基线。

## 纠偏提醒

- 若当前没有真实主链路需要观测，优先保持最小可用，不要超前扩张观测体系。
- 若讨论中引用 Harness Engineering，应理解为“补齐定位与验证能力”，而不是单独建设观测平台。
