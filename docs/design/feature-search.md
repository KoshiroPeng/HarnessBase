---
last_updated: 2026-06-08
status: deprecated     # active | deprecated | draft
owner: "@PengKang"
---

# 功能设计：搜索

> 历史设计草稿，仅保留参考。CallCenter 当前第一阶段不以项目/任务搜索作为主线能力。

## 背景

用户需要在项目、任务、成员和文档中快速定位信息。第一版搜索应优先保证简单、稳定和兼容 MySQL 5.7。

## 目标

- 支持按关键词搜索项目和任务。
- 支持按状态、负责人、时间范围过滤。
- 支持分页和排序。
- 搜索结果遵守当前用户权限。

## 非目标

- 暂不引入 Elasticsearch 或其他独立搜索引擎。
- 暂不支持复杂查询语言。
- 暂不承诺全文检索级相关性排序。

## 查询入口

建议提供统一搜索 API：

```text
GET /api/v1/search
```

常见参数：

- `keyword`
- `type`
- `projectId`
- `ownerId`
- `status`
- `page`
- `pageSize`

详细接口定义见 `docs/reference/api-spec.yaml`。

## 数据流

```text
Controller
  -> SearchService
  -> Permission Check
  -> Mapper
  -> MySQL 5.7
```

## 实现约束

- SQL 必须兼容 MySQL 5.7。
- 禁止在 Controller 拼接 SQL 或查询条件。
- 查询条件由 Service 规范化后传入 Mapper。
- 搜索结果必须按权限过滤。
- 分页默认限制最大 `pageSize`，避免大查询拖垮数据库。

## 测试要求

- 关键词为空时按默认条件返回。
- 无权限资源不出现在搜索结果中。
- 分页参数越界时返回参数错误。
- 组合过滤条件能正确传入 Mapper。

## 后续演进

当 MySQL 查询无法满足性能或相关性要求时，再评估独立搜索服务。引入新搜索基础设施前必须更新架构文档和部署文档。
