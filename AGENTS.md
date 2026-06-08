# AI 协作规则

本文件是当前仓库唯一 AI 协作规则入口。所有 agent 在读取或修改本仓库前，必须先阅读并遵守本文档。

默认使用简体中文回复。GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释也必须使用简体中文。

涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。

## 项目定位

当前项目以 CallCenter 为主项目，是面向客户本地机房私有化部署的企业级呼叫中心 Web 平台。

当前仓库已经将 CallCenter 后端和前端作为正式工程入口：

- `services/callcenter-server/`：完整 Java 后端工程，基于 RuoYi-Vue-Plus 裁剪版。
- `services/callcenter-web/`：完整 Vue 前端工程，基于 plus-ui 裁剪版。

根目录 `server/` 仅作为历史工程骨架保留，不再作为当前项目的主后台入口。后续呼叫中心业务能力应进入 `services/callcenter-server/` 或 `services/callcenter-web/`，不要继续扩写根目录 `server/`。

## 目录边界

- `docs/specs/`：项目规格与架构文档，是需求和设计事实来源。
- `services/callcenter-server/`：Java 后端工程，基于 RuoYi-Vue-Plus 裁剪版。
- `services/callcenter-web/`：Vue 前端工程，基于 plus-ui 裁剪版。
- `deploy/`：部署、可观测性、发布脚本和运维入口。
- `server/`：历史后端骨架，只做兼容保留，不承载新的 CallCenter 业务。

## 开发约定

- 涉及业务能力变更时，先更新 `docs/specs/` 或对应领域设计文档，再修改 `services/callcenter-server/` 或 `services/callcenter-web/`。
- 不把呼叫中心核心业务写成普通 CRUD；电话、坐席、CTI、实时通道、聊天、录音、质检、AI、报表都必须先明确领域模型。
- 外部系统和华为 CTI 对接必须通过 adapter 或 integration 边界隔离。
- 后端新增呼叫中心能力时，不要把 CTI、通话状态、坐席状态、聊天会话等核心状态直接塞进系统管理模块。
- 前端新增坐席工作台、话务条、来电弹屏和聊天界面时，应形成独立视图区，不和系统管理页面混写。
- 实时交互相关代码必须明确连接状态、重连策略、错误提示和降级路径。
- 不要为局部需求引入新的全局框架、全局抽象或无关依赖；优先遵循 CallCenter 既有工程结构。

## 常用命令

```bash
(cd services/callcenter-server && mvn -DskipTests package)
(cd services/callcenter-server && mvn test)
(cd services/callcenter-web && pnpm install && pnpm build:prod)
(cd services/callcenter-web && pnpm dev)
./deploy/ops start
./deploy/ops start --app
./deploy/ops health
```

## Git 与提交

需要提交代码时，必须执行完整 GitHub 流程：

1. 先执行 `git status`，确认当前分支和工作区状态。
2. 再执行 `git add` 暂存本次相关改动。
3. 然后执行 `git commit`，提交信息必须使用简体中文。
4. 最后推送当前分支到 `origin`。
5. 如果当前分支没有 upstream，使用 `git push -u origin 当前分支名`。

禁止使用 `git push --force`、`git reset --hard`、`git clean` 等可能破坏历史或删除改动的命令，除非用户明确要求。远程仓库未配置、无权限、存在冲突或当前分支不明确时，必须暂停并说明具体问题，不要猜测处理。
