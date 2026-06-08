---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 响应码与错误消息文档，统一说明 R、TableDataInfo、HttpStatus、GlobalExceptionHandler、SaTokenExceptionHandler 和 i18n 消息语义。
---

# 响应码与错误消息

## 当前模型

当前系统的普通 JSON API 主要使用 `R<T>` 作为统一响应结构：

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {}
}
```

事实入口：

- [R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/domain/R.java)
- [HttpStatus.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/constant/HttpStatus.java)
- [TableDataInfo.java](../../server/ruoyi-common/ruoyi-common-mybatis/src/main/java/org/dromara/common/mybatis/core/page/TableDataInfo.java)
- [GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-web/src/main/java/org/dromara/common/web/handler/GlobalExceptionHandler.java)
- [SaTokenExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-satoken/src/main/java/org/dromara/common/satoken/handler/SaTokenExceptionHandler.java)
- [server/ruoyi-admin/src/main/resources/i18n](../../server/ruoyi-admin/src/main/resources/i18n)

分页列表接口通常返回 `TableDataInfo<T>`：

```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [],
  "total": 0
}
```

## 通用 code

| code | 语义 | 说明 |
| --- | --- | --- |
| `200` | 成功 | `R.ok` 默认值 |
| `201` | 创建成功 | `HttpStatus.CREATED` 常量，当前不作为 `R.ok` 默认值 |
| `202` | 已接受 | `HttpStatus.ACCEPTED` 常量 |
| `204` | 无返回数据成功 | `HttpStatus.NO_CONTENT` 常量 |
| `301` | 永久重定向 | `HttpStatus.MOVED_PERM` 常量 |
| `303` | 重定向 | `HttpStatus.SEE_OTHER` 常量 |
| `304` | 未修改 | `HttpStatus.NOT_MODIFIED` 常量 |
| `400` | 请求错误 | JSON 解析、请求体读取等错误会显式返回 400；Bean Validation 异常当前多走 `R.fail(message)` |
| `401` | 未授权 | Sa-Token 未登录、SSE 认证失败或显式业务异常 |
| `403` | 权限不足 | Sa-Token 权限码或角色校验失败 |
| `404` | 不存在 | `NoHandlerFoundException` 返回 404；业务资源不存在当前多为 `ServiceException` 文案 |
| `405` | 方法不支持 | HTTP 方法不支持 |
| `409` | 冲突 | 常量已定义；具体业务冲突当前多通过 `ServiceException` 或 `R.fail` 文案表达 |
| `415` | 媒体类型不支持 | 常量已定义 |
| `500` | 失败或系统错误 | `R.fail` 默认值、`BaseController.toAjax(false)` 和多数兜底异常 |
| `501` | 未实现 | 常量已定义 |
| `601` | 警告 | `R.warn` |

## 异常映射

| 来源 | 当前响应方式 | 说明 |
| --- | --- | --- |
| `ServiceException` | 有 `code` 时使用该 code；否则 `R.fail(message)` | 业务服务最常用，默认 code 为 `500` |
| `BaseException` 及其子类 | `R.fail(e.getMessage())` | `UserException`、`CaptchaException`、`TenantException` 等会通过 i18n 消息键生成文案 |
| `NotLoginException` | `R.fail(401, "认证失败，无法访问系统资源")` | 由 Sa-Token 异常处理器处理 |
| `NotPermissionException`、`NotRoleException` | `R.fail(403, "没有访问权限，请联系管理员授权")` | 由 Sa-Token 异常处理器处理 |
| `HttpRequestMethodNotSupportedException` | `R.fail(405, e.getMessage())` | HTTP 方法不支持 |
| `NoHandlerFoundException` | `R.fail(404, "请求地址不存在")` | 路由不存在 |
| `JsonParseException`、`HttpMessageNotReadableException` | `R.fail(400, "...")` | 请求 JSON 或请求体解析失败 |
| `BindException`、`ConstraintViolationException`、`MethodArgumentNotValidException`、`HandlerMethodValidationException` | `R.fail(message)` | 当前 code 为默认 `500`，文案来自校验错误 |
| `RuntimeException`、`Exception` | `R.fail("发生未知异常，请联系管理员")` 或 `R.fail("发生系统异常，请联系管理员")` | 兜底异常，不向外暴露堆栈 |

## 主要 i18n 消息键

认证、用户、权限、验证码、租户、上传等文案位于：

- [messages.properties](../../server/ruoyi-admin/src/main/resources/i18n/messages.properties)
- [messages_zh_CN.properties](../../server/ruoyi-admin/src/main/resources/i18n/messages_zh_CN.properties)
- [messages_en_US.properties](../../server/ruoyi-admin/src/main/resources/i18n/messages_en_US.properties)

### 认证与租户

| 消息键 | 默认含义 |
| --- | --- |
| `user.jcaptcha.error` | 验证码错误 |
| `user.jcaptcha.expire` | 验证码已失效 |
| `user.password.not.match` | 用户不存在或密码错误 |
| `user.password.retry.limit.count` | 密码错误次数提示 |
| `user.password.retry.limit.exceed` | 密码错误超限并锁定 |
| `user.login.success` | 登录成功 |
| `user.logout.success` | 退出成功 |
| `user.register.success` | 注册成功 |
| `auth.grant.type.error` | 认证授权类型错误 |
| `auth.grant.type.blocked` | 认证授权类型已禁用 |
| `tenant.not.exists` | 租户不存在 |
| `tenant.blocked` | 租户已禁用 |
| `tenant.expired` | 租户已过期 |

### 权限、上传与限流

| 消息键 | 默认含义 |
| --- | --- |
| `no.permission` | 没有数据权限 |
| `no.create.permission` | 没有创建权限 |
| `no.update.permission` | 没有修改权限 |
| `no.delete.permission` | 没有删除权限 |
| `no.export.permission` | 没有导出权限 |
| `no.view.permission` | 没有查看权限 |
| `upload.exceed.maxSize` | 上传文件大小超过限制 |
| `upload.filename.exceed.length` | 上传文件名过长 |
| `repeat.submit.message` | 重复提交 |
| `rate.limiter.message` | 访问过于频繁 |

## 已知收敛项

- Bean Validation 类异常当前返回体 code 多为 `500`，但语义是请求参数校验失败。后续如要统一为 `400`，必须作为代码变更单独验证。
- 业务资源不存在、唯一性冲突、流程状态错误等多数通过 `ServiceException` 或 `R.fail` 文案表达，不存在独立枚举型业务错误码体系。
- 前端与后端接口差异记录在 [docs/reference/README.md](README.md) 的“已知差异”中。

## 维护要求

- 新增或修改错误消息时，同步默认、中文和英文 i18n 文件。
- 新增异常映射时，同步检查 [docs/conventions/error-handling.md](../conventions/error-handling.md)。
- 不要把旧 ProjectPilot 的 `PROJECT_NOT_FOUND`、`TASK_STATUS_INVALID`、`BILLING_*` 等错误码当成当前事实。
- 对外响应不得暴露堆栈、SQL、密钥或内部配置。
