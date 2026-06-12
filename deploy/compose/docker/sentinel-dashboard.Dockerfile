# 中文说明：该 Dockerfile 用于构建 Sentinel Dashboard 容器。
# 当前优先使用本地已准备好的 dashboard Jar，避免构建时依赖外网下载。
FROM eclipse-temurin:17-jre-jammy

WORKDIR /opt/sentinel

COPY deploy/compose/docker/sentinel-dashboard.jar /opt/sentinel/sentinel-dashboard.jar
COPY deploy/compose/docker/http-healthcheck.sh /opt/sentinel/http-healthcheck.sh

RUN chmod +x /opt/sentinel/http-healthcheck.sh

ENV SENTINEL_DASHBOARD_PORT=8718
ENV JAVA_OPTS="-Xms256m -Xmx512m"

EXPOSE 8718

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -Dserver.port=${SENTINEL_DASHBOARD_PORT} -Dcsp.sentinel.dashboard.server=localhost:${SENTINEL_DASHBOARD_PORT} -Dproject.name=sentinel-dashboard -jar /opt/sentinel/sentinel-dashboard.jar"]
