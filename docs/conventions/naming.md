---
last_updated: 2026-06-07
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 命名规范

## 通用原则

- 名称使用业务语义，避免无意义缩写。
- 同一概念在代码、数据库、API 和文档中使用同一术语。
- 英文命名保持简洁，但不要牺牲可读性。
- 布尔变量使用 `is`、`has`、`can`、`should` 等前缀表达语义。

## Java 包名

包名使用小写英文，按职责分层组织：

```text
com.example.hernessdemo.domain
com.example.hernessdemo.config
com.example.hernessdemo.mapper
com.example.hernessdemo.service
com.example.hernessdemo.controller
```

实际根包名以后端 Maven 项目为准，但分层命名必须保持清晰。

## Java 类名

| 类型 | 命名示例 |
| --- | --- |
| Controller | `ProjectController` |
| Service 接口 | `ProjectService` |
| Service 实现 | `ProjectServiceImpl` |
| Mapper | `ProjectMapper` |
| 配置类 | `SecurityConfig` |
| 请求对象 | `CreateProjectRequest` |
| 响应对象 | `ProjectResponse` |
| 查询对象 | `ProjectQuery` |
| 异常类 | `ProjectNotFoundException` |

## 方法名

- 查询单个对象：`getProject`、`findProject`。
- 查询列表：`listProjects`、`searchProjects`。
- 创建：`createProject`。
- 更新：`updateProject`。
- 删除：`deleteProject`、`archiveProject`。
- 校验：`validateProjectAccess`。

不要使用 `doSomething`、`handleData`、`processInfo` 等含义模糊的方法名。

## 数据库命名

- 表名使用小写下划线，例如 `project_task`。
- 字段名使用小写下划线，例如 `created_at`。
- 主键字段默认使用 `id`。
- 创建时间使用 `created_at`。
- 更新时间使用 `updated_at`。
- 逻辑删除字段使用 `deleted_at` 或 `deleted`，具体方案在落地时统一。

MySQL 语法必须兼容 5.7。

## API 命名

- URL 使用小写连字符或小写路径段。
- 资源名使用复数，例如 `/projects`、`/tasks`。
- 请求和响应字段使用 `camelCase`。
- 分页参数推荐使用 `page`、`pageSize`。

示例：

```text
GET /api/v1/projects
POST /api/v1/projects
GET /api/v1/projects/{projectId}
```

## 测试命名

测试类以 `Test` 结尾，例如 `ProjectServiceTest`。

测试方法命名应说明场景和期望：

```text
createProject_shouldReturnProject_whenInputValid
createProject_shouldThrowException_whenNameDuplicated
```
