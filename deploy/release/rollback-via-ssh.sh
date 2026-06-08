#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于将远端服务回滚到指定版本制品。
# 当前支持 systemd 和 nohup 两种托管策略，行为与 deploy-via-ssh.sh 保持一致。

rollback_artifact="${ROLLBACK_ARTIFACT:-}"
target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/harness-base}"
app_profile="${APP_PROFILE:-}"
java_opts="${JAVA_OPTS:--Xms256m -Xmx512m}"
deploy_strategy="${APP_DEPLOY_STRATEGY:-nohup}"
service_name="${APP_SERVICE_NAME:-harness-base}"
dry_run="${DRY_RUN:-true}"
rollback_reason="${ROLLBACK_REASON:-未提供原因}"

if [[ -z "${rollback_artifact}" ]]; then
  echo "缺少 ROLLBACK_ARTIFACT，无法执行回滚。" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出回滚计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- 回滚制品：${rollback_artifact}"
  echo "- Profile：${app_profile}"
  echo "- 部署策略：${deploy_strategy}"
  echo "- 服务名：${service_name}"
  echo "- 回滚原因：${rollback_reason}"
  exit 0
fi

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" || -z "${app_profile}" ]]; then
  echo "缺少回滚所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY / APP_PROFILE。" >&2
  exit 1
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

echo "检查目标回滚制品是否存在"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" \
  "test -f '${target_dir}/releases/${rollback_artifact}'"

echo "远端切换回滚版本并重启服务"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"
ln -sfn "releases/${rollback_artifact}" current.jar
if [[ "${deploy_strategy}" == "systemd" ]]; then
  sudo systemctl daemon-reload || true
  sudo systemctl restart "${service_name}"
  sudo systemctl status "${service_name}" --no-pager
else
  pkill -f 'harness-base-server' || true
  nohup java ${java_opts} \
    -Dspring.profiles.active="${app_profile}" \
    -jar "${target_dir}/current.jar" \
    > "${target_dir}/shared/logs/server.out" 2>&1 &
fi
echo "回滚完成：${rollback_artifact}"
EOF
