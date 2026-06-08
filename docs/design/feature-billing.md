---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 功能设计：计费

## 背景

HernessDemo 面向中小企业，需要支持组织维度的套餐、用量和账单管理。

本设计只定义第一版边界，不假设已经接入真实支付渠道。

在当前项目阶段，计费不属于第一批 Web MVP 主线能力，应保留设计边界，但不应抢占当前主线资源。

## 目标

- 支持组织套餐记录。
- 支持成员数、项目数等用量统计。
- 支持账单列表和账单详情查询。
- 为未来支付渠道接入预留 `ApiClient` 抽象。

## 非目标

- 暂不直接接入真实支付扣款。
- 暂不支持复杂促销、税务和发票流程。
- 暂不支持多币种结算。
- 暂不为了未来商业化而提前建设通用计费平台。

## 核心概念

- Plan: 套餐。
- Subscription: 组织订阅。
- Usage: 用量。
- Invoice: 账单。
- Payment Provider: 外部支付或计费渠道。

## 后端边界

- Billing Controller 负责账单 API 入参出参。
- Billing Service 负责套餐、订阅、用量和账单规则。
- Billing Mapper 负责数据访问。
- 外部支付渠道必须通过 `ApiClient` 抽象，禁止裸用 HTTP 客户端。

## 数据流

```text
Client
  -> Billing Controller
  -> Billing Service
  -> Billing Mapper
  -> MySQL 5.7
```

未来接入支付渠道时：

```text
Billing Service
  -> Payment ApiClient
  -> Payment Provider
```

## 错误码

相关错误码登记在 [docs/reference/error-codes.md](../reference/error-codes.md)：

- `BILLING_PLAN_NOT_FOUND`
- `BILLING_SUBSCRIPTION_INACTIVE`
- `BILLING_INVOICE_NOT_FOUND`

## 测试要求

- 账单查询必须校验组织权限。
- 无效套餐返回明确错误码。
- 用量统计边界值必须覆盖。
- 外部支付渠道调用必须 mock 或 stub。

## 待确认问题

- 套餐是按组织、成员数还是项目数计费。
- 是否需要试用期。
- 是否需要账单导出。
- 是否需要对接第三方支付平台。

## 当前阶段判断

- 优先级：低于当前 Web MVP 主线。
- 实现策略：先保留边界和接口方向，等核心协作闭环稳定后再推进。
- 纠偏提醒：若计费相关讨论开始演变为完整商业化平台建设，应先确认为 backlog 事项，而不是当前迭代目标。
