---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 命名规范，统一当前微服务模块、Java、前端、SQL、API 与文档命名方式。
---

# 命名规范

## 通用原则

- 优先沿用当前代码命名，不为局部改动创造第二套术语。
- 同一概念在 Java、SQL、API、前端和文档中使用同一语义。
- 英文命名保持简洁清晰，避免无意义缩写。

## Java 包与模块

当前根包主线是 `com.ruoyi`。新增代码优先放入现有包结构：

```text
com.ruoyi.gateway
com.ruoyi.auth
com.ruoyi.common.*
com.ruoyi.system.*
com.ruoyi.gen.*
com.ruoyi.job.*
com.ruoyi.file.*
com.ruoyi.modules.monitor
```

新增公共能力优先进入对应 `ruoyi-common-*`；新增业务能力优先进入对应 `ruoyi-modules/*`。

## Java 类名

| 类型 | 当前风格示例 |
| --- | --- |
| Controller | `SysUserController`、`TokenController` |
| Service 接口 | `ISysUserService` |
| Service 实现 | `SysUserServiceImpl` |
| Mapper | `SysUserMapper` |
| 业务对象 | `SysUserBo` |
| 视图对象 | `SysUserVo` |
| 实体 | `SysUser` |
| 配置类 | `RedisConfig` |

## 数据库命名

- 当前 SQL 脚本位于 [server/sql](../../server/sql)。
- 结构变更必须同步对应脚本。
- 当前没有 Flyway migration，不要假设存在 `Vxxx__xxx.sql` 命名体系。

## API 命名

当前接口路径沿用若依微服务风格，例如：

```text
/auth/login
/system/user/list
/monitor/online/list
/tool/gen/list
```

新增接口优先沿用现有模块路径和权限标识，不要引入无代码事实支撑的新 URL 风格。

## 前端命名

- API 封装按功能域放在 [web/src/api](../../web/src/api)。
- 页面按功能域放在 [web/src/views](../../web/src/views)。
- Vue 组件使用 PascalCase。
- 当前状态管理是 Vuex，不是 Pinia。

## 文档命名

- 文档文件名使用小写英文和连字符。
- 目录入口统一使用 `README.md`。
- 新增内部 Markdown 必须带元数据标头。
