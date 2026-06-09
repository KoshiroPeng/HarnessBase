# HarnessBase

HarnessBase 是一个基于若依微服务体系整理的后台管理系统工程基座。仓库主线由 [server](server) 后端微服务、[web](web) 管理后台前端、[deploy](deploy) 发布与观测支撑材料、[docs](docs) 协作文档组成。

这个仓库围绕当前已经落地的微服务结构，提供可开发、可评审、可发布、可持续治理的统一工程入口。

## 项目定位

- 后端是 Maven 多模块微服务工程，承载认证、网关、系统管理、代码生成、定时任务、文件服务和监控能力。
- 前端是 Vue 2 管理后台，承载系统管理、监控、工具等页面与联调入口。
- 文档体系用于把代码入口、模块边界、技术基线、评审清单和发布路径串成统一导航。
- Harness Engineering 在本仓库中的落点是“入口清楚、事实一致、验证可追踪”。

## 仓库导航

| 你要找什么 | 入口 |
| --- | --- |
| 仓库协作规则 | [AGENTS.md](AGENTS.md) |
| 文档总导航 | [docs/README.md](docs/README.md) |
| 系统架构总览 | [docs/architecture/overview.md](docs/architecture/overview.md) |
| 当前代码地图 | [docs/architecture/code-map.md](docs/architecture/code-map.md) |
| 技术基线 | [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md) |
| 后端工程入口 | [server/README.md](server/README.md) |
| 前端工程入口 | [web/README.md](web/README.md) |
| GitHub workflow 入口 | [.github/README.md](.github/README.md) |
| 评审清单与证据模板 | [docs/reviews/README.md](docs/reviews/README.md) |
| 发布与回滚材料 | [deploy/release/README.md](deploy/release/README.md) |

## 模块概览

### 后端

后端根目录是 [server](server)，Maven 根是 [server/pom.xml](server/pom.xml)。

| 模块 | 职责 |
| --- | --- |
| `ruoyi-gateway` | 微服务统一入口、路由与网关过滤 |
| `ruoyi-auth` | 登录认证、鉴权与认证链路 |
| `ruoyi-modules/ruoyi-system` | 系统管理主业务 |
| `ruoyi-modules/ruoyi-gen` | 代码生成服务 |
| `ruoyi-modules/ruoyi-job` | 定时任务服务 |
| `ruoyi-modules/ruoyi-file` | 文件服务 |
| `ruoyi-visual/ruoyi-monitor` | 监控服务 |
| `ruoyi-api` | 服务间远程接口与共享模型 |
| `ruoyi-common` | 公共基础能力 |
| `server/sql` | 数据库脚本事实目录 |

### 前端

前端根目录是 [web](web)，包配置入口是 [web/package.json](web/package.json)。

| 目录 | 职责 |
| --- | --- |
| [web/src/api](web/src/api) | 前端接口请求封装 |
| [web/src/views/system](web/src/views/system) | 系统管理页面 |
| [web/src/views/monitor](web/src/views/monitor) | 监控页面 |
| [web/src/views/tool](web/src/views/tool) | 工具页面 |
| [web/src/router](web/src/router) | 路由配置 |
| [web/src/store](web/src/store) | Vuex 状态管理 |
| [web/src/layout](web/src/layout) | 全局布局 |
| [web/src/components](web/src/components) | 通用组件 |

## 当前技术基线

- 后端：JDK 17、Spring Boot 4.0.3、Spring Cloud 2025.1.0、Spring Cloud Alibaba 2025.1.0.0、Maven 多模块
- 数据与中间件：MyBatis、PageHelper、dynamic-datasource、Druid、Redis、Nacos、Seata 相关公共模块
- 前端：Vue 2、Vue CLI、Element UI、Vuex、Vue Router 3、JavaScript、npm
- 自动化入口：文档护栏与 CI workflow 位于 [.github/workflows](.github/workflows)

详细说明见 [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)。

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

## 建议阅读顺序

1. [AGENTS.md](AGENTS.md)
2. [docs/architecture/code-map.md](docs/architecture/code-map.md)
3. [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)
4. [docs/architecture/overview.md](docs/architecture/overview.md)
5. [server/README.md](server/README.md) 或 [web/README.md](web/README.md)
