---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot Web MVP 路线图，定义当前阶段的页面、能力与交付主线。
---

# Web MVP 路线图

## 目标

本文档用于把 ProjectPilot 从“工程与交付骨架”纠偏为“Web 产品研发主线”，明确第一阶段真正要交付的前后端能力、页面结构和联调闭环。

如果需要判断 Harness Engineering 在这条主线里应如何发挥作用，参见 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)。

## 推荐联读

开始实际开发前，建议同时阅读：

1. [docs/README.md](../README.md)
2. [docs/architecture/README.md](../architecture/README.md)
3. [docs/conventions/README.md](../conventions/README.md)
4. [docs/plans/current-sprint.md](../plans/current-sprint.md)
5. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)

## 当前判断

当前仓库已经具备：

- Spring Boot 后端工程骨架
- 架构、规范、评审和测试文档入口
- API 与错误码基线
- 基础 CI 与最小发布支撑材料

当前仓库仍明显缺少：

- `web/` 前端工程
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

- 计费正式落地
- 灰度发布与特性开关工程化
- 高阶交付治理平台化
- 复杂搜索能力

## 前端建议结构

建议尽快建立 `web/` 前端应用，至少包含以下结构：

```text
web/
├── src/
│   ├── app/
│   ├── pages/
│   ├── components/
│   ├── features/
│   ├── services/
│   ├── routes/
│   └── styles/
└── package.json
```

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
- 发布、回滚、环境和可观测性材料作为支撑层保留，统一通过 [deploy/release/README.md](../../deploy/release/README.md) 与 [deploy/observability/README.md](../../deploy/observability/README.md) 维护。
