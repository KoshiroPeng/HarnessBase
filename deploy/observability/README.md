# 本地可观测性

本目录提供轻量级本地可观测性堆栈：

- Prometheus: http://localhost:9090
- Grafana: http://localhost:3001
- Loki: http://localhost:3100

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
