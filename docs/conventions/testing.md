---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
---

# 测试规范

## 基本要求

- 新增或修改业务能力必须有与风险匹配的测试或验证说明。
- 修复缺陷时，优先补充能复现问题的回归测试，再修复实现。
- 测试不能依赖真实外部服务；需要外部交互时使用 mock、stub、测试容器或隔离环境。
- CTI、CRM、工单、客户资料等外部系统必须通过 adapter 或 integration 边界测试。

## 当前测试入口

CallCenter 后端：

```bash
cd services/callcenter-server
mvn -DskipTests package
```

如需执行后端测试：

```bash
cd services/callcenter-server
mvn test
```

CallCenter 前端：

```bash
cd services/callcenter-web
pnpm install
pnpm build:prod
```

历史骨架 `server/` 仅保留兼容校验：

```bash
cd server
mvn -B clean verify
```

## 测试分层

| 类型 | 目标 | 示例 |
| --- | --- | --- |
| 单元测试 | 验证单个类或函数的业务规则 | 坐席状态规则、通话事件转换 |
| Adapter 测试 | 验证外部系统适配边界 | CTI 回调解析、CRM 查询适配 |
| Controller 测试 | 验证 HTTP 入参出参和状态码 | 来电弹屏查询接口 |
| 集成测试 | 验证关键链路协同 | CTI 事件进入、推送坐席、记录落库 |
| 前端构建测试 | 验证类型、路由、构建和资源产物 | `pnpm build:prod` |

## 推荐测试策略

- Service 测试优先覆盖业务规则、异常分支和事务边界。
- Adapter 测试优先覆盖失败重试、超时、幂等和响应格式异常。
- 实时链路测试应覆盖连接建立、断线重连、重复事件、乱序事件和降级提示。
- Controller 测试优先覆盖状态码、参数校验和错误响应格式。
- 报表、转写、AI 质检等异步能力应覆盖任务创建、重试、失败记录和结果查询。

## 命名规范

测试类以 `Test` 结尾：

```text
CallEventAdapterTest
AgentStatusServiceTest
ScreenPopControllerTest
```

测试方法建议使用：

```text
methodName_shouldExpectedResult_whenCondition
```

示例：

```text
convertEvent_shouldReturnInternalEvent_whenCtiPayloadValid
syncAgentStatus_shouldIgnoreDuplicatedEvent_whenEventAlreadyHandled
```

## 回归测试

修复缺陷时，回归测试应做到：

- 修复前失败。
- 修复后通过。
- 测试名称能说明缺陷场景。
- 断言覆盖问题根因，而不是只覆盖表面结果。
