---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 后端工程入口，汇总后端模块结构、构建方式、SQL 脚本入口与协作文档导航。
---

# 后端工程入口

## 目标

本文档作为 HarnessBase 后端工程的本地入口，帮助开发者和 AI 协作者快速确认后端模块结构、启动模块、SQL 脚本位置、构建方式与必读文档。

当前后端真实代码以 [server/pom.xml](pom.xml) 和各子模块源码为准；如果与上游 RuoYi-Vue-Plus 宣传材料冲突，以本仓库代码事实和 [AGENTS.md](../AGENTS.md) 为准。

## 快速导航

- [AGENTS.md](../AGENTS.md)：仓库级协作规则与硬性约束
- [docs/README.md](../docs/README.md)：统一文档导航入口
- [docs/architecture/code-map.md](../docs/architecture/code-map.md)：真实代码地图
- [docs/architecture/boundaries.md](../docs/architecture/boundaries.md)：模块边界与依赖规则
- [docs/architecture/target-technology-baseline.md](../docs/architecture/target-technology-baseline.md)：当前技术基线
- [docs/reference/sql-change-checklist.md](../docs/reference/sql-change-checklist.md)：SQL 变更模板与检查清单
- [deploy/release/README.md](../deploy/release/README.md)：发布脚本与发布检查入口

## 当前结构

```text
server/
├── pom.xml
├── ruoyi-admin/
├── ruoyi-common/
├── ruoyi-modules/
├── ruoyi-extend/
└── script/
```

| 路径 | 作用 |
| --- | --- |
| [pom.xml](pom.xml) | 后端 Maven 根工程，定义版本、模块和依赖管理 |
| [ruoyi-admin](ruoyi-admin) | Spring Boot 启动模块与最终打包入口 |
| [ruoyi-common](ruoyi-common) | 公共基础能力，如 core、web、mybatis、tenant、redis、satoken、excel、log |
| [ruoyi-modules](ruoyi-modules) | 系统管理、代码生成、工作流、任务、示例等主业务模块 |
| [ruoyi-extend](ruoyi-extend) | Spring Boot Admin、SnailJob Server 等独立扩展 |
| [script](script) | SQL、Docker、运行脚本与示例流程数据 |

## 构建与测试

常用命令：

```bash
mvn -B -DskipTests package
mvn -B test
```

如果需要只构建启动模块或联动打包，先核对 [ruoyi-admin/pom.xml](ruoyi-admin/pom.xml) 与根 [pom.xml](pom.xml) 的模块关系，再决定是否使用 `-pl` 或 `-am`。

## 数据库脚本事实

当前仓库没有落地 Flyway migration。数据库结构事实入口在 [script/sql](script/sql)：

- `ry_vue_5.X.sql`
- `ry_job.sql`
- `ry_workflow.sql`
- `update/` 升级脚本
- `oracle/`、`postgres/`、`sqlserver/` 兼容脚本

涉及表结构、菜单、字典、权限、工作流数据或初始化数据变更时，必须同步检查这些脚本，而不是只改 Java 代码或文档。

## 后端任务起步建议

- 新增业务能力：先读 [docs/architecture/business-extension-baseline.md](../docs/architecture/business-extension-baseline.md)
- 改模块边界或共用能力：先读 [docs/architecture/boundaries.md](../docs/architecture/boundaries.md)
- 改数据库脚本：先读 [docs/reference/sql-change-checklist.md](../docs/reference/sql-change-checklist.md)
- 做后端自检或评审：先读 [docs/reviews/backend-code-review-checklist.md](../docs/reviews/backend-code-review-checklist.md)
- 改发布相关：先读 [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)

## 与上游的关系

本目录底层代码仍来自 RuoYi-Vue-Plus 体系，但当前仓库并不直接复用上游 README 作为本地协作入口。若需要查看上游背景资料，可自行参考：

- [RuoYi-Vue-Plus GitHub](https://github.com/dromara/RuoYi-Vue-Plus)
- [RuoYi-Vue-Plus 文档](https://plus-doc.dromara.org)
