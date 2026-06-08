---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# Backlog

## P0：CallCenter 主项目收敛

已完成：

- 将 `services/callcenter-server` 作为当前项目完整后台。
- 将 `services/callcenter-web` 作为当前项目前端。
- 将 CallCenter 规格文档接入 `docs/specs/`。
- 将 `AGENTS.md` 改为 CallCenter 协作规则。
- 迁入 `deploy/compose.yml`、`deploy/compose.app.yml` 和 `deploy/ops`。

待补齐：

- 为 `callcenter-server` 和 `callcenter-web` 建立独立发布、回滚和发布后验证 workflow。
- 为真实 test/staging/prod 环境配置 GitHub Environments、变量、密钥和审批人。
- 为 CallCenter 后端、前端和镜像制品定义统一版本命名与制品仓库策略。

## P1：呼叫中心核心领域

- 坐席领域模型：坐席、技能组、状态、签入签出、忙闲状态。
- 通话领域模型：呼入、外呼、接听、挂断、转接、保持、通话记录。
- CTI adapter：华为 CTI 或其他电话系统事件接入与标准事件转换。
- 实时通道：WebSocket / SSE 连接管理、重连、广播和多实例策略。
- 来电弹屏：客户资料查询、弹屏上下文、权限与降级。
- 话务条：坐席端通话控制入口和状态同步。

## P2：客户沟通与记录

- 文字聊天会话。
- 通话小结。
- 客户沟通记录。
- 录音元数据管理。
- 录音下载权限与审计。
- CRM / 工单 / 客户资料系统集成边界。

## P3：质检、AI 与报表

- 人工质检评分。
- 语音转写异步任务。
- AI 质检任务与结果归档。
- 转写和 AI 成本控制。
- T+1 报表链路。
- 坐席、通话、质检和客户服务指标。

## P4：交付与运维平台化

- 建立 CallCenter 专用发布 workflow。
- 建立 CallCenter 专用回滚 workflow。
- 建立 CTI、坐席状态、来电弹屏和实时通道业务探针。
- 补齐依赖漏洞扫描和密钥泄露扫描。
- 建立生产级日志、指标和告警规则。
- 按客户机房约束确认高可用部署方案。

## Backlog 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 涉及业务边界变化的任务必须同步 `docs/specs/` 或对应领域设计文档。
- 涉及架构或边界变化的任务必须同步 `docs/architecture/`。
- 涉及交付、环境、验证或回滚的任务必须同步 `docs/delivery/` 或 `docs/operations/`。
