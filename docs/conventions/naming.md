---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 命名规范，统一模块、类、方法、字段、接口与文档命名方式。
---

# 命名规范

## 通用原则

- 名称使用业务语义，避免无意义缩写。
- 同一概念在代码、数据库、API 和文档中使用同一本术语。
- 英文命名保持简洁，但不要牺牲可读性。
- 布尔变量使用 `is`、`has`、`can`、`should` 等前缀表达语义。

## Java 包名

包名使用小写英文，按模块化单体职责组织：

```text
com.example.projectpilot.shared
com.example.projectpilot.project.domain
com.example.projectpilot.project.application
com.example.projectpilot.project.adapter.in.web
com.example.projectpilot.project.adapter.out.persistence
```

实际根包名以后端 Maven 项目为准，但模块边界和层级命名必须保持清晰。

## Java 类名

| 类型 | 命名示例 |
| --- | --- |
| Controller | `ProjectController` |
| Service 接口 | `ProjectService` |
| Application Service | `ProjectApplicationService` |
| Persistence Adapter / Mapper | `ProjectMapper`、`ProjectPersistenceAdapter` |
| 配置类 | `SecurityConfig` |
| 请求对象 | `CreateProjectRequest` |
| 响应对象 | `ProjectResponse` |
| 查询对象 | `ProjectQuery` |
| 异常类 | `ProjectNotFoundException` |

## 方法名

- 查询单个对象：`getProject`、`findProject`
- 查询列表：`listProjects`、`searchProjects`
- 创建：`createProject`
- 更新：`updateProject`
- 删除：`deleteProject`、`archiveProject`
- 校验：`validateProjectAccess`

不要使用 `doSomething`、`handleData`、`processInfo` 这类含义模糊的方法名。

## 数据库命名

- 表名使用小写下划线，例如 `project_task`。
- 字段名使用小写下划线，例如 `created_at`。
- 主键字段默认使用 `id`。
- 创建时间使用 `created_at`。
- 更新时间使用 `updated_at`。
- 逻辑删除字段使用 `deleted_at` 或 `deleted`，具体方案在落地时统一。

表结构与命名应服务 MySQL 8.x 主线，并与 Flyway migration 保持一致。

## API 命名

- URL 使用小写路径段。
- 资源名使用复数，例如 `/projects`、`/tasks`。
- 请求和响应字段使用 `camelCase`。
- 分页参数推荐使用 `page`、`pageSize`。

示例：

```text
GET /api/v1/projects
POST /api/v1/projects
GET /api/v1/projects/{projectId}
```

## 前端与共享包命名

- 前端应用目录使用业务语义，例如 `projectpilot-web`。
- 共享包使用职责语义，例如 `shared-ui`、`shared-api`、`config`。
- Vue 组件名使用 PascalCase，例如 `ProjectListPage.vue`、`TaskStatusBadge.vue`。
- 组合式函数使用 `use` 前缀，例如 `useProjectFilters`。
- Pinia store 建议使用 `useXxxStore` 命名，例如 `useProjectStore`。

## 测试命名

测试类以 `Test` 结尾，例如 `ProjectServiceTest`。

测试方法命名应说明场景和期望：

```text
createProject_shouldReturnProject_whenInputValid
createProject_shouldThrowException_whenNameDuplicated
```
