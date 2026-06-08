---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 系统架构概览

## 项目定位

CallCenter 是面向客户本地机房私有化部署的企业级呼叫中心 Web 平台。当前第一阶段采用 RuoYi-Vue-Plus 裁剪版后端、plus-ui 裁剪版前端和模块化单体优先的技术路线。

当前项目不是通用后台系统；业务核心是电话、坐席、CTI、实时通道、聊天、录音、质检、AI 和报表。

## 当前工程入口

| 入口 | 路径 | 定位 |
| --- | --- | --- |
| 后端 | [services/callcenter-server/](../../services/callcenter-server/) | 当前项目完整后台 |
| 前端 | [services/callcenter-web/](../../services/callcenter-web/) | 当前项目前端 |
| 规格 | [docs/specs/](../specs/) | 需求、架构和工程结构事实来源 |
| 部署 | [deploy/](../../deploy/) | Compose、本地运维、发布脚本和可观测性 |
| 历史骨架 | [server/](../../server/) | 兼容保留，不再承载新的 CallCenter 业务 |

## 技术栈

### 后端

- Java 17+
- Spring Boot 3.x
- RuoYi-Vue-Plus 5.X 裁剪版
- Sa-Token
- MyBatis-Plus
- dynamic-datasource
- Redis / Redisson
- MinIO / OSS
- SpringDoc OpenAPI
- WebSocket
- SSE

### 前端

- Vue 3
- TypeScript
- Vite
- Element Plus
- Pinia
- Vue Router
- plus-ui 裁剪版

### 部署与运行

- Docker Compose
- Nginx
- MySQL 8
- Redis
- MinIO
- GitHub Actions / SSH 发布骨架
- Prometheus / Loki / Grafana 本地观测栈

## 顶层目录结构

```text
.
├── AGENTS.md
├── README.md
├── .github/workflows/
├── docs/
│   └── specs/
├── services/
│   ├── callcenter-server/
│   └── callcenter-web/
├── server/
└── deploy/
```

- `docs/specs/`: CallCenter 产品范围、规模、部署约束、技术方案和工程结构事实来源。
- `services/callcenter-server/`: 当前项目完整 Java 后端。
- `services/callcenter-web/`: 当前项目 Vue 前端。
- `deploy/`: Docker Compose、发布脚本、可观测性和运维入口。
- `server/`: 历史后端骨架，仅兼容保留。

## 后端架构原则

当前后端仍保留 RuoYi-Vue-Plus 裁剪后的聚合结构：

```text
services/callcenter-server/
├── ruoyi-admin/
├── ruoyi-common/
├── ruoyi-modules/
└── script/
```

第一阶段采用模块化单体，不预设微服务拆分。新增呼叫中心业务时，应优先沿真实领域边界落地，而不是把业务长期塞进 `ruoyi-system`。

核心原则：

- 外部系统必须走 adapter 或 integration 边界。
- CTI 回调、通话事件和坐席状态必须转换成系统内部标准模型。
- 后端实例必须避免本地业务状态，支持多实例部署。
- WebSocket / SSE 等实时能力必须考虑多实例场景。
- 录音处理、语音转写、AI 质检和报表应通过异步链路承载。
- 报表链路与核心业务读写链路需要分开演进。

## 前端架构原则

当前前端仍是 plus-ui 裁剪后的单应用结构：

```text
services/callcenter-web/
├── src/api/
├── src/views/
├── src/components/
├── src/router/
├── src/store/
└── public/
```

后续坐席工作台、话务条、来电弹屏、聊天界面、主管工作台和质检工作台应形成清晰视图区，不和系统管理页面混写。实时交互相关代码必须明确连接状态、重连策略、错误提示和降级路径。

## 数据与集成

当前部署目标以客户本地机房私有化交付为主，采用单客户独立部署，不做运行时 SaaS 多租户。

外部系统约束：

- 华为 CTI 或其他电话系统不得直接耦合业务模块，必须通过适配层隔离。
- CRM、工单、客户资料系统的主数据边界、弹屏查询、通话小结写回和聊天记录回写需要在实现前明确。
- 多数据源能力应服务于真实集成边界，不作为随意拆库的理由。

## 质量与交付

当前 CI 覆盖：

- `services/callcenter-server`: JDK 17 + Maven 构建校验。
- `services/callcenter-web`: Node 22 + pnpm 11.5.2 + Vite 构建校验。
- `server`: 历史骨架兼容校验。

本地常用验证：

```bash
(cd services/callcenter-server && mvn -DskipTests package)
(cd services/callcenter-web && pnpm install && pnpm build:prod)
./deploy/ops start
./deploy/ops health
```

## 文档维护规则

- 业务范围、规模、部署约束、技术路线或工程结构变化，同步更新 [docs/specs/](../specs/)。
- 模块边界、依赖方向或数据流变化，同步更新 [docs/architecture/](./)。
- 发布、环境、制品、流水线、验证或回滚变化，同步更新 [docs/delivery/](../delivery/) 或 [docs/operations/](../operations/)。
- 新增呼叫中心领域能力时，先明确领域模型，再实现代码。
