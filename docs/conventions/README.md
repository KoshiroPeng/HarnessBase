---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 编码规范

本目录记录代码层面的工程规范。根规则以 [AGENTS.md](../../AGENTS.md) 为准；CallCenter 主项目的规格事实来源以 [docs/specs/](../specs/) 为准。

## 当前文档

| 主题 | 文档 |
| --- | --- |
| 命名 | [naming.md](naming.md) |
| 错误处理 | [error-handling.md](error-handling.md) |
| 测试 | [testing.md](testing.md) |
| 日志 | [logging.md](logging.md) |
| 文件规模 | [file-size.md](file-size.md) |
| 方法规模 | [method-size.md](method-size.md) |
| 文档链接 | [document-links.md](document-links.md) |

## 当前主工程基线

- 后端主工程：`services/callcenter-server`。
- 后端技术栈：Java 17 + Spring Boot 3.x + RuoYi-Vue-Plus 裁剪版。
- 前端主工程：`services/callcenter-web`。
- 前端技术栈：Vue 3 + TypeScript + Vite + plus-ui 裁剪版。
- 历史骨架：根目录 `server/`，仅兼容保留，不作为当前项目主后台入口。

## 基本原则

- 优先遵循 CallCenter 既有工程结构和依赖版本。
- 新增呼叫中心业务前，先明确领域模型和外部集成边界。
- 电话、坐席、CTI、实时通道、聊天、录音、质检、AI、报表不能按普通 CRUD 建模。
- 外部系统和华为 CTI 对接必须通过 adapter 或 integration 边界隔离。
- 实时交互必须明确连接状态、重连策略、错误提示和降级路径。
- 业务、API、错误码、部署或运行方式变化时，同步更新对应文档。

## 提交前自检

提交前至少确认：

- 后端改动执行 `cd services/callcenter-server && mvn -DskipTests package`。
- 前端改动执行 `cd services/callcenter-web && pnpm install && pnpm build:prod`。
- 中文注释和中文文案文件保持 UTF-8 编码。
- 外部系统对接没有绕过 adapter 或 integration 边界。
- 呼叫中心核心状态没有直接塞进系统管理模块。
- 相关规格、设计、交付或运维文档已经同步更新。

如果需要按任务查看“开发前必读 + 开发后自检 + 评审清单”，统一入口见 [docs/README.md](../README.md)。
