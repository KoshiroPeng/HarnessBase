---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 前后端接口差异修复任务说明，聚焦 workflow definition XML 路径和 monitor cache 前端残留。
---

# 前后端接口差异修复任务说明

## 目标

本文档把当前已知的前后端接口差异收敛成后续代码任务说明。它不是本轮文档治理的延续，而是给下一轮允许修改代码时使用的执行入口。

当前优先处理两类差异：

1. workflow definition XML 路径差异。
2. monitor cache 前端缓存细分接口残留。

## 当前边界

- 本文档只定义任务、证据、推荐处理路径和验收标准。
- 本文档不修改 [web](../../web) 或 [server](../../server) 代码。
- 代码修复前仍需重新执行一次 `git status` 和源码核对，防止分支已经变化。

## 差异一：workflow definition XML 路径

### 当前事实

| 位置 | 当前事实 |
| --- | --- |
| [web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts) | 同时存在 `definitionXml(definitionId)` 和 `xmlString(id)` 两个 XML 相关封装 |
| [FlwDefinitionController.java](../../server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java) | 后端存在 `/workflow/definition/xmlString/{id}`，没有 `/workflow/definition/definitionXml/{definitionId}` |
| [docs/reference/README.md](../reference/README.md) | 已记录该前后端差异，API 摘要不应写入不存在的 `definitionXml` 路径 |

前端证据：

```text
web/src/api/workflow/definition/index.ts:36-40 definitionXml -> /workflow/definition/definitionXml/${definitionId}
web/src/api/workflow/definition/index.ts:115-119 xmlString -> /workflow/definition/xmlString/${id}
```

后端证据：

```text
server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java:188-191 @GetMapping("/xmlString/{id}")
```

### 推荐处理路径

推荐优先删除或替换前端 `definitionXml` 残留，而不是新增后端兼容接口。

理由：

- 后端已经存在真实可用的 `xmlString/{id}`。
- 前端同一文件已经存在 `xmlString(id)` 封装。
- 新增后端兼容接口会扩大 API 面，且容易让历史路径继续存活。

执行时应先搜索 `definitionXml` 调用点：

```bash
rg -n "definitionXml" web/src
```

如果没有实际调用点，删除 `definitionXml` 封装和对应未使用类型导入。

如果存在调用点，将调用改为 `xmlString(id)`，并按实际返回类型同步前端类型声明。

### 验收标准

- [ ] [web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts) 不再请求 `/workflow/definition/definitionXml/{definitionId}`。
- [ ] 前端仍能通过 `/workflow/definition/xmlString/{id}` 获取流程定义 JSON/XML 字符串。
- [ ] [docs/reference/README.md](../reference/README.md) 的该差异记录已删除或改为“已修复”。
- [ ] [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 不新增 `definitionXml` 路径。
- [ ] 前端类型检查或相关构建命令通过；若未执行，必须记录原因。

## 差异二：monitor cache 前端残留

### 当前事实

| 位置 | 当前事实 |
| --- | --- |
| [web/src/api/monitor/cache/index.ts](../../web/src/api/monitor/cache/index.ts) | 除 `/monitor/cache` 外，还保留 `getNames`、`getKeys`、`getValue`、`clearCacheName`、`clearCacheKey`、`clearCacheAll` 请求 |
| [CacheController.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java) | 当前只暴露 `GET /monitor/cache` |
| [docs/reference/README.md](../reference/README.md) | 已记录该前后端差异，API 摘要不应写入缓存细分残留路径 |

前端证据：

```text
web/src/api/monitor/cache/index.ts:6-10 getCache -> /monitor/cache
web/src/api/monitor/cache/index.ts:14-58 listCacheName/listCacheKey/getCacheValue/clearCacheName/clearCacheKey/clearCacheAll -> /monitor/cache/*
```

后端证据：

```text
server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java:23 @RequestMapping("/monitor/cache")
server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java:31-33 @GetMapping()
```

### 推荐处理路径

推荐先判断前端页面是否实际调用缓存细分接口：

```bash
rg -n "listCacheName|listCacheKey|getCacheValue|clearCacheName|clearCacheKey|clearCacheAll" web/src
```

处理原则：

- 如果页面没有实际调用这些函数，删除前端 API 残留和未使用类型。
- 如果页面仍调用这些函数，但当前产品只需要缓存概览，收敛页面交互，只保留 `getCache()`。
- 如果产品确实需要缓存名称、键值和清理能力，则作为后端功能补齐任务处理，并同步权限、审计日志、接口摘要、测试和安全评估。

在没有明确需求前，不建议直接补齐后端清理接口。

理由：

- 缓存清理属于高影响操作，不能只为了匹配前端残留而新增。
- 当前后端 `CacheController` 只有概览接口，说明当前落地范围更偏监控而不是缓存管理。
- 若补齐删除接口，必须设计权限、审计和误操作保护。

### 验收标准

- [ ] 前端不再请求后端不存在的 `/monitor/cache/getNames`、`/getKeys`、`/getValue`、`/clearCacheName`、`/clearCacheKey`、`/clearCacheAll`，或后端明确补齐这些接口。
- [ ] 如果新增后端缓存清理接口，必须有权限校验、操作日志和风险说明。
- [ ] [docs/reference/README.md](../reference/README.md) 的缓存差异记录已删除、改为“已修复”或更新为新的真实事实。
- [ ] [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 只列真实存在且已核对的接口。
- [ ] 前端构建、后端测试或对应聚焦验证通过；若未执行，必须记录原因。

## 推荐执行顺序

1. 先修 workflow definition XML 路径，因为它已经有明确后端替代入口。
2. 再处理 monitor cache 前端残留，因为它需要先判断是否保留缓存清理能力。
3. 每修完一类差异，同步更新 [docs/reference/README.md](../reference/README.md)。
4. 如果实际接口发生变化，同步检查 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
5. 如果涉及权限、菜单或 SQL，同步检查 [server/script/sql](../../server/script/sql) 和 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)。

## 验证建议

代码任务完成后至少执行：

```bash
git diff --check
```

前端只改 API 封装时，建议执行：

```bash
cd web
pnpm lint
pnpm build:prod
```

后端如果新增或调整 Controller，建议执行：

```bash
cd server
mvn -B test
```

若本机依赖不完整或命令不可执行，必须在验证证据中写明原因，并记录替代验证方式。

## 文档同步清单

代码修复完成后同步检查：

- [docs/reference/README.md](../reference/README.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- [docs/plans/backlog.md](backlog.md)
- [docs/reviews/verification-evidence-doc-governance-2026-06-08.md](../reviews/verification-evidence-doc-governance-2026-06-08.md) 或新的验证证据文档
