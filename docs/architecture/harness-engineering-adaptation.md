---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: 说明 Harness Engineering 在 HarnessBase 中的落地方向：真实代码地图、规则护栏、验证证据与自动化检查。
---

# Harness Engineering 落地说明

## 目标

本文档说明 Harness Engineering 在 HarnessBase 中的正确用法。它不是新业务范围，也不是大而全平台建设，而是一组让 AI 和人工协作者更稳定完成工程任务的支架。

## 当前结论

对本仓库而言，Harness Engineering 应落在一句话上：

> 用真实代码地图、清晰规则、可执行验证和自动化检查，让当前微服务系统持续保持文档与代码一致。

## 正确落点

### 1. 事实优先

所有架构、设计、发布和评审结论，必须先能回到真实文件验证：

- [docs/architecture/code-map.md](code-map.md)
- [server/pom.xml](../../server/pom.xml)
- [web/package.json](../../web/package.json)
- [server/sql](../../server/sql)
- [.github/workflows](../../.github/workflows)

### 2. 文档即导航

文档要帮助协作者快速找到下一步：

- [AGENTS.md](../../AGENTS.md)
- [docs/README.md](../README.md)
- [docs/architecture/code-map.md](code-map.md)
- [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)
- [docs/reviews/README.md](../reviews/README.md)
- [deploy/release/README.md](../../deploy/release/README.md)

### 3. 规则即护栏

当前高价值护栏包括：

- 中文与 UTF-8 规则
- 微服务模块边界
- JDK 17 / Spring Boot 4 / Vue 2 现行基线
- 构造器注入、日志规范、测试要求
- SQL 脚本、API 文档、响应码文档同步要求
- workflow 与发布脚本必须指向真实源码路径

### 4. 验证即闭环

完成任务时，至少说明：

- 改了哪些文档或代码
- 如何验证链接、编码、构建、测试或脚本
- 哪些风险未覆盖

## 一句话准则

在 HarnessBase 里，Harness Engineering 的正确方向不是“多写文档”，而是“让代码事实、协作规则和验证路径持续对齐”。
