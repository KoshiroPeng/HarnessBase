---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 业务扩展基线，定义新增业务功能时的仓库影响图、结构化任务、模块落位和验证闭环。
---

# 业务扩展基线

## 目标

本文档定义 HarnessBase 作为后续业务项目基线时的扩展方式。新增业务功能不能只按“写一个接口”或“加一个页面”推进，而要按可验证的纵向切片完成后端、前端、SQL、权限、测试、文档和发布影响的闭环。

HarnessBase 当前代码事实是若依微服务后台管理系统。业务扩展应优先复用当前 [模块边界](boundaries.md)、[代码地图](code-map.md)、[功能域图谱](../design/feature-admin-domains.md) 和 [任务启动清单](../conventions/task-startup-checklist.md)，并与 [server/README.md](../../server/README.md)、[web/README.md](../../web/README.md) 的真实工程入口保持一致，不要重新规划一套脱离现有代码的目标结构。

## 适用场景

以下任务开始前必须阅读本文档：

- 新增一个业务域或后台管理模块
- 为现有业务域新增列表、详情、表单、导入、导出或状态流转
- 新增菜单、按钮权限、字典、配置项或初始化数据
- 新增或调整前后端 API 契约
- 新增业务表、字段、索引、关联关系或升级脚本

## 仓库影响图

任何新增业务功能进入实现前，先产出一份最小仓库影响图。影响图不是长篇方案，只回答“真实代码会动哪里、复用什么、怎么验收”。

```md
## 仓库影响图

### 后端

- 服务或模块：
- 需要修改的真实文件：
- 需要复用的类、接口、Mapper、配置或公共模块：
- 是否涉及 Feign / 远程 API：

### 前端

- API 封装：
- 页面或组件：
- 路由、菜单、按钮权限或状态管理：

### 数据和发布

- SQL 脚本：
- 初始化数据、字典、菜单或权限：
- 环境变量、发布、回滚或观测影响：

### 验证

- 后端验证：
- 前端验证：
- SQL / 权限 / 发布验证：
- 未覆盖风险：
```

影响图必须基于真实文件和现有模式填写，不允许写不存在的路径、计划中的技术栈或旧项目目录。影响图确认后，再进入结构化任务拆分。

## 结构化任务模板

后续业务代码建议按下面模板拆成可执行任务。任务越具体，agent 越不容易在微服务边界、前后端契约和测试范围上发散。

```md
## 任务

- 目标：
- 业务范围：
- 不做范围：

## 真实文件范围

- 后端：
- 前端：
- SQL：
- 文档：

## 实现约束

- 复用的现有模式：
- 需要遵守的模块边界：
- API、错误码、权限或发布同步要求：

## 验收标准

- [ ]
- [ ]

## 测试和验证

- [ ]
- [ ]
```

## 纵向切片顺序

新增业务功能默认按下面顺序推进：

1. 定义仓库影响图：确认真实文件范围、复用模式、同步文档和验证方式。
2. 定义业务边界：确认功能属于 `gateway`、`auth`、`system`、`gen`、`job`、`file`、`monitor` 还是需要新增正式业务服务。
3. 定义数据边界：确认表、字段、索引、字典、菜单和权限是否需要进入 SQL 脚本。
4. 定义后端契约：确认 Controller 路径、权限标识、请求对象、响应对象、Service、Mapper 和异常语义。
5. 定义前端入口：确认 API 封装、页面、路由、菜单、按钮权限、表单校验和状态管理。
6. 定义测试范围：按风险补齐后端 JUnit 5、前端联调验证或当前工具链下的测试。
7. 定义文档同步：同步 API 摘要、错误码、SQL 清单、设计说明、评审或验证证据。
8. 定义发布影响：确认 SQL 升级、环境变量、制品路径、回滚和观测入口是否受影响。

## 后端落位规则

