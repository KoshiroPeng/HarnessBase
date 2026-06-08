---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 对 CallCenter 项目技术架构的吸收与裁剪说明，定义哪些结构应融合、哪些能力不应照搬。
---

# CallCenter 参考架构融合说明

## 目标

本文档说明 ProjectPilot 如何吸收 `D:\dev\workspace\CallCenter` 的工程结构和技术思路，并结合当前 Web 项目目标做裁剪，避免出现两类偏差：

- 完全忽略现成的成熟 Web 工程经验。
- 把呼叫中心项目的领域能力和平台规模原样搬进当前仓库。

## 从 CallCenter 提取的有效经验

结合 [CallCenter 的总体技术方案](D:/dev/workspace/CallCenter/doc/specs/04-总体技术方案.md) 与 [仓库与工程结构方案](D:/dev/workspace/CallCenter/doc/specs/05-仓库与工程结构方案.md)，当前最适合 ProjectPilot 吸收的是下面这些内容：

1. 顶层目录按 `doc/docs`、`server`、`web`、`deploy` 分区，方便 AI 和人工快速定位上下文。
2. 后端优先采用模块化单体，而不是在业务初期过早拆微服务。
3. 外部系统统一通过 adapter 隔离，避免第三方 SDK 扩散到核心业务。
4. Web 工程以 Vue 3 + TypeScript + Vite 为主线，前后端都走现代工具链。
5. 部署材料集中在 `deploy/`，优先支持 Docker Compose、Nginx 和一键化运维入口。
6. 规范先行，文档作为事实来源，再进入实现。

## 不直接照搬的部分

ProjectPilot 不会直接复制 CallCenter 的以下内容：

1. 呼叫中心领域模型，例如 CTI、坐席、录音、质检、实时通道等。
2. 以 RuoYi-Vue-Plus / plus-ui 为中心的脚手架命名和模块组织。
3. 面向单客户私有化交付的全部部署假设。
4. 面向呼叫中心规模的高实时性、专项基础设施和复杂集成边界。

换句话说，ProjectPilot 参考的是它的工程化方法和分区结构，不是直接继承它的业务边界。

## ProjectPilot 的融合方向

### 顶层仓库结构

ProjectPilot 继续保持：

```text
.
├── AGENTS.md
├── README.md
├── docs/
├── server/
├── web/
└── deploy/
```

这与 CallCenter 的顶层分区思想一致，目的是让导航和职责清晰，而不是让所有东西都堆在后端工程里。

### 后端结构

吸收 CallCenter 的“模块化单体 + 底座与业务分离”思路，ProjectPilot 的目标结构为：

```text
server/
├── bootstrap/
├── shared/
├── modules/
│   ├── auth/
│   ├── organization/
│   ├── project/
│   ├── task/
│   └── billing/
├── integration/
└── script/
```

这里的重点不是目录名称本身，而是：

- 核心业务模块不再长期堆在单一脚手架模块里。
- 外部集成、数据库适配、Web 输入输出与业务用例逐步分层。
- 共享能力和业务能力分开演进。

### Web 结构

吸收 CallCenter 的前端工程化方向，但按当前项目规模做更轻的起步：

```text
web/
├── apps/
│   └── projectpilot-web/
├── packages/
│   ├── shared-ui/
│   ├── shared-api/
│   └── config/
└── tooling/
```

这样做的原因是：

- 当前只有一个主 Web 应用，也要为后续管理台、工作台或独立包预留边界。
- AI 在修改路由、共享组件、接口定义和构建配置时，更容易按目录职责找到对应位置。

### 部署结构

吸收 CallCenter 的部署分区思路，但不强行复制其完整运维入口。当前建议：

- `deploy/release/` 继续承载 GitHub Actions、SSH 发布、回滚和环境模板。
- 后续如果 `web/` 与 `server/` 真正进入联合交付，再逐步引入 Compose、Nginx 和统一运维脚本。
- 发布支撑材料依然是产品交付支撑层，不升级为新的平台主线。

## 与 Harness Engineering 的对齐

这次融合符合 Harness Engineering 的原因，不在于“引入了更多文档”，而在于：

1. 技术方向更清晰，减少后续在旧基线与新基线之间反复摇摆。
2. 架构边界更明确，减少把项目继续写成脚手架堆积区的风险。
3. 导航更集中，AI 在开发、评审、测试时能更快定位到应联读的文档。
4. 迁移与融合都被沉淀成可验证、可复用的项目资产，而不是停留在对话里。

## 下一步落地建议

如果要继续按这条路线推进，建议按以下顺序执行：

1. 先对齐 [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)。
2. 再执行 [docs/plans/jdk17-springboot3-migration-roadmap.md](../plans/jdk17-springboot3-migration-roadmap.md) 中的后端基线迁移。
3. 然后基于 [docs/design/web-mvp-roadmap.md](../design/web-mvp-roadmap.md) 初始化 `web/` 目标结构。
4. 最后再逐步把发布、联调、观测支撑接回统一闭环。
