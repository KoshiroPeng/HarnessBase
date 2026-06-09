---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase HTTP 客户端边界核对验证证据，记录裸 HTTP 扫描结果与适配层合法使用边界。
---

# 验证证据

## 基本信息

- 任务名称：裸 HTTP 客户端边界核对
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：P2 代码与质量硬化，聚焦“外部系统调用必须通过 adapter 或 ApiClient 抽象接入”
- 变更范围：[docs/architecture/boundaries.md](../architecture/boundaries.md)、[docs/plans/backlog.md](../plans/backlog.md)

## 验证目标

- 本次需要证明什么：
  - 当前仓库是否存在业务代码直接发起外部 HTTP 请求的情况
  - 社会化登录 provider 适配器中的 HTTP 调用是否应视为违规
  - 模块边界文档和 backlog 是否已明确“业务层禁止，适配层允许”的边界
- 本次不覆盖什么：
  - 社会化登录 provider 适配器内部进一步抽象重构
  - 第三方 SDK 底层 transport 实现
  - 未来新增代码的防回退自动化

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | 裸 HTTP 客户端初扫 | `rg -n "RestTemplate|WebClient|HttpURLConnection|OkHttpClient|CloseableHttpClient|HttpClient|new URL\\(|URLConnection|Jsoup\\.connect|Unirest|HttpUtil\\.|HttpRequest\\.|HttpResponse\\b" server web` | 通过 | 命中包括 URL 解析、WebSocket 类型、OSS SDK transport 与社会化登录 provider 适配器 |
| 2 | 精确外部 HTTP 发起点扫描 | `rg -n "HttpRequest\\.|request\\.execute\\(|new HttpUtils\\(|RestTemplate|WebClient" server` | 通过 | 真实发起点集中在 `ruoyi-common-social` 及其内嵌的 provider request 扩展类 |
| 3 | 业务层边界核对 | 检查 [AuthController.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/controller/AuthController.java) 与 [SocialUtils.java](../../server/ruoyi-common/ruoyi-common-social/src/main/java/org/dromara/common/social/utils/SocialUtils.java) | 通过 | `AuthController` 未直接发起 HTTP，请求由 `SocialUtils` 组装的 provider `AuthRequest` 适配器处理 |
| 4 | 规则同步核对 | 检查 [docs/architecture/boundaries.md](../architecture/boundaries.md) 与 [docs/plans/backlog.md](../plans/backlog.md) | 通过 | 已明确“业务层禁止直接 HTTP，适配层/provider 封装属合法边界” |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，外部 HTTP 访问当前集中在 `ruoyi-common-social` 适配层和基础设施实现中。
- 是否仍存在历史残留：未发现业务 Controller / Service 直接发起外部 HTTP 请求；后续仍需防止新代码回退。
- 若存在残留，是否已记录到 backlog：已在 [docs/plans/backlog.md](../plans/backlog.md) 记录为“边界已澄清，后续继续防回退”。 

## 关键命令或操作记录

```text
rg -n "RestTemplate|WebClient|HttpURLConnection|OkHttpClient|CloseableHttpClient|HttpClient|new URL\(|URLConnection|Jsoup\.connect|Unirest|HttpUtil\.|HttpRequest\.|HttpResponse\b" server web
rg -n "HttpRequest\.|request\.execute\(|new HttpUtils\(|RestTemplate|WebClient" server
```

## 结果摘要

- 功能结果：本次未修改业务代码，完成了 HTTP 客户端使用边界的事实核对与规则澄清。
- 测试结果：静态扫描表明当前命中的外部 HTTP 调用集中在社会化登录 provider 适配器与基础设施层。
- 文档同步结果：模块边界文档与 backlog 已明确“业务层禁止直接 HTTP，适配层允许”的规则。
- 发布或运行验证结果：未执行，本次仅涉及文档边界澄清。

## 未覆盖风险

- 若后续在业务模块中新增 `HttpRequest`、`RestTemplate` 或 `WebClient`，仍需要自动化护栏及时阻断。
- 本次未对 `ruoyi-common-social` provider 适配器做进一步统一封装，只确认其当前落点符合边界。

## 后续动作

- 将“业务层直接 HTTP”扫描逐步纳入自动化护栏，允许名单限定在 provider 适配器或基础设施层。
- 继续进入下一条治理项：直接跨层调用扫描。
