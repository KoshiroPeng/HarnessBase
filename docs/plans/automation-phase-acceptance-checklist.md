---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化阶段验收清单，用于统一判断各阶段检查是否达到可接入、可试运行或可阻断状态。
---

# 自动化阶段验收清单

## 目标

本文档用于统一判断 HarnessBase 自动化各阶段是否已经达到：

- 可以开始试运行
- 可以接入 CI
- 可以升级为阻断

## 使用方式

- 每完成一个自动化阶段，至少对照本文做一次阶段验收。
- 阶段验收结果建议同步记录到 [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md)。
- 若阶段验收不通过，不要直接宣布“自动化已接入完成”。

## 通用验收项

所有阶段在单独验收前，先确认：

- [ ] 规则来源文档已明确
- [ ] 检查定义已写入 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- [ ] 报错文案遵守 [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- [ ] 结果记录方式已明确
- [ ] 试运行结果已至少保留一份

## 第一阶段验收：文档结构类硬校验

对应文档：

- [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)

验收项：

- [ ] A01、A02、A03 范围已明确
- [ ] 根目录 `README.md` 豁免规则已生效
- [ ] `.gitee/` 模板与 `package-info.md` 未被误判
- [ ] 链接与锚点缺失能被稳定发现
- [ ] 输出能直接定位到文件、字段、路径或锚点
- [ ] 已完成至少一轮本地验证
- [ ] 已完成至少一轮 CI 试运行

## 第二阶段验收：历史事实误用扫描

对应文档：

- [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)

验收项：

- [ ] 命中词范围已明确
- [ ] 历史背景与禁止误用语境能基本区分
- [ ] 提醒输出能看见命中词和文件路径
- [ ] 已完成至少一轮本地试跑
- [ ] 已完成至少一轮非阻断 CI 提醒试运行
- [ ] 当前误报已被记录和解释

## 第三阶段验收：workflow 路径护栏

对应文档：

- [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)

验收项：

- [ ] `working-directory` 校验有效
- [ ] `cache-dependency-path` 校验有效
- [ ] 制品、脚本、模板路径校验有效
- [ ] 输出能定位到 workflow 文件和字段
- [ ] 当前所有 workflow 已完成通过验证
- [ ] 具备升级为阻断的条件

## 第四阶段验收：文档同步提醒

对应文档：

- [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)

验收项：

- [ ] API 相关变更会提醒 reference 文档
- [ ] 响应码与异常相关变更会提醒错误码文档
- [ ] SQL 相关变更会提醒数据与发布材料
- [ ] 提醒文案中带有具体文档路径
- [ ] 至少完成一轮提醒模式试运行
- [ ] 当前提醒不会造成大面积噪声

## 阶段结论

完成每阶段验收后，至少给出以下结论之一：

- 可继续试运行
- 可接入 CI
- 可升级为阻断
- 暂不适合接入，需继续收敛

## 一句话结论

自动化阶段是否“完成”，不以文档写完为准，而以本清单中的验收项是否通过为准。
