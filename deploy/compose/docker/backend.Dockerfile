# 中文说明：该 Dockerfile 用于统一构建各个后端微服务运行镜像。
# 通过 APP_JAR_FILE 构建参数指定具体模块的 Jar，避免为每个服务重复维护一份 Dockerfile。
FROM eclipse-temurin:17-jre-jammy

ARG APP_JAR_FILE

WORKDIR /opt/harness-base

COPY ${APP_JAR_FILE} /opt/harness-base/app.jar
COPY deploy/compose/docker/backend-entrypoint.sh /opt/harness-base/backend-entrypoint.sh
COPY deploy/compose/docker/backend-healthcheck.sh /opt/harness-base/backend-healthcheck.sh

RUN chmod +x /opt/harness-base/backend-entrypoint.sh /opt/harness-base/backend-healthcheck.sh

ENV APP_JAR_PATH=/opt/harness-base/app.jar
ENV WAIT_FOR_HOST=ruoyi-nacos
ENV WAIT_FOR_PORT=8848
ENV WAIT_TIMEOUT_SECONDS=180
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

ENTRYPOINT ["/opt/harness-base/backend-entrypoint.sh"]
