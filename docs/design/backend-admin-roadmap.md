---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 后台管理功能路线图，围绕当前微服务 system、monitor、tool、auth、file 能力组织。
---

# 后台管理功能路线图

## 目标

本文档用于描述当前后台管理系统的功能主线、前后端对应关系和后续收敛方向。功能域细节见 [docs/design/feature-admin-domains.md](feature-admin-domains.md)。

## 当前功能域

| 功能域 | 后端入口 | 前端入口 | 说明 |
| --- | --- | --- | --- |
| 认证与登录 | [server/ruoyi-auth](../../server/ruoyi-auth) | [web/src/api/login.js](../../web/src/api/login.js) | 登录、登出与认证链路 |
| 系统管理 | [server/ruoyi-modules/ruoyi-system](../../server/ruoyi-modules/ruoyi-system) | [web/src/views/system](../../web/src/views/system) | 用户、角色、部门、菜单、字典、参数、通知 |
| 监控 | [server/ruoyi-modules/ruoyi-system](../../server/ruoyi-modules/ruoyi-system) 与 [server/ruoyi-visual/ruoyi-monitor](../../server/ruoyi-visual/ruoyi-monitor) | [web/src/views/monitor](../../web/src/views/monitor) | 在线用户、日志、缓存、监控入口 |
| 工具 | [server/ruoyi-modules/ruoyi-gen](../../server/ruoyi-modules/ruoyi-gen) | [web/src/views/tool](../../web/src/views/tool) | 代码生成、表单构建 |
| 文件服务 | [server/ruoyi-modules/ruoyi-file](../../server/ruoyi-modules/ruoyi-file) | 通过业务页面接入 | 文件上传与存储能力 |

## 当前收敛重点

1. 让文档、API、响应码、SQL 脚本和发布材料匹配当前功能域。
2. 清理旧单体、旧前端栈和旧路径叙事。
3. 把 Harness Engineering 收敛为代码地图、检查清单、验证证据和自动化校验。
