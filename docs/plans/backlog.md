---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# Backlog

## P0：工程基线

- 创建后端 Maven 项目，锁定 JDK 1.8、Spring Boot 2.7.x 和 Maven 3.6.3。
- 配置 Maven Enforcer，防止版本漂移。
- 接入 MyBatis-Plus 3.5.x。
- 接入 Flyway 和 `flyway-mysql`。
- 建立统一异常处理和错误响应模型。
- 建立 SLF4J 日志配置。
- 建立 JUnit 5 测试基础设施。

## P1：核心业务

- 用户注册、登录、登出和会话校验。
- 组织管理。
- 项目管理。
- 任务管理。
- 成员与角色管理。
- 项目与任务搜索。

## P2：商业化能力

- 套餐管理。
- 订阅管理。
- 用量统计。
- 账单查询。
- 支付渠道适配抽象。

## P3：运营与质量

- API 文档持续维护。
- 错误码治理。
- 审计日志。
- 指标和 telemetry。
- 部署文档。
- 性能基准测试。

## P4：交付平台化

- 建立交付模型文档，明确 Application、Service、Environment、Infrastructure 的映射关系。
- 建立环境治理文档，明确 dev、test、staging、prod 的职责和准入条件。
- 建立标准 CI / CD / 发布验证流水线模型。
- 定义部署策略、回滚策略和数据库变更兼容策略。
- 建立配置与密钥治理规则。
- 建立发布审批、权限和审计规则。
- 建立运行手册和发布后验证流程。

## Backlog 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 涉及架构或边界变化的任务必须同步 `docs/architecture/`。
- 涉及 API 的任务必须同步 `docs/reference/api-spec.yaml`。
- 涉及错误码的任务必须同步 `docs/reference/error-codes.md`。
