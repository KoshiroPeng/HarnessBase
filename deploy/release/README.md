---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 发布支撑目录入口，汇总发布、回滚、初始化与验证相关材料。
---

# 发布脚本说明

本目录用于承载 ProjectPilot 的发布编排辅助脚本，目标是把“发布计划生成”“发布后验证”“回滚检查”逐步从文档约定演进为可执行资产。

这些材料在当前仓库中的定位是“产品交付支撑层”，不是当前项目主线本身。它们存在的目的，是帮助 Web MVP 和后续基线迁移更稳地发布，而不是把仓库重新带回平台化建设主线。

当前文件说明：

- `render-release-plan.sh`：根据环境、版本号和 `dry-run` 标记生成发布计划。
- `verify-release.sh`：对目标环境执行最小发布后验证，重点检查健康检查和指标端点。
- `deploy-via-ssh.sh`：通过 SSH 与 SCP 执行最小远端发布骨架。
- `rollback-via-ssh.sh`：通过 SSH 执行指定版本制品的远端回滚。
- `herness-demo.service.template`：历史命名下的 systemd 服务模板，供正式环境标准化托管时参考。
- `bootstrap-remote-host.sh`：首次初始化远端主机目录、环境文件与 systemd 服务。

配套文档入口：

- [deploy/release/release-checklist.md](release-checklist.md)：发布、验证与回滚前后的最小检查清单。
- [deploy/release/environment-variable-template.md](environment-variable-template.md)：环境变量和密钥准备模板。
- [.github/workflows/bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml)：主机初始化工作流。
- [.github/workflows/server-release.yml](../../.github/workflows/server-release.yml)：发布工作流。
- [.github/workflows/server-rollback.yml](../../.github/workflows/server-rollback.yml)：回滚工作流。

## 与新基线的关系

当前脚本与工作流仍可能带有历史命名或旧运行时假设。后续在代码迁移到 JDK 17 / Spring Boot 3.x 后，本目录应继续收敛到以下方向：

1. 发布说明围绕新的后端与前端主线组织。
2. 若 `web/` 真正落地联合交付，再补充 Compose、Nginx 或统一运维入口。
3. 保持支撑层定位，不把发布目录扩张成新的平台体系。

## 纠偏提醒

- 如果某项发布材料不能直接帮助当前 Web MVP 交付或基线迁移，应先进入 backlog，而不是立即扩张为新体系。
- 如果讨论中引用 Harness Engineering，应优先理解为“增强交付验证与可追踪性”，而不是恢复一整套交付平台专题文档。
- 如果你是从开发任务跳转到这里，建议同时对照 [deploy/release/release-checklist.md](release-checklist.md) 与 [docs/README.md](../../docs/README.md) 使用。
