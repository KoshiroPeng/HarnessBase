---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: ruoyi-common-oss AWS SDK 编译恢复验证证据，记录模块职责、真实阻塞根因、恢复步骤与主链路编译结果。
---

# 验证证据

## 基本信息

- 任务名称：`ruoyi-common-oss` 编译阻塞恢复
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：`ruoyi-common-oss` AWS SDK 依赖链异常导致 `ruoyi-system` / `ruoyi-admin` 主编译链失败
- 变更范围：[server/ruoyi-common/ruoyi-common-oss/pom.xml](../../server/ruoyi-common/ruoyi-common-oss/pom.xml)、[docs/plans/backlog.md](../plans/backlog.md)

## 验证目标

- 本次需要证明什么：
  - `ruoyi-common-oss` 的职责是对象存储基础设施能力，而不是当前业务域核心模块
  - 阻塞根因来自本机 Maven 本地仓库损坏，而不是 `OssClient` 代码本身错误
  - `ruoyi-common-oss` 模块编译已恢复
  - `ruoyi-system` 与 `ruoyi-admin` 依赖主链路编译已恢复
- 本次不覆盖什么：
  - OSS 运行时联调
  - 文件上传、预签名 URL、头像上传等功能级回归测试
  - Maven 全局 settings 治理与团队环境统一分发

## 模块职责结论

- [server/ruoyi-common/ruoyi-common-oss](../../server/ruoyi-common/ruoyi-common-oss) 是当前仓库的对象存储基础设施模块。
- 它负责统一封装 S3 兼容对象存储客户端、上传下载、删除文件、预签名 URL 等能力。
- `ruoyi-system` 已真实依赖该模块，例如 [SysOssServiceImpl.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/service/impl/SysOssServiceImpl.java) 与 [SysProfileController.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/system/SysProfileController.java)。
- 结论：它不是业务主域，但属于当前后端编译链不能忽略的基础设施模块。

## 根因结论

- 首次失败表象：
  - `ruoyi-common-oss` 编译时提示 `software.amazon.awssdk.auth.credentials`、`software.amazon.awssdk.core.async`、`software.amazon.awssdk.regions` 等包缺失。
- 继续下钻后确认：
  - AWS SDK 主 jar 可下载，但 Maven 将其 POM 判定为 invalid，导致传递依赖无法进入编译类路径。
  - 真实破坏点不是 AWS SDK 坐标本身，而是本机 Maven 本地仓库中的 `D:\dev\apache-maven-3.9.6\repo\org\junit\junit-bom\5.10.0\junit-bom-5.10.0.pom` 被缓存成了 0 字节文件。
  - 该损坏文件被 AWS 的 `bom-internal` 间接引用，最终让 `s3`、`auth`、`sdk-core`、`netty-nio-client`、`s3-transfer-manager` 等 POM 解析失效。
- 最终判断：
  - 这是“本地 Maven 缓存损坏引发的依赖树断裂”问题，不是 `ruoyi-common-oss` 源码主逻辑问题。

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | 模块职责核对 | 检查 [OssClient.java](../../server/ruoyi-common/ruoyi-common-oss/src/main/java/org/dromara/common/oss/core/OssClient.java)、[OssFactory.java](../../server/ruoyi-common/ruoyi-common-oss/src/main/java/org/dromara/common/oss/factory/OssFactory.java)、[SysOssServiceImpl.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/service/impl/SysOssServiceImpl.java) | 通过 | 确认其为对象存储基础设施能力模块 |
| 2 | 初始阻塞复现 | `mvn -B -pl ruoyi-common/ruoyi-common-oss -am -DskipTests compile` | 通过 | 成功复现 AWS SDK 缺失导致的编译失败 |
| 3 | 上游 POM 失效根因定位 | 使用 `maven-dependency-plugin:get -X` 检查 `software.amazon.awssdk:s3` / `software.amazon.awssdk:bom-internal` | 通过 | 定位到 `junit-bom-5.10.0.pom` 为 0 字节 |
| 4 | 损坏缓存修复 | 删除损坏的 `junit-bom-5.10.0.pom` 后重新拉取 | 通过 | 重新下载后文件长度恢复为 5649 字节 |
| 5 | 模块依赖收口 | 检查 [server/ruoyi-common/ruoyi-common-oss/pom.xml](../../server/ruoyi-common/ruoyi-common-oss/pom.xml) | 通过 | 补充编译期直接使用的 `auth`、`sdk-core`、`regions` 直依赖，并清理本次新增注释乱码 |
| 6 | 模块编译恢复 | `mvn -B -pl ruoyi-common/ruoyi-common-oss -am -DskipTests compile` | 通过 | `ruoyi-common-oss` 编译成功 |
| 7 | 主链路编译恢复 | `mvn -B -pl ruoyi-admin,ruoyi-modules/ruoyi-system -am -DskipTests compile` | 通过 | `ruoyi-system`、`ruoyi-admin` 及依赖链全部成功 |

## 关键命令或操作记录

```text
git status --short --branch
mvn -B -pl ruoyi-common/ruoyi-common-oss -am -DskipTests compile
mvn -B dependency:get "-Dartifact=software.amazon.awssdk:auth:2.28.22"
mvn -B dependency:get "-Dartifact=software.amazon.awssdk:sdk-core:2.28.22"
mvn -B dependency:get "-Dartifact=software.amazon.awssdk:regions:2.28.22"
mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.1:get "-Dartifact=software.amazon.awssdk:s3:2.28.22:pom" -Dtransitive=false -X
mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.1:get "-Dartifact=software.amazon.awssdk:bom-internal:2.28.22:pom" -Dtransitive=false -X
Remove-Item -LiteralPath D:\dev\apache-maven-3.9.6\repo\org\junit\junit-bom\5.10.0\junit-bom-5.10.0.pom -Force
mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.1:get "-Dartifact=org.junit:junit-bom:5.10.0:pom" -Dtransitive=false
mvn -B -pl ruoyi-admin,ruoyi-modules/ruoyi-system -am -DskipTests compile
```

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，恢复过程没有引入新的运行时框架或偏离现有模块边界。
- 是否仍存在历史残留：存在，当前 Maven 仍依赖本机全局仓库与镜像配置，团队环境一致性风险尚未制度化收口。
- 若存在残留，是否已记录到 backlog：已记录到 [docs/plans/backlog.md](../plans/backlog.md)。

## 结果摘要

- 功能结果：本次不涉及业务功能变更，属于基础设施编译链恢复。
- 测试结果：模块编译与主链路编译均已通过。
- 文档同步结果：已补充本验证证据，并更新 backlog 中关于 `ruoyi-common-oss` 阻塞状态的陈述。
- 发布或运行验证结果：未执行运行时联调，当前仅确认构建闭环恢复。

## 未覆盖风险

- 当前只验证到“能编译”，没有执行 OSS 真实上传下载、预签名 URL、头像上传等运行时验证。
- 团队内若存在其他机器上的本地 Maven 缓存损坏，仍可能再次出现同类问题。

## 后续动作

- 将“0 字节 POM / 本地仓库损坏”纳入团队 Maven 环境排障说明，形成可复用手册。
- 条件允许时，为 `ruoyi-common-oss` 补一轮最小运行时联调或集成测试，覆盖上传、下载与预签名 URL。
