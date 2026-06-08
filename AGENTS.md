---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 仓库级 AI 协作规则入口，只保留必须遵守的代理行为、Git 规则和文档导航边界。
---

# AGENTS.md

本文件是 HarnessBase 仓库唯一的 AI 协作规则入口。它只记录 agent 必须立即遵守的行为规则；项目事实、技术基线、模块边界和任务清单由下方链接承接。

## 必须遵守

- 默认使用简体中文回复；GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释也必须使用简体中文。
- 代码标识符、API 名称、命令、错误信息和原文引用可以保留英文。
- 涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。
- 本仓库只使用 `AGENTS.md` 作为 agent 规则入口，不要新增第二个 agent 规则文件。
- 修改带有元数据标头的 Markdown 文档时，必须同步更新 `last_updated` 日期；新增内部 Markdown 文档必须包含 `last_updated`、`status`、`owner`、`description`。
- 任何影响开发、测试、评审、发布或文档治理主路径的变更，必须同步更新 [docs/README.md](docs/README.md) 或对应目录 `README.md`。

## 开始任务

1. 先读 [docs/README.md](docs/README.md)。
2. 再读 [docs/architecture/code-map.md](docs/architecture/code-map.md)，用真实代码事实校准任务判断。
3. 根据任务类型阅读 [docs/conventions/task-startup-checklist.md](docs/conventions/task-startup-checklist.md) 中对应清单。
4. 新增业务功能或业务域时，必须阅读 [docs/architecture/business-extension-baseline.md](docs/architecture/business-extension-baseline.md)。

## 文档阅读边界

- 文档用于导航，不替代真实代码、配置、SQL、Controller、前端调用和 workflow 核对。
- 只按当前任务场景展开必要链接；明确代码落位、影响范围和验证方式后，停止递归追踪导航链接。
- 禁止为了“读完所有文档”而循环阅读目录索引、导航页或互相引用的规则文档。

## 代码与文档护栏

- 技术基线以 [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md) 为准。
- 模块边界以 [docs/architecture/boundaries.md](docs/architecture/boundaries.md) 为准。
- 编码、测试、日志、命名、文档链接和文档元数据规范以 [docs/conventions/README.md](docs/conventions/README.md) 为入口。
- API 摘要以 [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml) 为入口；响应码和错误消息以 [docs/reference/error-codes.md](docs/reference/error-codes.md) 为入口。
- SQL 变更必须同步维护 [server/script/sql](server/script/sql) 下的初始化或升级脚本，并参考 [docs/reference/sql-change-checklist.md](docs/reference/sql-change-checklist.md)。
- 发布和观测材料分别以 [deploy/release/README.md](deploy/release/README.md) 与 [deploy/observability/README.md](deploy/observability/README.md) 为入口。

## 验证要求

- 涉及功能、缺陷、评审、测试、发布或重要文档治理时，优先使用 [docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md) 记录验证方式、结果和未覆盖风险。
- 如果任务跨多个文档、模块或阶段，优先使用 [docs/plans/task-status-template.md](docs/plans/task-status-template.md) 记录目标、进展、风险和待补文档。

## Git 与提交

需要提交代码时，必须执行完整 GitHub 流程：

1. 先执行 `git status`，确认当前分支和工作区状态。
2. 再执行 `git add` 暂存本次相关改动。
3. 然后执行 `git commit`，提交信息必须使用简体中文，并遵守提交类型规范。
4. 最后推送当前分支到 `origin`。
5. 如果当前分支没有 upstream，使用 `git push -u origin 当前分支名`。

禁止使用 `git push --force`、`git reset --hard`、`git clean` 等可能破坏历史或删除改动的命令，除非用户明确要求。远程仓库未配置、无权限、存在冲突或当前分支不明确时，必须暂停并说明具体问题。

提交类型：`feat`、`fix`、`refactor`、`docs`、`test`。
