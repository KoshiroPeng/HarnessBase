#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于执行最小发布后验证。
# 若未提供目标地址或当前为 dry-run，则只输出验证计划并正常结束；
# 若提供了目标地址，则实际检查健康检查和指标端点，便于在 CI/CD 中作为门禁。

target_base_url="${TARGET_BASE_URL:-}"
release_version="${RELEASE_VERSION:-unknown}"
target_environment="${TARGET_ENVIRONMENT:-unknown}"
dry_run="${DRY_RUN:-true}"

echo "开始执行发布后验证"
echo "发布版本：${release_version}"
echo "目标环境：${target_environment}"
echo "Dry Run：${dry_run}"

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，仅输出验证计划，不访问真实环境。"
  exit 0
fi

if [[ -z "${target_base_url}" ]]; then
  echo "未提供 TARGET_BASE_URL，无法执行真实环境验证。" >&2
  exit 1
fi

health_url="${target_base_url%/}/actuator/health"
metrics_url="${target_base_url%/}/actuator/prometheus"

echo "检查健康检查端点：${health_url}"
health_response="$(curl --fail --silent --show-error "${health_url}")"
echo "${health_response}"
echo "${health_response}" | grep '"status"' | grep 'UP' >/dev/null

echo "检查指标端点：${metrics_url}"
metrics_output="$(curl --fail --silent --show-error "${metrics_url}")"
echo "${metrics_output}" | grep '^#' >/dev/null

echo "发布后验证通过：健康检查和指标端点均可用。"
