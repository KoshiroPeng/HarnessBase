# 前端工程

`services/callcenter-web/` 存放从 CallCenter 合并进来的 Vue 前端代码，当前基于 plus-ui 裁剪版，作为管理后台和后续坐席工作台的前端基础。

## 目录说明

- `package.json`：前端依赖和脚本入口。
- `src/api/`：接口调用。
- `src/views/`：页面视图。
- `src/components/`：通用组件。
- `src/router/`：路由配置。
- `src/store/`：Pinia 状态管理。
- `public/`：静态资源。

## 常用命令

```bash
pnpm install
pnpm dev
pnpm build:prod
pnpm lint:eslint
```

## 开发约定

- 后续坐席工作台、话务条、来电弹屏和聊天界面应形成独立视图区，不和系统管理页面混写。
- 实时交互相关代码需要明确连接状态、重连策略和错误提示。
- 当前仓库不再保留第三方归档目录；如需补充上游参考资料，应先确认是否真的服务当前实现。
