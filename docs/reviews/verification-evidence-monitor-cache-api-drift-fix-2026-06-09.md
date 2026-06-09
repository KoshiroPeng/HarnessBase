---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase monitor cache 前后端接口漂移修复验证证据，记录前端残留接口删除、文档同步和前端构建验证结果。
---

# 验证证据

## 基本信息

- 任务名称：monitor cache 前后端接口漂移修复
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：前端 API 客户端残留与后端 `CacheController` 不一致
- 变更范围：[web/src/api/monitor/cache/index.ts](../../web/src/api/monitor/cache/index.ts)、[docs/reference/README.md](../reference/README.md)、[docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)、[docs/plans/backlog.md](../plans/backlog.md)

## 验证目标

- 本次需要证明什么：
  - 前端不再保留后端不存在的 monitor cache 细分接口封装
  - 页面仍可通过 `getCache()` 访问真实存在的 `/monitor/cache`
  - reference 与漂移任务文档已经同步收敛
- 本次不覆盖什么：
  - workflow definition XML 路径差异修复
  - 后端缓存清理接口设计与实现
  - 发布流程或后端测试验证

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | 页面调用范围核对 | `rg -n "listCacheName|listCacheKey|getCacheValue|clearCacheName|clearCacheKey|clearCacheAll" web/src` | 通过 | 仅命中 `web/src/api/monitor/cache/index.ts`，页面未实际调用这些残留接口 |
| 2 | 前端 API 封装收敛 | 检查 [web/src/api/monitor/cache/index.ts](../../web/src/api/monitor/cache/index.ts) | 通过 | 已删除不存在后端接口对应的 6 个封装，只保留 `getCache()` |
| 3 | 后端事实核对 | 检查 [CacheController.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java) | 通过 | 后端当前仍只暴露 `GET /monitor/cache` |
| 4 | 文档同步核对 | 检查 [docs/reference/README.md](../reference/README.md)、[docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)、[docs/plans/backlog.md](../plans/backlog.md) | 通过 | monitor cache 差异已从“待修复”收敛为“已处理”，未再保留为已知漂移项 |
| 5 | 前端构建验证 | `cd web && pnpm build:prod` | 通过 | 已在 `pnpm approve-builds --all` 后完成生产构建，`vite build --mode production` 成功，存在大体积 chunk 警告但不影响本次接口漂移收敛 |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，前端 API 客户端与真实后端 Controller 事实对齐。
- 是否仍存在历史残留：workflow definition XML 路径差异仍存在。
- 若存在残留，是否已记录到 backlog：已记录到 [docs/plans/backlog.md](../plans/backlog.md)。

## 关键命令或操作记录

```text
rg -n "listCacheName|listCacheKey|getCacheValue|clearCacheName|clearCacheKey|clearCacheAll" web/src
cd web
pnpm approve-builds --all
pnpm build:prod
```

## 结果摘要

- 功能结果：monitor cache 前端 API 封装已收敛到真实存在的概览接口。
- 测试结果：聚焦代码核对通过，前端生产构建通过。
- 文档同步结果：reference、任务简报和 backlog 已同步更新。
- 发布或运行验证结果：未执行，本次变更未涉及发布脚本或运行环境。

## 未覆盖风险

- 本次前端构建出现大体积 chunk 警告，属于现存打包体积问题，不是 monitor cache 漂移修复引入的新回归。
- workflow definition XML 路径差异仍需作为下一项代码任务继续处理。

## 后续动作

- 将 `web/pnpm-workspace.yaml` 中的 `allowBuilds` 配置纳入版本管理，避免 `pnpm 11` 在新环境中因依赖构建脚本审批阻塞前端安装与构建。
- 进入下一项真实代码任务：修复 workflow definition XML 路径差异。
