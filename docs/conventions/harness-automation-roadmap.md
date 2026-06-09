---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase Harness 自动化落地方案，定义文档校验、历史事实误用扫描、workflow 路径检查与 SQL 同步检查。
---

# Harness 自动化落地方案

## 目标

本文档定义 HarnessBase 下一阶段如何把高频协作规则转成自动化检查，减少文档和代码再次错位。

## 当前判断

当前仓库已经具备：

- 统一规则入口：[AGENTS.md](../../AGENTS.md)
- 统一文档导航：[docs/README.md](../README.md)
- 当前代码地图：[docs/architecture/code-map.md](../architecture/code-map.md)

当前仓库仍缺少：

- 自动检查 Markdown 元数据和链接
- 自动发现旧单体、旧包名或旧路径误用
- 自动发现 workflow 指向不存在的源码路径
- 自动提醒 SQL、API、响应码、发布材料的同步关系

## 推荐推进顺序

1. 先做 Markdown 元数据和链接检查。
2. 再做历史事实误用扫描。
3. 再做 workflow 路径存在性检查。
4. 最后做 API、响应码、SQL、发布材料的同步提醒。
