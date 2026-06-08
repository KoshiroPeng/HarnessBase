# 发布脚本说明

本目录用于承载 HernessDemo 的发布编排辅助脚本，目标是把“发布计划生成”“发布后验证”“回滚检查”逐步从文档约定演进为可执行资产。

这些材料在当前仓库中的定位是“产品交付支撑层”，不是当前项目主线本身。它们存在的目的，是帮助 Web MVP 更稳地发布，而不是把仓库重新带回平台化建设主线。

当前文件说明：

- `render-release-plan.sh`：根据环境、版本号和 `dry-run` 标记生成发布计划。
- `verify-release.sh`：对目标环境执行最小发布后验证，重点检查健康检查和指标端点。
- `deploy-via-ssh.sh`：通过 SSH 与 SCP 执行最小远端发布骨架。
- `rollback-via-ssh.sh`：通过 SSH 执行指定版本制品的远端回滚。
- `herness-demo.service.template`：systemd 服务模板，供正式环境标准化托管时参考。
- `bootstrap-remote-host.sh`：首次初始化远端主机目录、环境文件与 systemd 服务。

配套文档入口：

- [deploy/release/release-checklist.md](release-checklist.md)：发布、验证与回滚前后的最小检查清单。
- [deploy/release/environment-variable-template.md](environment-variable-template.md)：环境变量和密钥准备模板。
- [.github/workflows/bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml)：主机初始化工作流。
- [.github/workflows/server-release.yml](../../.github/workflows/server-release.yml)：发布工作流。
- [.github/workflows/server-rollback.yml](../../.github/workflows/server-rollback.yml)：回滚工作流。

推荐使用顺序：

1. 先执行 [.github/workflows/bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml) 完成远端主机初始化。
2. 再执行 [.github/workflows/server-release.yml](../../.github/workflows/server-release.yml) 完成日常发布与验证。
3. 若发布失败或验证异常，执行 [.github/workflows/server-rollback.yml](../../.github/workflows/server-rollback.yml) 完成回滚。

当前阶段这些脚本不会直接操作复杂生产部署系统，而是优先完成以下目标：

1. 让发布包、版本号、验证步骤具备统一输出格式。
2. 让 GitHub Actions 可以显式串联“构建 -> 审批 -> 验证”。
3. 为后续接入真实部署脚本、容器平台或 GitOps 流程保留稳定入口。

## 纠偏提醒

- 如果某项发布材料不能直接帮助当前 Web MVP 交付，应先进入 backlog，而不是立即扩张为新体系。
- 如果讨论中引用 Harness Engineering，应优先理解为“增强交付验证与可追踪性”，而不是恢复一整套交付平台专题文档。
- 如果你是从开发任务跳转到这里，建议同时对照 [deploy/release/release-checklist.md](release-checklist.md) 与 [docs/README.md](../../docs/README.md) 使用。
