---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 测试规范，约束单元测试、回归测试、联调验证与测试证据记录范围。
---

# 测试规范

如果你是从开发、缺陷修复或测试评审任务进入，建议先结合 [docs/conventions/task-startup-checklist.md](task-startup-checklist.md) 一起使用。

## 基本要求

- 后端新增业务代码必须有对应 JUnit 5 测试。
- 前端新增核心逻辑、状态管理或共享工具时，先确认当前仓库的测试落位方式，再补对应测试或联调验证证据。
- 修复缺陷时，优先补充能复现问题的回归测试，再修复实现。
- 测试不能依赖真实外部服务。

## 测试分层

| 类型 | 目标 | 示例 |
| --- | --- | --- |
| 单元测试 | 验证单个类或函数的业务规则 | Service 规则校验 |
| Mapper 测试 | 验证 SQL、映射和分页兼容性 | MyBatis 查询 |
| Controller 测试 | 验证 HTTP 入参与出参、状态码 | REST API |
| 前端逻辑测试 | 验证 store、工具函数、权限判断与关键交互逻辑 | Vuex、formatter、permission |
| 集成测试 | 验证关键链路协同 | 登录、用户管理或任务主链路 |

## 推荐测试策略

- Service 测试优先覆盖业务规则、异常分支和事务边界。
- Controller 测试优先覆盖状态码、参数校验和错误响应格式。
- Mapper 测试优先覆盖自定义 SQL、分页、排序和条件查询。
- 前端验证优先覆盖权限判断、表单校验、请求状态切换和关键交互分支。
- 外部系统通过 mock、stub 或测试容器替代。

## 命名规范

测试类以 `Test` 结尾：

```text
SysUserServiceTest
SysUserControllerTest
SysUserMapperTest
```

测试方法建议使用：

```text
methodName_shouldExpectedResult_whenCondition
```

示例：

```text
createUser_shouldReturnSuccess_whenRequestValid
createUser_shouldFail_whenUserNameDuplicated
```

## 测试数据

- 测试数据应最小化，只包含当前断言所需字段。
- 避免多个测试共享可变对象。
- 涉及数据库时，每个测试应保证独立可重复。
- 不要把生产数据复制到测试中。
- 前端验证中的接口数据应最小化 mock，避免把完整后端返回体硬编码进大量测试。

## 回归测试

修复缺陷时，回归测试应做到：

- 修复前失败。
- 修复后通过。
- 测试名称能说明缺陷场景。
- 断言覆盖问题根因，而不只是表面结果。

## 配套入口

- [docs/reviews/testcase-review-checklist.md](../reviews/testcase-review-checklist.md)
- [docs/reviews/templates/testcase-review-template.md](../reviews/templates/testcase-review-template.md)
- [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
- [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
- [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
