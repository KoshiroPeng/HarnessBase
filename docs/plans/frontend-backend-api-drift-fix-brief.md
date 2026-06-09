---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 前后端接口漂移修复任务说明，用于记录若依微服务后端与 Vue 2 前端之间的接口事实差异、修复方式和验证要求。
---

# 前后端接口漂移修复任务说明

## 目标

本文档用于记录“前端接口调用”和“后端实际接口事实”之间出现偏差时，应该如何拆分任务、记录事实、执行修复和沉淀验证证据。

它不是历史修复日志的替代品，而是当前仓库继续处理接口漂移问题的工作入口。

## 适用范围

当前仓库的接口漂移判断，以以下真实结构为准：

- 后端业务入口：[server/ruoyi-modules](../../server/ruoyi-modules)
- 认证入口：[server/ruoyi-auth](../../server/ruoyi-auth)
- 网关入口：[server/ruoyi-gateway](../../server/ruoyi-gateway)
- 前端接口客户端：[web/src/api](../../web/src/api)
- 参考文档入口：[docs/reference/README.md](../reference/README.md)

本文档适用于以下场景：

- 前端请求了后端不存在的接口
- 后端已有接口，但前端仍在使用历史路径
- 前后端参数、方法、响应结构出现不一致
- 参考文档中保留了已过时接口事实

## 处理原则

1. 先核对真实 Controller、网关转发和前端调用点，不靠旧文档判断。
2. 如果后端已经存在可替代的真实接口，优先收敛前端，不优先扩写兼容接口。
3. 如果确实需要新增后端接口，必须同步考虑权限、审计、SQL、测试和文档。
4. 修复完成后，必须同步更新 [docs/reference/README.md](../reference/README.md) 和必要的参考文档。

## 标准处理步骤

### 第一步：记录事实

至少核对以下内容：

- 前端实际调用位置
- 后端真实 Controller 或网关入口
- 是否存在替代接口
- 是否已有历史验证证据

建议同时查看：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/plans/backlog.md](backlog.md)

### 第二步：判断修复策略

优先级建议：

1. 删除前端未使用或错误的历史接口封装
2. 前端切换到已存在的真实接口
3. 确认确有业务必要后，再新增后端接口

### 第三步：同步文档

根据影响范围，至少同步检查：

- [docs/reference/README.md](../reference/README.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- [docs/plans/backlog.md](backlog.md)

如果涉及权限、菜单或 SQL，还要同步检查：

- [server/sql](../../server/sql)
- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)

### 第四步：沉淀验证证据

修复完成后，建议使用：

- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

记录内容至少包括：

- 漂移事实
- 修复策略
- 影响范围
- 实际验证方式
- 未覆盖风险

## 验证建议

代码任务完成后，至少执行：

```bash
git diff --check
```

如果本次只改前端 API 封装，建议执行：

```bash
cd web
npm run build:prod
```

如果本次新增或修改后端接口，建议执行：

```bash
cd server
mvn -B -pl ruoyi-modules/目标模块 -am test
```

如果本机依赖不完整或命令无法执行，必须在验证证据里说明原因和替代验证方式。

## 与其他文档的关系

- 当前接口参考入口：[docs/reference/README.md](../reference/README.md)
- 当前技术基线：[docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- 当前代码地图：[docs/architecture/code-map.md](../architecture/code-map.md)
- 自动化同步提醒入口：[docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)

## 何时需要新建独立任务

出现以下情况时，建议不要继续在单一漂移任务中混写，而是拆成独立任务：

- 涉及多个服务模块
- 涉及网关、认证和业务服务联动
- 需要新增 SQL 或权限模型
- 需要补完整测试链路
- 需要同步发布材料或回滚策略