| 变更类型 | 优先落位 | 说明 |
| --- | --- | --- |
| 网关入口、统一路由、过滤、验证码 | [server/ruoyi-gateway](../../server/ruoyi-gateway) | 入口流量控制、统一拦截与网关层逻辑 |
| 登录、鉴权、令牌、认证策略 | [server/ruoyi-auth](../../server/ruoyi-auth) | 认证服务，不放到业务服务里 |
| 系统管理能力 | [server/ruoyi-modules/ruoyi-system](../../server/ruoyi-modules/ruoyi-system) | 用户、角色、部门、菜单、参数、日志等 |
| 代码生成能力 | [server/ruoyi-modules/ruoyi-gen](../../server/ruoyi-modules/ruoyi-gen) | 表元数据与生成逻辑 |
| 任务调度能力 | [server/ruoyi-modules/ruoyi-job](../../server/ruoyi-modules/ruoyi-job) | 调度服务能力 |
| 文件服务能力 | [server/ruoyi-modules/ruoyi-file](../../server/ruoyi-modules/ruoyi-file) | 文件上传、下载与存储适配 |
| 通用基础能力 | [server/ruoyi-common](../../server/ruoyi-common) | 只有跨服务复用且语义稳定时进入 common |
| 服务间共享契约 | [server/ruoyi-api](../../server/ruoyi-api) | DTO、Feign、远程接口定义 |
| 可视化监控能力 | [server/ruoyi-visual](../../server/ruoyi-visual) | 独立监控与可视化服务 |

## 前端落位规则

| 变更类型 | 优先落位 | 说明 |
| --- | --- | --- |
| API 封装 | [web/src/api](../../web/src/api) | 路径、方法、参数和返回值必须能回到后端 Controller 核对 |
| 页面与业务组件 | [web/src/views](../../web/src/views) | 按 `system`、`monitor`、`tool` 等功能域组织 |
| 共享组件 | [web/src/components](../../web/src/components) | 只有跨页面复用且语义稳定时抽出 |
| 路由 | [web/src/router](../../web/src/router) | 与菜单、权限和页面路径保持一致 |
| 全局状态 | [web/src/store](../../web/src/store) | 只放跨页面共享状态 |

## SQL、菜单和权限

当前数据库事实由 [server/sql](../../server/sql) 维护。涉及表结构、初始化数据、字典、菜单和权限数据时，必须同步检查：

- [server/sql](../../server/sql) 中对应脚本
- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- 菜单权限与前端按钮/后端权限注解是否一致

## API、错误码和响应

新增或调整 API 时必须确认：

- 后端路径、HTTP 方法、权限标识和前端 API 封装一致
- 涉及新增错误语义时，同步 [docs/reference/error-codes.md](../reference/error-codes.md)
- 代表性接口变更时，同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 或说明由运行时文档覆盖

## 测试和验证

新增业务功能至少按风险选择以下验证：

| 范围 | 推荐验证 |
| --- | --- |
| Service 规则 | JUnit 5 单元测试 |
| Controller 契约 | Web 层或集成验证 |
| Mapper / SQL | 数据访问验证或脚本核对 |
| 前端 API 和页面 | 本地联调验证或当前工具链下的测试 |
| 菜单和权限 | 登录后菜单可见性和权限一致性验证 |
| 发布影响 | 构建、脚本路径、升级 SQL、回滚说明和观测入口检查 |

高风险任务完成前，优先使用 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 留存验证证据。

## 文档同步清单

- [ ] 是否需要更新 [docs/architecture/code-map.md](code-map.md)
- [ ] 是否需要更新 [docs/architecture/boundaries.md](boundaries.md)
- [ ] 是否需要更新 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- [ ] 是否需要更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [ ] 是否需要更新 [docs/reference/error-codes.md](../reference/error-codes.md)
- [ ] 是否需要更新 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [ ] 是否需要更新 [deploy/release/README.md](../../deploy/release/README.md)
- [ ] 是否需要补充评审记录、测试说明或验证证据
