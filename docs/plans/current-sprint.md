---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 当前迭代计划

## 迭代目标

完成 CallCenter 主项目口径收敛：以 `services/callcenter-server` 作为完整后台，以 `services/callcenter-web` 作为前端，以 `docs/specs/` 作为规格事实来源，让后续呼叫中心业务开发能够围绕统一的领域边界、工程入口和交付规则推进。

## 当前状态

当前仓库已经具备：

- CallCenter 后端工程：`services/callcenter-server/`
- CallCenter 前端工程：`services/callcenter-web/`
- CallCenter 规格入口：`docs/specs/`
- Docker Compose 本地运维入口：`deploy/ops`
- GitHub Actions CI、远端主机初始化、发布与回滚骨架
- 本地可观测性配置：Prometheus、Loki、Promtail、Grafana

根目录 `server/` 仅兼容保留，不再作为当前项目主后台。

## 本迭代范围

| 优先级 | 事项 | 产出 | 状态 |
| --- | --- | --- | --- |
| P0 | 固化 CallCenter AI 协作规则 | `AGENTS.md` | 已完成 |
| P0 | 接入 CallCenter 规格文档 | `docs/specs/` | 已完成 |
| P0 | 明确前后台主工程入口 | `services/callcenter-server/`、`services/callcenter-web/` | 已完成 |
| P0 | 迁入本地 Compose 运维入口 | `deploy/compose.yml`、`deploy/compose.app.yml`、`deploy/ops` | 已完成 |
| P1 | 校准架构、规范、交付文档 | `docs/` | 进行中 |
| P1 | 校准 CI 的主 Service 口径 | `.github/workflows/agent-guardrails.yml` | 进行中 |
| P1 | 为 CallCenter 发布/回滚补齐独立 workflow | `.github/workflows/` | 待办 |

## 开发约束

- 不把电话、坐席、CTI、实时通道、聊天、录音、质检、AI、报表写成普通 CRUD。
- 外部系统和华为 CTI 对接必须通过 adapter 或 integration 边界隔离。
- 后端新增业务能力进入 `services/callcenter-server/`。
- 前端新增业务界面进入 `services/callcenter-web/`。
- 涉及中文注释或中文文案的文件必须保持 UTF-8。

## 验收标准

- 根文档、导航文档和架构文档均明确 CallCenter 是当前主项目。
- `services/callcenter-server` 与 `services/callcenter-web` 被文档和 CI 识别为主前后台。
- `docs/specs/` 能作为呼叫中心需求、架构和工程结构事实来源。
- 本地 Compose 入口路径与当前仓库真实目录一致。
- 旧项目管理平台口径不再出现在主路径文档中。

## 风险

- `callcenter-server` 和 `callcenter-web` 尚未接入完整独立发布、回滚和业务探针。
- 华为 CTI、CRM、工单、客户资料系统的真实接口边界尚未完全落定。
- 当前部署仍是最小 Compose + SSH/systemd 骨架，生产级高可用方案需要结合客户机房继续确认。
