---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 前端工程入口，汇总前端目录结构、运行命令、接口落位规则与协作文档导航。
---

# 前端工程入口

## 目标

本文档作为 HarnessBase 前端工程的本地入口，帮助开发者和 AI 协作者快速确认前端技术栈、目录结构、运行命令、接口落位规则和必读文档。

当前前端真实代码以 [package.json](package.json)、[src](src) 与 [vite.config.ts](vite.config.ts) 为准；如果与上游 plus-ui 说明冲突，以本仓库代码事实和 [AGENTS.md](../AGENTS.md) 为准。

## 快速导航

- [AGENTS.md](../AGENTS.md)：仓库级协作规则与硬性约束
- [docs/README.md](../docs/README.md)：统一文档导航入口
- [docs/architecture/code-map.md](../docs/architecture/code-map.md)：真实代码地图
- [docs/design/feature-admin-domains.md](../docs/design/feature-admin-domains.md)：后台功能域图谱
- [docs/conventions/testing.md](../docs/conventions/testing.md)：前端测试与验证规范
- [docs/reviews/frontend-code-review-checklist.md](../docs/reviews/frontend-code-review-checklist.md)：前端代码评审清单
- [docs/reviews/frontend-design-review-checklist.md](../docs/reviews/frontend-design-review-checklist.md)：前端设计评审清单

## 当前结构

```text
web/
├── package.json
├── pnpm-lock.yaml
├── src/
│   ├── api/
│   ├── views/
│   ├── router/
│   ├── store/
│   ├── layout/
│   ├── components/
│   └── utils/
└── vite/
```

| 路径 | 作用 |
| --- | --- |
| [package.json](package.json) | 前端依赖、脚本和运行环境约束 |
| [pnpm-lock.yaml](pnpm-lock.yaml) | 当前依赖锁文件 |
| [src/api](src/api) | 按功能域组织的接口客户端 |
| [src/views](src/views) | 系统管理、监控、工具、工作流、示例等页面 |
| [src/router](src/router) | 路由入口与导航装配 |
| [src/store](src/store) | Pinia 状态管理 |
| [src/components](src/components) | 复用组件 |
| [vite](vite) | Vite 插件与构建辅助配置 |

## 运行与构建

当前前端包管理器基线是 `pnpm`，版本解析受 [pnpm-lock.yaml](pnpm-lock.yaml) 和 [package.json](package.json) 中 `packageManager` 字段约束。

常用命令：

```bash
pnpm install
pnpm dev
pnpm build:prod
pnpm lint:eslint
pnpm prettier
```

如果需要验证改动对生产构建的影响，至少补一次 `pnpm build:prod`。

## 前端改动落位规则

- 新接口优先放到 [src/api](src/api) 对应功能域目录，不要把请求散落到页面中。
- 新页面优先放到 [src/views](src/views) 对应功能域目录。
- 路由变更同步检查 [src/router](src/router)。
- 状态变更同步检查 [src/store](src/store)。
- 若涉及菜单、权限、按钮或后端接口路径，必须联动核对后端模块与 API 摘要。

## 前端任务起步建议

- 新增业务页面：先读 [docs/architecture/business-extension-baseline.md](../docs/architecture/business-extension-baseline.md)
- 改认证、租户、登录相关页面：先读 [docs/design/feature-auth.md](../docs/design/feature-auth.md)
- 改后台主功能域页面：先读 [docs/design/feature-admin-domains.md](../docs/design/feature-admin-domains.md)
- 修接口漂移：先读 [docs/plans/frontend-backend-api-drift-fix-brief.md](../docs/plans/frontend-backend-api-drift-fix-brief.md)
- 做前端评审或自检：先读 [docs/reviews/frontend-code-review-checklist.md](../docs/reviews/frontend-code-review-checklist.md)

## 与上游的关系

本目录底层前端工程仍来自 plus-ui / RuoYi-Vue-Plus 体系，但当前仓库不再直接使用上游 README 作为本地导航入口。若需要查看上游背景资料，可自行参考：

- [plus-ui GitHub](https://github.com/dromara/plus-ui)
- [RuoYi-Vue-Plus 文档](https://plus-doc.dromara.org)
