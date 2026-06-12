#!/usr/bin/env bash

set -euo pipefail

# 中文说明：统一后端健康检查脚本，避免镜像内额外安装 curl / wget。
# 通过 bash 的 /dev/tcp 直接请求本地健康端点，适配基础镜像最小化场景。
health_port="${HEALTHCHECK_PORT:-}"
health_path="${HEALTHCHECK_PATH:-/actuator/health}"

if [[ -z "${health_port}" ]]; then
  echo "HEALTHCHECK_PORT 未配置" >&2
  exit 1
fi

exec 3<>"/dev/tcp/127.0.0.1/${health_port}"
printf 'GET %s HTTP/1.1\r\nHost: 127.0.0.1\r\nConnection: close\r\n\r\n' "${health_path}" >&3

# 中文说明：只要响应体中包含 UP 即视为通过，保持与 Spring Boot 健康端点返回结构解耦。
if grep -q 'UP' <&3; then
  exit 0
fi

exit 1
