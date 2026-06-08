# 部署目录

`deploy/` 存放 Docker Compose 编排和一键运维脚本。

## 文件说明

- `compose.yml`：MySQL、Redis、MinIO 基础设施。
- `compose.app.yml`：后端 `admin` 和前端 `web` 应用服务。
- `ops`：统一部署和排障入口。

## 常用命令

```bash
./deploy/ops start
./deploy/ops start --app
./deploy/ops stop
./deploy/ops restart
./deploy/ops build
./deploy/ops status
./deploy/ops logs
./deploy/ops health
```

## 注意事项

- `ops` 可从任意目录调用，但 README 中统一使用仓库根目录下的 `./deploy/ops` 写法。
- Compose 文件中的相对路径通过仓库根目录解析。
- 生产环境的数据库、Redis 和对象存储高可用方案需要结合客户机房环境单独确认。
