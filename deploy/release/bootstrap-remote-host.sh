#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于初始化远端主机的目录、环境文件与 systemd 服务。
# 在 dry-run 模式下仅输出计划；在真实模式下会上传并写入实际文件。

target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/herness-demo}"
app_profile="${APP_PROFILE:-}"
java_opts="${JAVA_OPTS:--Xms256m -Xmx512m}"
service_name="${APP_SERVICE_NAME:-herness-demo}"
deploy_strategy="${APP_DEPLOY_STRATEGY:-systemd}"
dry_run="${DRY_RUN:-true}"

db_url="${DB_URL:-}"
db_username="${DB_USERNAME:-}"
db_password="${DB_PASSWORD:-}"

if [[ "${deploy_strategy}" != "systemd" ]]; then
  echo "当前部署策略为 ${deploy_strategy}，无需执行 systemd 主机初始化。"
  exit 0
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出主机初始化计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- 服务名：${service_name}"
  echo "- Profile：${app_profile}"
  echo "- 将创建目录：${target_dir}/releases、${target_dir}/shared、${target_dir}/shared/logs"
  echo "- 将写入环境文件：${target_dir}/shared/app.env"
  echo "- 将安装 systemd unit：/etc/systemd/system/${service_name}.service"
  exit 0
fi

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" || -z "${app_profile}" ]]; then
  echo "缺少主机初始化所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY / APP_PROFILE。" >&2
  exit 1
fi

key_file="$(mktemp)"
service_file="$(mktemp)"
env_file="$(mktemp)"

cleanup() {
  rm -f "${key_file}" "${service_file}" "${env_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

cat > "${env_file}" <<EOF
SPRING_PROFILES_ACTIVE=${app_profile}
JAVA_OPTS=${java_opts}
DB_URL=${db_url}
DB_USERNAME=${db_username}
DB_PASSWORD=${db_password}
EOF

sed \
  -e "s#{{APP_DEPLOY_DIR}}#${target_dir}#g" \
  -e "s#{{APP_PROFILE}}#${app_profile}#g" \
  -e "s#{{JAVA_OPTS}}#${java_opts}#g" \
  -e "s#{{DB_URL}}#${db_url}#g" \
  -e "s#{{DB_USERNAME}}#${db_username}#g" \
  -e "s#{{DB_PASSWORD}}#${db_password}#g" \
  "deploy/release/herness-demo.service.template" > "${service_file}"

echo "初始化远端目录"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" \
  "mkdir -p '${target_dir}/releases' '${target_dir}/shared' '${target_dir}/shared/logs'"

echo "上传环境文件"
scp -i "${key_file}" -P "${target_port}" -o StrictHostKeyChecking=no "${env_file}" \
  "${target_user}@${target_host}:${target_dir}/shared/app.env"

echo "上传 systemd unit"
scp -i "${key_file}" -P "${target_port}" -o StrictHostKeyChecking=no "${service_file}" \
  "${target_user}@${target_host}:/tmp/${service_name}.service"

echo "安装 systemd unit"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
sudo mv "/tmp/${service_name}.service" "/etc/systemd/system/${service_name}.service"
sudo systemctl daemon-reload
sudo systemctl enable "${service_name}"
echo "主机初始化完成：${service_name}"
EOF
