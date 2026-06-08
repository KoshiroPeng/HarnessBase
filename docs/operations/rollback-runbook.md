---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 回滚手册

## 目标

本文档定义 CallCenter 在版本发布失败、指标恶化或关键业务异常时的标准回滚流程，确保回滚动作有统一入口、统一检查项和统一验证步骤。

## 对应入口

- `.github/workflows/server-rollback.yml`
- `deploy/release/rollback-via-ssh.sh`
- `deploy/release/release-checklist.md`

## 回滚前检查

执行回滚前至少确认：

1. 目标回滚制品名称明确。
2. 数据库结构与旧版本兼容。
3. 回滚原因已记录。
4. 值班人与相关业务方已知晓。

## 推荐流程

1. 在 GitHub 中手工触发 `Server Rollback`。
2. 选择目标环境。
3. 输入目标回滚制品名称。
4. 输入回滚原因。
5. 先以 `dry_run=true` 预演。
6. 确认无误后，再执行 `dry_run=false`。
7. 回滚完成后执行健康检查和业务探针验证。

## 回滚后验证

至少检查：

- `actuator/health`
- `actuator/prometheus`
- 核心业务探针
- 日志中是否出现启动失败或配置异常

## 风险提示

- 若回滚到不兼容当前数据库结构的旧版本，可能导致服务启动失败。
- 若目标回滚制品文件不存在，回滚会在远端检查阶段失败。
- 若环境变量已变更但旧版本不兼容，也可能出现“版本回退但行为异常”的情况。

## 维护规则

- 回滚流程变化时，必须同步更新本文档和回滚 workflow。
- 新增更复杂的回滚策略时，必须补充更细的兼容性说明。
