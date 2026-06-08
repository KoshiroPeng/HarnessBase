---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 运维文档

本目录沉淀发布验证、回滚、主机初始化、配置密钥和运行手册。这里回答“上线后怎么验证、异常时怎么恢复、环境怎么配置”，不重复交付模型和编码规范。

## 核心入口

| 任务 | 文档 |
| --- | --- |
| 发布验证 | [release-verification.md](release-verification.md) |
| 回滚 | [rollback-runbook.md](rollback-runbook.md) |
| 远端主机初始化 | [remote-host-bootstrap.md](remote-host-bootstrap.md) |
| GitHub Environment 配置 | [github-environment-setup.md](github-environment-setup.md) |
| 配置与密钥 | [config-and-secrets.md](config-and-secrets.md) |
| 运行手册 | [runbooks.md](runbooks.md) |
| 服务目标与门禁 | [slo-and-gates.md](slo-and-gates.md) |

## 维护规则

- 新增高风险操作时，先补运行手册，再接入发布或回滚流程。
- 涉及环境、制品或流水线对象变化时，同步更新 [docs/delivery/](../delivery/)。
