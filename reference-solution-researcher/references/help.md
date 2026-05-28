# reference-solution-researcher 帮助

## Purpose

`reference-solution-researcher` 是一个联网参考方案调研 Skill，用来帮助你了解别人如何实现某个功能、架构、产品设计、工程方案或技术选型。它会生成中英文搜索关键词，搜索 GitHub、官方文档、技术博客、论文、Issues、产品案例等来源，筛选高质量资料，比较方案优缺点，并输出适合当前项目的推荐方案和 Codex 可执行任务。

它不是普通搜索引擎，也不是简单链接列表，更不是自动复制别人代码的工具。

## Supported Modes

- `overview`：普通参考方案调研，适合“别人一般怎么做”。
- `github`：重点搜索 GitHub 开源实现，比较 stars、维护状态、license、技术栈和可迁移思路。
- `docs`：重点查官方文档，整理官方推荐做法、限制、版本差异和适配建议。
- `compare`：比较多个已知候选方案。
- `implementation`：把调研结论转成可落地实现建议和 Codex 任务。
- `product`：参考产品设计、竞品功能和交互模式。
- `paper`：参考论文、技术报告、算法或理论方案。
- `troubleshooting`：查找别人遇到的坑、Issues、Discussions 和解决方法。
- `quick`：快速搜索，只给摘要，默认不创建文件。
- `deep`：深度调研，生成完整 `.reference-research/` 文档。
- `current-project`：结合当前项目结构和技术栈给出迁移建议。

## Options

- `--query <text>`：调研主题。
- `--mode <mode>`：选择调研模式。
- `--tech-stack <stack>`：指定当前技术栈。
- `--scope <path>`：结合当前项目的某个目录。
- `--sources github,docs,blogs,papers,issues,products`：指定来源类型。
- `--output-dir <path>`：指定输出目录，默认 `.reference-research/`。
- `--no-files`：只在聊天中输出摘要，不创建文件。
- `--quick`：快速调研。
- `--deep`：深度调研。
- `-h` / `--help`：显示帮助。帮助模式不会联网搜索、不会扫描项目、不会创建文件、不会修改任何内容。

## Output Formats

默认聊天窗口只输出先导性摘要：

- 调研目标。
- 找到的主流方案。
- 最推荐方案。
- 最值得借鉴的思想。
- 已生成的调研文档。
- 下一步建议。
- 使用量报告。

默认文件输出目录：

```text
.reference-research/
  README.md
  research_brief.md
  search_queries.md
  sources.md
  solution_categories.md
  solution_comparison.md
  recommended_approach.md
  implementation_notes.md
  risks_and_tradeoffs.md
  codex_tasks.md
  open_questions.md
```

## Common Examples

```text
使用 reference-solution-researcher skill，调研：
桌面宠物项目中如何实现轻量记忆系统。
要求搜索 GitHub、官方文档和技术文章，比较方案并推荐适合 Tauri + React 的实现方式。
```

```text
使用 reference-solution-researcher skill，以 github 模式调研：
有没有可参考的源码可视化图谱项目。
请筛选 GitHub 项目，比较 stars、维护状态、license、技术栈和可迁移思路。
```

```text
使用 reference-solution-researcher skill，以 docs 模式调研：
Tauri 自动更新的官方推荐实现方式。
请优先参考官方文档，输出当前项目适配建议。
```

```text
使用 reference-solution-researcher skill，以 compare 模式比较：
本地摘要记忆、向量数据库记忆、云端记忆这三种 AI 记忆方案。
请从成本、隐私、实现难度、效果和维护角度比较。
```

```text
reference-solution-researcher --help
```

## Safety Rules

- 不照搬外部代码。
- 不输出受版权保护的大段内容。
- 不忽略 license；无 license 仓库不得直接复用代码。
- 不修改项目代码，除非用户明确要求实现。
- 不泄露敏感信息。
- 不虚构来源、链接、GitHub 项目、stars、日期或结论。
- 如果无法联网，必须明确说明无法实时验证来源。
- 如果来源不足或结论是推断，必须明确标注。

