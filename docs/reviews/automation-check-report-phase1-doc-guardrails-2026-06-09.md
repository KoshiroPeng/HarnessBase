---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第一阶段文档护栏检查结果，记录 A01/A02/A03 脚本接入前后的扫描范围、命中情况与当前结论。
---

# 自动化检查结果

## 基本信息

- 检查名称：第一阶段文档结构类硬校验
- 检查编号：A01 / A02 / A03
- 执行时间：2026-06-09
- 执行环境：本地
- 执行人或执行来源：Codex
- 关联脚本 / workflow：[.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)、[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

## 检查范围

- 扫描目录：`AGENTS.md`、根目录 `README.md`、`docs/**/*.md`、`deploy/**/*.md`、`.github/README.md`、`server/README.md`、`web/README.md`
- 扫描文件类型：Markdown
- 忽略规则：
  - 根目录 [README.md](../../README.md)
  - [server/.gitee/PULL_REQUEST_TEMPLATE.zh-CN.md](../../server/.gitee/PULL_REQUEST_TEMPLATE.zh-CN.md)
  - [server/script/docker/redis/data/README.md](../../server/script/docker/redis/data/README.md)
  - `server/ruoyi-modules/**/mapper/package-info.md`
- 关联规则来源：
  - [docs/conventions/document-metadata.md](../../docs/conventions/document-metadata.md)
  - [docs/conventions/document-links.md](../../docs/conventions/document-links.md)
  - [docs/conventions/automation-check-catalog.md](../../docs/conventions/automation-check-catalog.md)

## 执行结果

| 序号 | 命中项 | 级别 | 结果 | 说明 |
| --- | --- | --- | --- | --- |
| 1 | A01：治理型 Markdown 元数据标头检查 | 阻断 | 通过 | 治理型 Markdown 均具备 `last_updated`、`status`、`owner`、`description` |
| 2 | A02：Markdown 相对链接与锚点检查 | 阻断 | 通过 | 仓库内相对链接与 Markdown 锚点均可解析 |
| 3 | A03：已删除文档引用检查 | 阻断 | 通过 | 已并入 A02 的目标存在性检查，未发现失效引用 |

## 输出摘要

- 总扫描数：仓库内 Markdown 全量扫描，按治理规则过滤校验
- 通过数：3
- 失败数：0
- 提醒数：0
- 是否阻断流水线：是

## 典型命中样例

```text
[A01/A02/A03][通过] 文档护栏检查通过
说明: 治理型 Markdown 标头、相对链接和锚点检查均未发现问题
```

## 结论

- 本次检查已经具备接入主线 CI 的条件。
- 当前误报情况：未发现。
- 当前漏报风险：暂不覆盖历史事实误用、workflow 路径存在性和 API / SQL / 错误码同步提醒，这些属于后续阶段。

## 后续动作

- 将 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 接入 [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 的前置门禁。
- 下一步按 [docs/plans/phase2-history-scan-brief.md](../../docs/plans/phase2-history-scan-brief.md) 推进历史事实误用扫描。
