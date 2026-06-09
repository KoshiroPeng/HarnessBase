---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: 说明 Harness Engineering 在 HarnessBase 中的落地方向：仓库事实源、影响地图、结构护栏、验证证据与自动化反馈。
---

# Harness Engineering 落地说明

## 目标

本文档说明 Harness Engineering 在 HarnessBase 中的正确用法。它不是新业务范围，也不是大而全平台建设，而是把仓库组织成 AI 和人工协作者都能稳定使用的工程环境：事实可定位、约束可执行、验证可复现、反馈可沉淀。

## 当前结论

对本仓库而言，Harness Engineering 应落在一句话上：

> 用真实代码地图、仓库影响图、结构化任务约束、可执行验证和自动化检查，让当前若依微服务基线能够持续、安全地扩展业务代码。

参考方法论：

- [OpenAI Harness engineering](https://openai.com/index/harness-engineering/) 强调工程师的重点从手写代码转向设计环境、表达意图和构建反馈循环。
- [Red Hat Harness engineering](https://developers.redhat.com/articles/2026/04/07/harness-engineering-structured-workflows-ai-assisted-development) 强调先让 AI 基于真实代码生成影响图，再用结构化约束推进实现。

## 本仓库的 Harness 分层

| 分层 | 当前落点 | 作用 |
| --- | --- | --- |
| 规则入口 | [AGENTS.md](../../AGENTS.md) | 固定仓库级硬约束、Git 流程、编码和文档治理要求 |
| 事实源 | [docs/architecture/code-map.md](code-map.md)、[docs/architecture/target-technology-baseline.md](target-technology-baseline.md) | 固定真实模块、技术版本、启动入口和数据脚本事实 |
| 任务约束 | [docs/architecture/business-extension-baseline.md](business-extension-baseline.md)、[docs/conventions/development-execution-guide.md](../conventions/development-execution-guide.md) | 把业务需求拆成可落位、可验证的纵向切片 |
| 同步触发 | [docs/conventions/change-trigger-matrix.md](../conventions/change-trigger-matrix.md) | 判断代码、SQL、API、发布和文档变更需要同步哪些材料 |
| 评审证据 | [docs/reviews/README.md](../reviews/README.md) | 沉淀设计评审、代码评审、测试和验证证据 |
| 自动护栏 | [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)、[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) | 把文档元数据、链接和后续结构检查自动化 |

## 五个执行原则

### 1. 仓库是真实上下文

所有架构、设计、发布和评审结论，必须先能回到真实文件验证。当前最重要的事实源是：

- [docs/architecture/code-map.md](code-map.md)
- [server/pom.xml](../../server/pom.xml)
- [web/package.json](../../web/package.json)
- [server/sql](../../server/sql)
- [.github/workflows](../../.github/workflows)

不在 Google Docs、聊天记录、个人记忆或旧项目目录里维护当前项目事实。若某个决定会影响后续开发，应沉淀到仓库内对应文档。

### 2. 先生成仓库影响图

新增业务、修复缺陷或调整架构前，先用真实代码确认影响面。最小影响图必须回答：

1. 后端落在哪个服务或模块。
2. 前端落在哪个 `web/src/api`、`web/src/views`、`web/src/router` 或 `web/src/store` 位置。
3. 是否影响 [server/sql](../../server/sql)、权限、错误码、API 摘要、发布或观测。
4. 应复用哪些现有类、接口、Mapper、公共模块或页面模式。
5. 本次验证命令和未覆盖风险记录在哪里。

如果影响图无法说清真实路径和现有模式，说明任务还没有准备好进入实现。

### 3. 规则只保留在合适层级

[AGENTS.md](../../AGENTS.md) 只承载必须被所有 agent 遵守的仓库级硬规则和导航入口，不写成第二份 README。执行细节下沉到：

- 开发执行：[docs/conventions/development-execution-guide.md](../conventions/development-execution-guide.md)
- 业务扩展：[docs/architecture/business-extension-baseline.md](business-extension-baseline.md)
- 模块边界：[docs/architecture/boundaries.md](boundaries.md)
- 测试规范：[docs/conventions/testing.md](../conventions/testing.md)
- 发布支撑：[deploy/release/README.md](../../deploy/release/README.md)

### 4. 结构约束优先于口头提醒

当前高价值结构护栏包括：

- 中文与 UTF-8 规则
- 微服务模块边界
- JDK 17 / Spring Boot 4 / Vue 2 现行基线
- 构造器注入、日志规范、测试要求
- SQL 脚本、API 文档、响应码文档同步要求
- workflow 与发布脚本必须指向真实源码路径

这些规则能自动化时，优先进入 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 和 `.github` workflow；暂时不能自动化时，必须能在评审清单或验证证据里被人工核对。

### 5. 验证即闭环

完成任务时，至少说明：

- 改了哪些文档或代码
- 如何验证链接、编码、构建、测试或脚本
- 哪些风险未覆盖

高风险任务优先使用 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 留存证据。发现同类错误重复出现时，不只修当次输出，还要回头补充规则、模板、脚本或入口导航。

## 业务开发主路径

后续基于 HarnessBase 写业务代码时，默认按下面路径推进：

1. 阅读 [AGENTS.md](../../AGENTS.md)、[docs/README.md](../README.md)、[docs/architecture/code-map.md](code-map.md)。
2. 按 [docs/architecture/business-extension-baseline.md](business-extension-baseline.md) 生成仓库影响图。
3. 用 [docs/conventions/change-trigger-matrix.md](../conventions/change-trigger-matrix.md) 判断同步文档。
4. 在既有 `ruoyi-gateway`、`ruoyi-auth`、`ruoyi-api-*`、`ruoyi-common-*`、`ruoyi-modules/*`、`web/src/*` 边界内实现。
5. 按 [docs/conventions/testing.md](../conventions/testing.md) 和对应评审清单补验证。
6. 用验证证据或任务状态模板沉淀结果，必要时补自动化护栏。

## 反模式

以下做法不符合本仓库的 Harness Engineering 方向：

- 为了“让 AI 知道更多”而堆叠重复文档。
- 把 `AGENTS.md` 写成完整开发手册、发布手册或项目 README。
- 只按目录名推断架构，不核对 `pom.xml`、启动类、配置、workflow 和实际源码。
- 让 agent 无限递归读取导航页、索引页和互相引用的规则文档。
- 在业务任务中提前搭建与当前若依微服务无关的平台化抽象。
- 只修一次输出，不把重复问题沉淀为规则、模板、检查脚本或验证入口。

## 一句话准则

在 HarnessBase 里，Harness Engineering 的正确方向不是“多写文档”，而是“把真实代码、任务约束、自动护栏和验证反馈组织成可持续扩展业务代码的工程环境”。
