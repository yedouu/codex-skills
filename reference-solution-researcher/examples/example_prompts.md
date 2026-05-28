# Example Prompts

## 示例 1：普通方案调研

使用 reference-solution-researcher skill，调研：
桌面宠物项目中如何实现轻量记忆系统。
要求搜索 GitHub、官方文档和技术文章，比较方案并推荐适合 Tauri + React 的实现方式。

## 示例 2：GitHub 项目调研

使用 reference-solution-researcher skill，以 github 模式调研：
有没有可参考的源码可视化图谱项目。
请筛选 GitHub 项目，比较 stars、维护状态、license、技术栈和可迁移思路。

## 示例 3：官方文档调研

使用 reference-solution-researcher skill，以 docs 模式调研：
Tauri 自动更新的官方推荐实现方式。
请优先参考官方文档，输出当前项目适配建议。

## 示例 4：方案比较

使用 reference-solution-researcher skill，以 compare 模式比较：
本地摘要记忆、向量数据库记忆、云端记忆这三种 AI 记忆方案。
请从成本、隐私、实现难度、效果和维护角度比较。

## 示例 5：落地实现建议

使用 reference-solution-researcher skill，以 implementation 模式调研：
如何给 DeepSeek API 调用增加每日额度限制。
请输出适合当前项目的模块设计和 Codex 任务。

## 示例 6：产品参考

使用 reference-solution-researcher skill，以 product 模式调研：
桌面宠物可以有哪些高级互动功能。
请参考同类产品和 AI companion 设计，输出可落地功能列表。

## 示例 7：避坑调研

使用 reference-solution-researcher skill，以 troubleshooting 模式调研：
Tauri updater 常见问题和解决方法。
请重点搜索 issues、discussions 和官方文档。

## 示例 8：快速调研

使用 reference-solution-researcher skill，以 quick 模式调研：
别人是怎么实现番茄钟和宠物互动联动的？
只输出摘要，不创建文件。

## 示例 9：深度调研

使用 reference-solution-researcher skill，以 deep 模式调研：
源码知识图谱可视化系统的主流实现方案。
请生成完整 .reference-research 文档。

## 示例 10：显示帮助

使用 reference-solution-researcher skill，显示帮助。

或：

reference-solution-researcher --help

