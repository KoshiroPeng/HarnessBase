---
last_updated: 2026-06-08
status: deprecated     # active | deprecated | draft
owner: "@PengKang"
---

# 功能设计：认证与授权

> 历史设计草稿，仅保留参考。CallCenter 当前权限模型应结合坐席、主管、质检、管理员和客户现场系统重新校准。

## 背景

在线项目管理平台需要识别当前用户，并按组织、项目和角色控制访问范围。

本设计是第一版功能边界，实际实现前需要结合产品需求和安全评审细化。

## 目标

- 支持用户登录、登出和会话校验。
- 支持基于组织和项目的权限判断。
- 支持 Controller 到 Service 的统一身份上下文传递。
- 认证、授权和审计能力通过 Spring 注入接入。

## 非目标

- 暂不设计第三方单点登录。
- 暂不设计多因素认证。
- 暂不设计复杂 IAM 策略语言。

## 核心概念

- User: 平台用户。
- Organization: 企业或团队。
- Project: 项目空间。
- Role: 用户在组织或项目内的角色。
- Permission: 可执行动作，例如创建任务、修改成员、查看账单。

## 建议数据流

```text
Client
  -> Auth Filter
  -> Security Context
  -> Controller
  -> Service 权限校验
  -> Mapper
  -> MySQL
```

## 后端边界

- Controller 只读取当前身份，不写复杂权限规则。
- Service 负责业务级权限校验。
- Mapper 只负责查询权限相关数据。
- 认证组件、权限检查器和审计组件必须通过 Spring 注入。

## 错误码

相关错误码登记在 `docs/reference/error-codes.md`：

- `AUTH_REQUIRED`
- `AUTH_TOKEN_EXPIRED`
- `AUTH_FORBIDDEN`

## 测试要求

- 未登录访问受保护接口返回 401。
- 无权限访问项目资源返回 403。
- 有权限用户可以访问对应项目资源。
- Service 层权限失败必须有单元测试覆盖。

## 待确认问题

- 会话采用服务端 session 还是 token。
- 组织角色和项目角色是否需要分离。
- 是否需要支持邀请链接和成员审批。
