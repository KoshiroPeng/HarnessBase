---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase Controller 与 Service 边界收敛验证证据，记录 ruoyi-demo 中 Controller 直连 Mapper 的首轮修复结果。
---

# 验证证据

## 基本信息

- 任务名称：Controller 直连 Mapper 首轮收敛
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：P2 代码与质量硬化，聚焦直接跨层调用和绕过 Service 的路径
- 变更范围：[TestBatchController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/TestBatchController.java)、[TestEncryptController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/TestEncryptController.java)、[ITestDemoService.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/service/ITestDemoService.java)、[TestDemoServiceImpl.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/service/impl/TestDemoServiceImpl.java)、[ITestDemoEncryptService.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/service/ITestDemoEncryptService.java)、[TestDemoEncryptServiceImpl.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/service/impl/TestDemoEncryptServiceImpl.java)、[docs/plans/backlog.md](../plans/backlog.md)

## 验证目标

- 本次需要证明什么：
  - `ruoyi-demo` 中 Controller 不再直接注入 Mapper
  - 原有批量示例和加解密示例仍通过 Service 层完成数据库操作
  - demo 模块本地编译通过
- 本次不覆盖什么：
  - 其他模块的跨层调用排查
  - 更深层次的领域边界重构
  - demo 模块页面或接口联调

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | Controller 直连 Mapper 残留扫描 | `rg -n "private final .*Mapper|private .*Mapper;|@Autowired" server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller server/ruoyi-admin/src/main/java/org/dromara/web/controller` | 通过 | 扫描结果为空，说明目标 Controller 范围内已无 Mapper 注入 |
| 2 | 批量示例边界收敛 | 检查 [TestBatchController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/TestBatchController.java) 与 [ITestDemoService.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/service/ITestDemoService.java) | 通过 | 批量新增、批量新增或更新、条件删除已统一转为 Service 调用 |
| 3 | 加解密示例边界收敛 | 检查 [TestEncryptController.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller/TestEncryptController.java) 与 [TestDemoEncryptServiceImpl.java](../../server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/service/impl/TestDemoEncryptServiceImpl.java) | 通过 | Controller 不再直接依赖 `TestDemoEncryptMapper`，改为通过轻量 Service 封装访问 |
| 4 | 差异格式检查 | `git diff --check` | 通过 | 未发现本次改动引入的空白或补丁格式问题 |
| 5 | 后端聚焦编译验证 | `cd server && mvn -B -pl ruoyi-modules/ruoyi-demo -am -DskipTests compile` | 通过 | `ruoyi-demo` 及其依赖链编译成功 |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，本次改动把 demo 控制器访问数据库的路径收敛回 Service 层。
- 是否仍存在历史残留：`ruoyi-demo` 首轮已收敛；其他模块的直接跨层调用仍需继续扫描。
- 若存在残留，是否已记录到 backlog：已在 [docs/plans/backlog.md](../plans/backlog.md) 记录后续继续排查。

## 关键命令或操作记录

```text
rg -n "private final .*Mapper|private .*Mapper;|@Autowired" server/ruoyi-modules/ruoyi-demo/src/main/java/org/dromara/demo/controller server/ruoyi-admin/src/main/java/org/dromara/web/controller
git diff --check
cd server
mvn -B -pl ruoyi-modules/ruoyi-demo -am -DskipTests compile
```

## 结果摘要

- 功能结果：`ruoyi-demo` 中两个直接注入 Mapper 的 Controller 已改为通过 Service 层处理数据库操作。
- 测试结果：静态扫描、补丁格式检查和 demo 模块聚焦编译均通过。
- 文档同步结果：backlog 已更新为“demo 首轮收敛完成，其他模块继续排查”。
- 发布或运行验证结果：未执行，本次改动未涉及发布脚本或运行参数。

## 未覆盖风险

- 本次只处理了 `ruoyi-demo` 中最直接的违规点，其他模块是否存在更隐蔽的跨层调用仍需继续筛查。
- `ITestDemoService` 为 demo 批量示例新增了两个方法，后续如继续扩展 demo 示例，应避免把演示便利性再次演变成跨层耦合。

## 后续动作

- 继续扫描其他模块中的 Controller / Service / Mapper 直接跨层路径。
- 将“Controller 直连 Mapper”扫描逐步纳入自动化护栏，避免回退。
