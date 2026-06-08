---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot Web MVP 路线图，定义当前阶段的页面、能力、前端结构与联调主线。
---

# Web MVP 路线图

## 目标

本文档用于把 ProjectPilot 从“旧基线遗留工程”纠偏为“Web 产品研发主线”，明确第一阶段真正要交付的前后端能力、页面结构和联调闭环。

如果需要判断 Harness Engineering 在这条主线里应如何发挥作用，参见 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)。

如果需要理解前后端结构为什么参考 CallCenter，参见 [docs/architecture/callcenter-reference-adaptation.md](../architecture/callcenter-reference-adaptation.md)。

## 推荐联读

开始实际开发前，建议同时阅读：

1. [docs/README.md](../README.md)
2. [docs/architecture/README.md](../architecture/README.md)
3. [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
4. [docs/conventions/README.md](../conventions/README.md)
5. [docs/plans/current-sprint.md](../plans/current-sprint.md)

## 当前判断

当前仓库已经具备：

- 文档导航、评审、测试和迁移路线入口
- 新的目标技术基线说明
- 架构融合与目标结构说明
- 基础发布与可观测性支撑材料

当前仓库仍明显缺少：

- 完整 `web/` 工程
- 页面、路由和交互结构
- 核心业务模块的真实实现
- 前后端联调链路
- 面向用户的 MVP 功能闭环

## 第一阶段 MVP 范围

第一阶段只聚焦项目管理平台的核心协作闭环：

1. 登录与会话校验
2. 组织内项目列表
3. 项目详情
4. 任务列表
5. 任务创建与状态流转
6. 成员与角色的最小权限判断

本阶段不优先处理：

- 完整商业化结算落地
- 灰度发布与特性开关平台化
- 高阶交付治理平台化
- 独立搜索基础设施

## 前端建议结构

建议尽快建立 `web/` 前端应用，并吸收 CallCenter 的前端工程分区思路：

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

其中：

- `apps/projectpilot-web/` 先承载第一阶段主应用。
- `packages/shared-ui/` 放共享组件、主题和基础布局。
- `packages/shared-api/` 放接口客户端、类型和请求封装。
- `packages/config/` 放前端工程共用配置。

## 页面路线图

第一阶段建议优先实现：

1. 登录页
2. 项目列表页
3. 项目详情页
4. 任务列表或看板页
5. 任务创建或编辑弹层/页面

## 后端对应模块

后端应围绕 MVP 页面优先落地以下模块：

1. Auth
2. Organization
3. Project
4. Task
5. Member / Role

## 联调顺序

建议按以下顺序推进，而不是并行铺太多模块：

1. 登录接口 + 登录页
2. 项目列表接口 + 项目列表页
3. 项目详情接口 + 项目详情页
4. 任务列表接口 + 任务列表页
5. 任务创建/更新接口 + 对应表单

## 文档联动

后续推进时，建议按以下路径同步更新：

- 页面与交互变化：更新 [docs/design/README.md](README.md) 对应专题
- API 变化：更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- 错误码变化：更新 [docs/reference/error-codes.md](../reference/error-codes.md)
- 迭代优先级变化：更新 [docs/plans/current-sprint.md](../plans/current-sprint.md) 和 [docs/plans/backlog.md](../plans/backlog.md)

## 纠偏原则

- 工程治理服务于 Web 产品研发，不反客为主。
- 先完成用户可感知的 MVP，再继续加强发布与平台化能力。
- CallCenter 只提供工程结构参考，不直接决定 ProjectPilot 的业务边界。
- 发布、回滚、环境和可观测性材料作为支撑层保留，统一通过 [deploy/release/README.md](../../deploy/release/README.md) 与 [deploy/observability/README.md](../../deploy/observability/README.md) 维护。
