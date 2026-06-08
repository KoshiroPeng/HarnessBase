---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 远端主机初始化手册

## 目标

本文档定义 CallCenter 在首次接入新服务器时的标准初始化步骤，确保部署目录、环境文件、日志目录和 systemd 服务以统一方式落地。

## 适用场景

- 新增 `staging` 服务器。
- 新增 `prod` 服务器。
- 远端主机重建后重新接入发布链路。

## 对应脚本

- `deploy/release/bootstrap-remote-host.sh`
- `deploy/release/callcenter.service.template`
- `.github/workflows/bootstrap-remote-host.yml`

## 初始化内容

脚本会处理以下动作：

1. 创建部署目录。
2. 创建 `releases`、`shared`、`shared/logs` 子目录。
3. 生成并上传环境文件 `shared/app.env`。
4. 生成并安装 `systemd` 服务文件。
5. 执行 `systemctl daemon-reload` 与 `systemctl enable`。

## 依赖条件

远端主机需满足：

- 已安装 `java`。
- 已安装 `systemd`。
- 部署账号具备 `sudo` 执行 `mv`、`systemctl` 的权限。
- SSH 密钥已配置。

## 推荐执行顺序

1. 先在 GitHub Environment 中配置变量和 secrets。
2. 在本地或 CI 中以 `DRY_RUN=true` 运行 `bootstrap-remote-host.sh`。
3. 确认目录、服务名、profile 和环境文件内容无误。
4. 再使用 `DRY_RUN=false` 执行真实初始化。
5. 初始化完成后，再执行发布工作流。

若使用 GitHub Actions 作为统一入口，建议优先手工触发：

- `Remote Host Bootstrap`

## 与发布流程的关系

主机初始化不是每次发布都要执行，而是在以下场景执行：

- 首次接入新环境。
- 远端服务名调整。
- 部署目录变更。
- 从 `nohup` 切换到 `systemd`。

## 风险提示

- 若 `systemd` 服务名与现网不一致，可能导致发布后重启失败。
- 若部署账号无 `sudo` 权限，初始化会在安装服务阶段失败。
- 若环境文件内容不完整，服务虽可启动但可能无法连接数据库。

## 维护规则

- systemd 模板变化时，必须同步更新本文档。
- 新增远端依赖条件时，必须同步更新本手册。
