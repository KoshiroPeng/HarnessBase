#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本根据发布输入生成标准化 Markdown 计划，
# 让 GitHub Actions 和人工发布都能引用同一份检查清单。

release_version="${RELEASE_VERSION:-}"
target_environment="${TARGET_ENVIRONMENT:-}"
dry_run="${DRY_RUN:-true}"
git_sha="${GIT_SHA:-}"
git_ref="${GIT_REF:-}"
run_id="${RUN_ID:-}"
output_file="${OUTPUT_FILE:-release-plan.md}"

if [[ -z "${release_version}" || -z "${target_environment}" ]]; then
  echo "缺少必要环境变量：RELEASE_VERSION 或 TARGET_ENVIRONMENT" >&2
  exit 1
fi

mkdir -p "$(dirname "${output_file}")"

cat > "${output_file}" <<EOF
# 发布计划

## 基本信息

- 服务：server
- 发布版本：${release_version}
- 目标环境：${target_environment}
- Dry Run：${dry_run}
- Git SHA：${git_sha}
- Git Ref：${git_ref}
- Workflow Run：${run_id}

## 发布前检查

1. 确认本次版本已通过 CI 全量校验。
2. 确认数据库迁移脚本与目标环境兼容。
3. 确认配置项和密钥已按目标环境准备完成。
4. 确认值班联系人、观察窗口和回滚负责人已到位。

## 发布步骤

1. 获取本次 Workflow 产出的 Jar 制品和校验文件。
2. 按目标环境注入配置与密钥。
3. 先执行数据库迁移检查，再执行应用部署。
4. 部署完成后运行发布验证脚本。

## 发布后验证

1. 检查 \`/actuator/health\` 是否返回健康状态。
2. 检查 \`/actuator/prometheus\` 是否可抓取。
3. 检查关键日志中是否存在启动失败、配置缺失或迁移异常。
4. 对关键业务路径执行最小业务探针。

## 回滚判定

1. 健康检查持续失败。
2. 错误率明显高于发布前基线。
3. 关键业务路径不可用。
4. 数据库迁移异常且无快速补救路径。

## 当前说明

- 当前仓库尚未接入真实部署执行器。
- 本计划用于统一发布记录、审批门禁和验证步骤。
- 后续接入真实平台时，应优先复用本计划中的步骤定义，而不是重新发明流程。
EOF
