#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于对 docker-compose 部署结果执行最小验证，
# 重点确认容器进程、前端入口、核心健康端点以及本地控制台入口是否可访问。

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "${script_dir}/.env" ]]; then
  env_file="${script_dir}/.env"
else
  env_file="${script_dir}/.env.example"
fi

compose_file="${script_dir}/docker-compose.yml"

read_env_value() {
  local key="$1"
  local default_value="$2"
  local line

  line="$(grep -E "^${key}=" "${env_file}" | tail -n 1 || true)"
  if [[ -z "${line}" ]]; then
    printf '%s' "${default_value}"
    return
  fi

  printf '%s' "${line#*=}"
}

echo "检查容器状态"
docker compose --env-file "${env_file}" -f "${compose_file}" ps

gateway_port="$(read_env_value "GATEWAY_HTTP_PORT" "8080")"
nginx_port="$(read_env_value "NGINX_HTTP_PORT" "80")"
monitor_port="$(read_env_value "MONITOR_HTTP_PORT" "9100")"
sentinel_port="$(read_env_value "SENTINEL_DASHBOARD_PORT" "8718")"
nacos_console_port="$(read_env_value "NACOS_CONSOLE_PORT" "8081")"

echo "检查前端入口：http://127.0.0.1:${nginx_port}"
curl --fail --silent --show-error "http://127.0.0.1:${nginx_port}" >/dev/null

echo "检查网关健康端点：http://127.0.0.1:${gateway_port}/actuator/health"
curl --fail --silent --show-error "http://127.0.0.1:${gateway_port}/actuator/health"

echo "检查监控服务健康端点：http://127.0.0.1:${monitor_port}/actuator/health"
curl --fail --silent --show-error "http://127.0.0.1:${monitor_port}/actuator/health"

echo "检查 Sentinel 控制台入口：http://127.0.0.1:${sentinel_port}"
curl --fail --silent --show-error "http://127.0.0.1:${sentinel_port}" >/dev/null

echo "检查 Nacos 控制台入口：http://127.0.0.1:${nacos_console_port}"
curl --fail --silent --show-error "http://127.0.0.1:${nacos_console_port}" >/dev/null

echo "docker-compose 最小验证通过。"
