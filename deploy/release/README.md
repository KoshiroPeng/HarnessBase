# 发布脚本说明

本目录用于承载 CallCenter 的发布编排辅助脚本，目标是把“发布计划生成”“发布后验证”“后续回滚检查”逐步从文档约定演进为可执行资产。

当前文件说明：

- `render-release-plan.sh`：根据环境、版本号和 dry-run 标记生成发布计划。
- `verify-release.sh`：对目标环境执行最小发布后验证，重点检查健康检查和指标端点。
- `deploy-via-ssh.sh`：通过 SSH 与 SCP 执行最小远端发布骨架。
- `rollback-via-ssh.sh`：通过 SSH 执行指定版本制品的远端回滚。
- `callcenter.service.template`：systemd 服务模板，供正式环境标准化托管时参考。
- `bootstrap-remote-host.sh`：首次初始化远端主机目录、环境文件与 systemd 服务。

推荐使用顺序：

1. 先执行 `.github/workflows/bootstrap-remote-host.yml` 完成远端主机初始化。
2. 再执行 `.github/workflows/server-release.yml` 完成日常发布与验证。
3. 若发布失败或验证异常，执行 `.github/workflows/server-rollback.yml` 完成回滚。

当前阶段这些脚本不会直接操作生产部署系统，而是优先完成以下目标：

1. 让发布包、版本号、验证步骤具备统一输出格式。
2. 让 GitHub Actions 可以显式串联“构建 -> 审批 -> 验证”。
3. 为后续接入真实部署脚本、容器平台或 GitOps 流程保留稳定入口。
