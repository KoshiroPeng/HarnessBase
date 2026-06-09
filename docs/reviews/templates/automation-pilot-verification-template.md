---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化试运行验证模板，用于记录自动化检查在本地或 CI 中的试运行结果、误报情况与阶段验收结论。
---

# 自动化试运行验证模板

## 目标

本模板用于记录 HarnessBase 自动化检查在试运行阶段的验证结果，帮助团队判断：

- 是否已经具备接入条件
- 当前误报与漏报是否可接受
- 是否适合升级为正式阻断

## 推荐联读

- [docs/plans/automation-phase-acceptance-checklist.md](../../plans/automation-phase-acceptance-checklist.md)
- [docs/conventions/automation-check-catalog.md](../../conventions/automation-check-catalog.md)
- [docs/conventions/automation-message-guidelines.md](../../conventions/automation-message-guidelines.md)
- [docs/reviews/templates/automation-check-report-template.md](automation-check-report-template.md)

```md
# 自动化试运行验证

## 基本信息

- 阶段：
- 检查编号：
- 试运行时间：
- 执行环境：本地 / CI
- 执行人：
- 关联脚本 / workflow：

## 试运行目标

- 本次要验证什么：
- 本次不验证什么：

## 试运行结果

| 序号 | 验证项 | 结果 | 说明 |
| --- | --- | --- | --- |
| 1 |  | 通过 / 未通过 / 未执行 |  |

## 命中情况

- 命中总数：
- 明显真阳性：
- 可能误报：
- 可能漏报：

## 代表性样例

```text
在此记录具有代表性的输出片段、误报样例、漏报样例或修正前后的对比
```

## 阶段验收结论

- 是否通过阶段验收：
- 当前建议状态：继续试运行 / 可接入 CI / 可升级为阻断 / 暂缓接入
- 对应验收清单：

## 后续动作

- 
```

## 使用提醒

- 如果某项检查仍未稳定，不要跳过“可能误报”和“可能漏报”。
- 如果决定升级为阻断，必须在结论中明确写出原因。
- 如果结论只是“继续试运行”，也要写清下一轮准备优化什么。
