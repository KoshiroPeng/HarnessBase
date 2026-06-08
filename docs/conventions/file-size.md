---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 文件规模规范

Java 单文件不超过 300 行。超过上限时，优先按职责拆分为更小的类，而不是压缩格式或删除可读性信息。

常见拆分方式：

- Controller 只保留 HTTP 入参、出参与调用 Service。
- Service 中的复杂编排拆分为私有方法或独立领域服务。
- 与外部系统、日志、指标、安全相关的能力下沉到 `infrastructure/`。
- 重复的纯工具逻辑可以抽取为命名明确的 Helper，但不要把业务规则塞进通用工具类。

Checkstyle 会在 `verify` 阶段拦截超过 300 行的 Java 文件。
