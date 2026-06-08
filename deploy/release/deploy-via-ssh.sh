#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本提供最小可执行的 SSH 发布骨架。
# 在 dry-run 模式下仅输出即将执行的动作；
# 在真实模式下通过 SCP 上传 Jar，再通过 SSH 在远端重启服务。
# 当前支持两种远端启动策略：
# 1. systemd：推荐用于正式环境。
# 2. nohup：用于尚未接入 systemd 的最小环境。

artifact_path="${ARTIFACT_PATH:-}"
target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/callcenter}"
app_profile="${APP_PROFILE:-}"
java_opts="${JAVA_OPTS:--Xms256m -Xmx512m}"
deploy_strategy="${APP_DEPLOY_STRATEGY:-nohup}"
service_name="${APP_SERVICE_NAME:-callcenter}"
dry_run="${DRY_RUN:-true}"
release_version="${RELEASE_VERSION:-unknown}"

if [[ -z "${artifact_path}" ]]; then
  echo "缺少 ARTIFACT_PATH，无法执行部署。" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出部署计划："
  echo "- 制品路径：${artifact_path}"
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- Profile：${app_profile}"
  echo "- 部署策略：${deploy_strategy}"
  echo "- 服务名：${service_name}"
  echo "- 发布版本：${release_version}"
  exit 0
fi

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" || -z "${app_profile}" ]]; then
  echo "缺少部署所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY / APP_PROFILE。" >&2
  exit 1
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

artifact_name="$(basename "${artifact_path}")"

echo "创建远端目录：${target_dir}"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" \
  "mkdir -p '${target_dir}/releases' '${target_dir}/shared/logs'"

echo "上传制品：${artifact_name}"
scp -i "${key_file}" -P "${target_port}" -o StrictHostKeyChecking=no "${artifact_path}" \
  "${target_user}@${target_host}:${target_dir}/releases/${artifact_name}"

echo "远端切换版本并重启服务"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"
ln -sfn "releases/${artifact_name}" current.jar
if [[ "${deploy_strategy}" == "systemd" ]]; then
  sudo systemctl daemon-reload || true
  sudo systemctl restart "${service_name}"
  sudo systemctl status "${service_name}" --no-pager
else
  pkill -f 'callcenter-admin' || true
  nohup java ${java_opts} \
    -Dspring.profiles.active="${app_profile}" \
    -jar "${target_dir}/current.jar" \
    > "${target_dir}/shared/logs/server.out" 2>&1 &
fi
echo "部署完成：${release_version}"
EOF
