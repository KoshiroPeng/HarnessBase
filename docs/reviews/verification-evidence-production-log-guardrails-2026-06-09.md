---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 生产代码日志护栏收敛验证证据，记录 System.out.println、printStackTrace 与字段注入首轮清理结果。
---

# 验证证据

## 基本信息

- 任务名称：生产代码日志护栏首轮收敛
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：P2 代码与质量硬化，聚焦 `System.out.println`、`printStackTrace` 与字段注入残留
- 变更范围：[DromaraApplication.java](../../server/ruoyi-admin/src/main/java/org/dromara/DromaraApplication.java)、[MonitorAdminApplication.java](../../server/ruoyi-extend/ruoyi-monitor-admin/src/main/java/org/dromara/monitor/admin/MonitorAdminApplication.java)、[RedisCacheController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/RedisCacheController.java)、[RedisPubSubController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/RedisPubSubController.java)、[RedisLockController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/RedisLockController.java)、[ServletUtils.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/utils/ServletUtils.java)、[docs/plans/backlog.md](../plans/backlog.md)

## 验证目标

- 本次需要证明什么：
  - 生产代码主路径中已不再保留 `System.out.println` 和 `printStackTrace`
  - 启动类、demo 控制器和通用工具类已收敛到统一日志体系
  - 触达文件中的一个字段级 `@Autowired` 已同步改为构造器注入
- 本次不覆盖什么：
  - 测试代码中的 `System.out.println`
  - 其他尚未扫描到的代码规范问题
  - AWS SDK 依赖问题修复

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | 生产代码残留扫描 | `rg -n "System\\.out\\.println|e\\.printStackTrace\\(|printStackTrace\\(" server/ruoyi-admin/src/main/java server/ruoyi-common/ruoyi-common-core/src/main/java server/ruoyi-modules/ruoyi-demo/src/main/java server/ruoyi-extend/ruoyi-monitor-admin/src/main/java` | 通过 | 本次扫描结果为空，说明目标生产代码范围内已清理完成 |
| 2 | 测试残留隔离确认 | `rg -n "System\\.out\\.println|e\\.printStackTrace\\(|printStackTrace\\(" server/ruoyi-admin/src/test/java server/ruoyi-common server/ruoyi-modules server/ruoyi-extend` | 通过 | 剩余命中均位于 `server/ruoyi-admin/src/test/java/org/dromara/test` |
| 3 | 字段注入收敛 | 检查 [RedisLockController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/RedisLockController.java) | 通过 | `LockTemplate` 已改为 `@RequiredArgsConstructor` + `final` 构造器注入 |
| 4 | 差异格式检查 | `git diff --check` | 通过 | 未发现本次改动引入的空白或补丁格式问题 |
| 5 | 后端聚焦编译验证 | `cd server && mvn -B -pl ruoyi-admin,ruoyi-common/ruoyi-common-core,ruoyi-modules/ruoyi-demo,ruoyi-extend/ruoyi-monitor-admin -am -DskipTests compile` | 未完全通过 | 相关模块源码编译推进正常，但被现存 `ruoyi-common-oss` 的 AWS SDK 依赖缺失阻塞，非本次改动引入 |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，本次改动遵循 JDK 17 / Spring Boot 3 主线和统一日志规范。
- 是否仍存在历史残留：存在，测试代码中仍保留 `System.out.println`，以及 `ruoyi-common-oss` 的现存依赖问题。
- 若存在残留，是否已记录到 backlog：已记录到 [docs/plans/backlog.md](../plans/backlog.md)。

## 关键命令或操作记录

```text
rg -n "System\.out\.println|e\.printStackTrace\(|printStackTrace\(" server/ruoyi-admin/src/main/java server/ruoyi-common/ruoyi-common-core/src/main/java server/ruoyi-modules/ruoyi-demo/src/main/java server/ruoyi-extend/ruoyi-monitor-admin/src/main/java
git diff --check
cd server
mvn -B -pl ruoyi-admin,ruoyi-common/ruoyi-common-core,ruoyi-modules/ruoyi-demo,ruoyi-extend/ruoyi-monitor-admin -am -DskipTests compile
```

## 结果摘要

- 功能结果：生产代码中的启动输出、demo 调试输出和 `printStackTrace` 已收敛为日志输出。
- 测试结果：静态扫描和补丁格式检查通过；后端聚焦编译被现存 AWS SDK 依赖问题阻塞，未证明为本次改动回归。
- 文档同步结果：backlog 已更新为“生产代码已完成首轮收敛，测试残留待后续清理”。
- 发布或运行验证结果：未执行，本次改动未涉及发布脚本或运行参数。

## 未覆盖风险

- `server/ruoyi-admin/src/test/java/org/dromara/test` 下仍存在测试输出残留，后续若需要统一测试规范，需单独清理。
- `ruoyi-common-oss` 当前存在 AWS SDK 依赖缺失问题，导致本次无法以整条 Maven 编译通过作为最终证据。

## 后续动作

- 后续单独处理测试代码中的 `System.out.println`，优先替换为断言或更可读的测试输出方式。
- 将 `ruoyi-common-oss` 的 AWS SDK 依赖异常作为独立质量问题排查，恢复后端完整编译验证链路。
