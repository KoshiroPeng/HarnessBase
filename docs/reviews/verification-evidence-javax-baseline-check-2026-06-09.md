---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase javax 基线核对验证证据，记录旧 EE 命名空间残留扫描结果与 javax.sql.DataSource 的边界说明。
---

# 验证证据

## 基本信息

- 任务名称：`javax.*` 基线边界核对
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：P2 代码与质量硬化，聚焦 Spring Boot 3 主线下 `javax.*` 历史残留识别
- 变更范围：[docs/plans/backlog.md](../plans/backlog.md)、[docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)

## 验证目标

- 本次需要证明什么：
  - 当前仓库内是否仍存在需要从 `javax.*` 迁移到 `jakarta.*` 的旧 EE 命名空间残留
  - `javax.sql.DataSource` 是否应视为需要整改的问题
  - 基线文档和 backlog 是否已明确这一边界
- 本次不覆盖什么：
  - 第三方依赖内部字节码或源码中的 `javax.*`
  - 未来新增代码的持续防回退自动化
  - 其他与 `javax.*` 无关的编码规范问题

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | 全仓 `javax.*` 扫描 | `rg -n "\\bjavax\\." server web docs deploy .github` | 通过 | 命中主要为文档规则说明和两个 `javax.sql.DataSource` 导入 |
| 2 | 旧 EE 命名空间精确扫描 | `rg -n "\\bjavax\\.(servlet|validation|persistence|annotation|ws|mail|xml|ejb|inject|transaction)\\b" server web docs deploy .github` | 通过 | 扫描结果为空，未发现需要迁移到 `jakarta.*` 的旧 EE API 使用 |
| 3 | `javax.sql.DataSource` 边界核对 | 检查 [DataBaseHelper.java](../../server/ruoyi-common/ruoyi-common-mybatis/src/main/java/org/dromara/common/mybatis/helper/DataBaseHelper.java) 与 [MyBatisDataSourceMonitor.java](../../server/ruoyi-modules/ruoyi-generator/src/main/java/org/dromara/generator/config/MyBatisDataSourceMonitor.java) | 通过 | 两处均为标准 JDBC `javax.sql.DataSource`，不属于 Jakarta 迁移目标 |
| 4 | 文档规则同步 | 检查 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md) 与 [docs/plans/backlog.md](../plans/backlog.md) | 通过 | 已补充“禁止旧 EE `javax.*`，但 `javax.sql.DataSource` 合法保留”的边界说明 |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，Spring Boot 3 主线下未发现需要迁移的旧 EE `javax.*` 残留。
- 是否仍存在历史残留：未发现需整改的旧 EE `javax.*` 残留；仅保留合法的 `javax.sql.DataSource`。
- 若存在残留，是否已记录到 backlog：无需作为代码整改项继续保留，backlog 已改为事实说明。

## 关键命令或操作记录

```text
rg -n "\bjavax\." server web docs deploy .github
rg -n "\bjavax\.(servlet|validation|persistence|annotation|ws|mail|xml|ejb|inject|transaction)\b" server web docs deploy .github
rg -n "\bjavax\.sql\.DataSource\b" server
```

## 结果摘要

- 功能结果：本次未修改业务代码，完成了 `javax.*` 规则边界纠偏。
- 测试结果：静态扫描结果表明当前仓库不存在需要迁移的旧 EE `javax.*` 生产代码残留。
- 文档同步结果：技术基线和 backlog 已明确 `javax.sql.DataSource` 不属于迁移目标。
- 发布或运行验证结果：未执行，本次变更仅涉及文档事实与规则澄清。

## 未覆盖风险

- 未来新增代码仍可能重新引入旧 EE `javax.*` 命名空间，需要后续以自动化护栏持续防回退。
- 本次未检查第三方依赖包内部实现，仅核对仓库源码与文档。

## 后续动作

- 将 `javax.*` 精确扫描逐步纳入自动化护栏，避免把合法的 `javax.sql.DataSource` 与非法旧 EE API 混为一谈。
- 继续进入下一条规范治理，例如扫描裸 HTTP 客户端或直接跨层调用。
