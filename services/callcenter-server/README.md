# 后端工程

`services/callcenter-server/` 存放从 CallCenter 合并进来的 Java 后端代码，当前基于 RuoYi-Vue-Plus 5.X 裁剪版，第一阶段采用模块化单体。

## 目录说明

- `pom.xml`：后端 Maven 聚合工程入口。
- `ruoyi-admin/`：后端启动应用。
- `ruoyi-common/`：通用能力，包括认证、安全、缓存、Web、OSS、WebSocket、SSE 等。
- `ruoyi-modules/`：业务模块入口，当前保留系统基础能力，后续呼叫中心模块从这里扩展。
- `script/sql/`：数据库初始化和升级脚本。

## 常用命令

```bash
mvn -DskipTests package
mvn test
```

## 开发约定

- 新增呼叫中心能力前，先在当前仓库 `docs/design/` 或后续补充的领域文档中明确业务边界，再实现代码。
- 不把 CTI、通话状态、坐席状态、聊天会话等核心状态直接塞进系统管理模块。
- 外部系统访问必须封装在 adapter 或 integration 边界内。
