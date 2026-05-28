# Research Method

## 1. 拆解调研问题

先把用户问题拆成五类信息：

- 调研对象：功能、架构、算法、产品设计、工程方案、技术选型或避坑经验。
- 当前上下文：技术栈、平台、已有模块、部署方式、团队能力。
- 约束条件：成本、性能、隐私、离线、本地优先、安全、维护成本、时间。
- 期望深度：quick、overview、deep、implementation、current-project。
- 决策目标：找参考、比较方案、选型、生成实现任务或验证风险。

如果缺少会改变结论的关键信息，最多问 3 个问题。否则默认按“可落地工程方案”推进。

## 2. 生成搜索关键词

不要只搜索用户原话。必须生成：

- 英文关键词：`<topic> implementation`, `<topic> architecture`, `<topic> best practices`, `<topic> example`, `<topic> pitfalls`。
- 中文关键词：`<主题> 实现方案`, `<主题> 架构设计`, `<主题> 开源项目`, `<主题> 最佳实践`, `<主题> 常见问题`。
- GitHub 查询词：主题 + 技术栈 + `stars`, `example`, `demo`, `library`, `plugin`, `awesome`。
- 官方文档查询词：产品名/框架名 + `official docs`, `guide`, `security`, `migration`, `limitations`。
- Issues 查询词：主题 + `issue`, `bug`, `discussion`, `error`, `troubleshooting`, `known limitations`。
- 论文查询词：主题 + `paper`, `survey`, `benchmark`, `technical report`, `arxiv`。

根据模式裁剪关键词。quick 模式只保留最强的 3-5 组；deep 模式使用多语言、多来源、多角度查询。

## 3. 分来源搜索

按用户需求选择来源：

- GitHub：实现、README、examples、license、维护状态、issues。
- 官方文档：推荐做法、限制、版本差异、安全注意。
- 技术博客和教程：工程经验、完整流程、坑点。
- Issues/Discussions：真实问题、边界条件、维护者回复。
- Stack Overflow / Reddit / Hacker News：社区经验，只作辅助。
- 论文/报告：理论基础、算法、评估指标和局限性。
- 产品案例：交互、功能边界、商业化取舍。

## 4. 归类方案

把来源归为可比较的方案类型，例如：

- 本地方案、云端方案、混合方案。
- 简单 MVP、成熟工程方案、高性能方案。
- 低成本方案、隐私优先方案、平台原生方案。
- 自研、集成第三方库、使用托管服务。

每类方案都要说明核心思想、代表来源、适用场景和不适用场景。

## 5. 提炼可迁移思想

必须回答：

- 哪些设计思想值得借鉴。
- 哪些代码结构、模块边界或接口风格可以参考。
- 哪些功能不应照搬。
- 哪些坑需要避免。
- 迁移到当前项目时应该如何裁剪。

优先迁移思想、架构和接口风格，不默认迁移外部代码。

## 6. 转成 Codex 任务

把推荐方案转成可执行任务：

- 任务标题。
- 目标。
- 涉及文件或模块。
- 实现步骤。
- 验证方式。
- 风险检查点。
- 不要做的事情。

如果用户尚未授权修改代码，任务只作为计划，不直接执行。

