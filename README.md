# HarnessBase

HarnessBase 当前是一个基于若依微服务结构整理的后台管理系统工作区。真实代码主线由 [server](server) 后端、[web](web) 前端、[deploy](deploy) 发布与观测支撑材料、[docs](docs) 协作文档组成。

当前仓库已经不再是之前文档中描述的 `RuoYi-Vue-Plus` 单体后台，也不是过渡阶段里假设的业务 MVP。后续阅读、开发、评审和发布，都应以当前微服务代码事实为准。

## 快速入口

- [AGENTS.md](AGENTS.md)：AI 协作规则、编码要求、Git 规则与任务入口
- [docs/README.md](docs/README.md)：按任务场景组织的文档导航
- [docs/architecture/code-map.md](docs/architecture/code-map.md)：当前代码地图与模块事实
- [docs/architecture/overview.md](docs/architecture/overview.md)：系统架构总览
- [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)：当前技术基线
- [server/README.md](server/README.md)：后端工程入口与服务导航
- [web/README.md](web/README.md)：前端工程入口与运行命令
- [.github/README.md](.github/README.md)：GitHub Actions 与发布 workflow 入口
- [docs/reviews/README.md](docs/reviews/README.md)：评审清单与验证证据入口
- [deploy/release/README.md](deploy/release/README.md)：发布支撑材料

## 当前代码画像

后端位于 [server](server)，Maven 根为 [server/pom.xml](server/pom.xml)。当前真实结构包括：

- 网关服务：`ruoyi-gateway`
- 认证服务：`ruoyi-auth`
- 公共能力：`ruoyi-common`
- 远程接口：`ruoyi-api`
- 业务服务：`ruoyi-system`、`ruoyi-gen`、`ruoyi-job`、`ruoyi-file`
- 可视化监控：`ruoyi-visual/ruoyi-monitor`
- SQL 脚本：`server/sql`

前端位于 [web](web)，配置入口为 [web/package.json](web/package.json)。当前真实技术栈包括：

- Vue 2
- Vue CLI
- Element UI
- Vuex
- Vue Router 3
- JavaScript

## 常用命令

后端：

```bash
cd server
mvn -B -DskipTests package
mvn -B test
```

前端：

```bash
cd web
npm install
npm run dev
npm run build:prod
```

本地观测：

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

## 当前重点

- 让文档、代码事实、发布材料和 Harness Engineering 护栏保持一致。
- 防止旧单体结构、旧包名、旧 SQL 路径和错误前端栈说明回流到新文档。
- 保留当前若依微服务边界，新增能力优先沿用现有 `ruoyi-*` 模块与 `web/src/*` 结构扩展。
- 把开发、评审、测试、发布中的高频规则沉淀为可导航、可验证、可自动化检查的材料。
