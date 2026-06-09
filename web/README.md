---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 前端工程入口，汇总当前 Vue 2 管理后台结构、常用命令、目录职责与前端协作导航。
---

# 前端工程入口

## 目标

本文档是 HarnessBase 前端工程的本地入口，围绕当前仓库中的 Vue 2 管理后台结构、运行方式、目录职责和协作导航组织。

## 当前结构

前端根目录：[web](.)

```text
web/
├── src/api/
├── src/assets/
├── src/components/
├── src/directive/
├── src/layout/
├── src/plugins/
├── src/router/
├── src/store/
├── src/utils/
├── src/views/
├── App.vue
├── main.js
└── package.json
```

## 关键目录

| 路径 | 说明 |
| --- | --- |
| [src/api](./src/api) | 前端接口请求封装 |
| [src/views/system](./src/views/system) | 系统管理页面 |
| [src/views/monitor](./src/views/monitor) | 监控相关页面 |
| [src/views/tool](./src/views/tool) | 工具页，例如代码生成 |
| [src/router](./src/router) | Vue Router 3 路由入口 |
| [src/store](./src/store) | Vuex 状态管理 |
| [src/layout](./src/layout) | 全局布局 |
| [src/components](./src/components) | 通用组件 |
| [src/utils](./src/utils) | 公共工具方法 |

## 常用命令

在 [web](.) 目录执行：

```bash
npm install
npm run dev
npm run build:stage
npm run build:prod
```

浏览器默认访问：`http://localhost:80`

## 关键入口

- 应用入口：[main.js](./src/main.js)
- 路由入口：[router/index.js](./src/router/index.js)
- 状态入口：[store/index.js](./src/store/index.js)
- 包配置：[package.json](./package.json)

## 开发时重点关注

- 真实代码地图：[docs/architecture/code-map.md](../docs/architecture/code-map.md)
- 前端开发执行指南：[docs/conventions/task-startup-checklist.md#开发前端代码](../docs/conventions/task-startup-checklist.md#开发前端代码)
- 前端代码评审清单：[docs/reviews/frontend-code-review-checklist.md](../docs/reviews/frontend-code-review-checklist.md)
- 前端设计评审清单：[docs/reviews/frontend-design-review-checklist.md](../docs/reviews/frontend-design-review-checklist.md)
- API 与后端契约入口：[docs/reference/README.md](../docs/reference/README.md)

## 当前技术栈提醒

- 当前前端主语言是 JavaScript。
- 当前构建工具是 Vue CLI。
- 当前状态管理是 Vuex。
- 当前仓库未见前端自动化测试基线；如果要补测试，需要先结合当前工具链设计落位。

## 维护规则

- 新增或调整前端目录结构时，必须同步更新本文档和 [docs/architecture/code-map.md](../docs/architecture/code-map.md)。
- 如果目录变化会影响开发、评审、发布或联调主路径，必须同步更新 [docs/README.md](../docs/README.md)。
