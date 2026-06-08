# CallCenter

CallCenter 是面向客户本地机房私有化部署的企业级呼叫中心 Web 平台。当前项目以前后台代码为主体：`services/callcenter-server/` 是完整 Java 后端工程，`services/callcenter-web/` 是完整 Vue 前端工程。

根目录 `server/` 仅作为历史工程骨架保留，不再作为当前项目主后台入口。新增呼叫中心业务能力应进入 `services/callcenter-server/` 或 `services/callcenter-web/`。

## 目录

- [AGENTS.md](AGENTS.md): AI 协作规则入口。
- [docs/specs/](docs/specs/): CallCenter 产品范围、规模、部署约束、技术方案和工程结构事实来源。
- [docs/](docs/): 架构、规范、设计、交付、运维、治理和评审文档。
- [services/callcenter-server/](services/callcenter-server/): CallCenter 完整后台。
- [services/callcenter-web/](services/callcenter-web/): CallCenter 前端。
- [deploy/](deploy/): Docker Compose、发布脚本、可观测性和运维入口。
- [.github/workflows/](.github/workflows/): CI、远端主机初始化、发布和回滚 workflow。

## 快速开始

后端构建：

```bash
cd services/callcenter-server
mvn -DskipTests package
```

前端构建：

```bash
cd services/callcenter-web
pnpm install
pnpm build:prod
```

本地基础设施：

```bash
./deploy/ops start
./deploy/ops health
```

本地基础设施 + 应用容器：

```bash
./deploy/ops start --app
./deploy/ops health
```

## 文档入口

如果要理解当前项目，优先阅读：

1. [AGENTS.md](AGENTS.md)
2. [docs/specs/README.md](docs/specs/README.md)
3. [docs/README.md](docs/README.md)
4. [docs/architecture/overview.md](docs/architecture/overview.md)
5. [services/README.md](services/README.md)

## 核心约定

- 业务能力变更前，先更新 `docs/specs/` 或对应领域设计文档。
- 电话、坐席、CTI、实时通道、聊天、录音、质检、AI、报表不能按普通 CRUD 建模。
- 外部系统和华为 CTI 对接必须通过 adapter 或 integration 边界隔离。
- 文件涉及中文注释或中文文案时必须保持 UTF-8 编码。
