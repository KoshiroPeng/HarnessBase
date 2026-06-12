#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于为不暴露 Actuator 健康端点的 HTTP 服务做基础健康检查。
# 通过 bash 的 /dev/tcp 直接发送最小 GET 请求，只校验服务是否返回 2xx 或 3xx 状态码。
health_host="${1:-${HEALTHCHECK_HOST:-127.0.0.1}}"
health_port="${2:-${HEALTHCHECK_PORT:-}}"
health_path="${3:-${HEALTHCHECK_PATH:-/}}"

if [[ -z "${health_port}" ]]; then
  echo "HEALTHCHECK_PORT 未配置" >&2
  exit 1
fi

exec 3<>"/dev/tcp/${health_host}/${health_port}"
printf 'GET %s HTTP/1.1\r\nHost: %s\r\nConnection: close\r\n\r\n' "${health_path}" "${health_host}" >&3

IFS=$'\r' read -r status_line <&3 || true
status_line="${status_line//$'\r'/}"

# 中文说明：部分服务会返回 `HTTP/1.1 200 ` 这种结尾带空格的状态行，
# 这里放宽匹配规则，只校验状态码属于 2xx 或 3xx，避免因为尾随空格误判失败。
if [[ "${status_line}" =~ ^HTTP/1\.[01]\ [23][0-9][0-9]([[:space:]].*)?$ ]]; then
  exit 0
fi

echo "健康检查失败：${status_line}" >&2
exit 1
