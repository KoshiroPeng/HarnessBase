---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 测试规范

## 基本要求

- 新增业务代码必须有对应 JUnit 5 测试。
- 行覆盖率不低于 80%。
- 修复缺陷时，先补充能复现问题的回归测试，再修复实现。
- 测试不能依赖真实外部服务。

## 测试分层

| 类型 | 目标 | 示例 |
| --- | --- | --- |
| 单元测试 | 验证单个类或函数的业务规则 | Service 规则校验 |
| Mapper 测试 | 验证 SQL、映射和 MySQL 兼容性 | MyBatis-Plus 查询 |
| Controller 测试 | 验证 HTTP 入参出参和状态码 | REST API |
| 集成测试 | 验证关键链路协同 | 创建项目完整流程 |

## 推荐测试策略

- Service 测试优先覆盖业务规则、异常分支和事务边界。
- Controller 测试优先覆盖状态码、参数校验和错误响应格式。
- Mapper 测试优先覆盖自定义 SQL、分页、排序和条件查询。
- 外部系统通过 mock、stub 或测试容器替代。

## 命名规范

测试类以 `Test` 结尾：

```text
ProjectServiceTest
ProjectControllerTest
ProjectMapperTest
```

测试方法建议使用：

```text
methodName_shouldExpectedResult_whenCondition
```

示例：

```text
createProject_shouldReturnProject_whenRequestValid
createProject_shouldThrowException_whenNameDuplicated
```

## 测试数据

- 测试数据应最小化，只包含当前断言所需字段。
- 避免多个测试共享可变对象。
- 涉及数据库时，每个测试应保证独立可重复。
- 不要把生产数据复制到测试中。

## 回归测试

修复缺陷时，回归测试应做到：

- 修复前失败。
- 修复后通过。
- 测试名称能说明缺陷场景。
- 断言覆盖问题根因，而不是只覆盖表面结果。
