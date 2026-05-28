---
name: reference-solution-researcher
description: Use this skill when the user wants to research how other projects, teams, documents, or products solve a similar problem. This skill performs web/GitHub/reference research, generates search queries, evaluates sources, compares solution patterns, extracts transferable ideas, recommends an approach, and creates a .reference-research directory with structured research documents and Codex-ready implementation tasks.
---

# Reference Solution Researcher

Use this skill when the user wants to know how others solve a similar feature, architecture, product design, engineering approach, algorithm, or technology-selection problem. The default user-facing language is Chinese, even though these instructions are in English.

This skill is not a generic search engine, simple link list, code generator, or GitHub-only finder. It is a reference-solution research assistant that searches, filters, compares, extracts transferable ideas, recommends an approach, and turns the result into Codex-ready implementation tasks.

## Help Mode

If the user asks for `reference-solution-researcher -h`, `reference-solution-researcher --help`, `显示帮助`, or `说明用法`, output only the help text from `references/help.md`.

In help mode:
- Do not browse the web.
- Do not inspect the project.
- Do not create files.
- Do not modify anything.

## Supported Modes

Default to `overview` if no mode is specified.

- `overview`: general reference-solution research.
- `github`: focus on open-source implementations and repository quality.
- `docs`: focus on official documentation and recommended practices.
- `compare`: compare known candidate approaches.
- `implementation`: convert research into a buildable implementation plan.
- `product`: research product, competitor, and interaction-design references.
- `paper`: research papers, technical reports, and theory-backed approaches.
- `troubleshooting`: research known pitfalls, issues, discussions, and fixes.
- `quick`: short research pass; normally no files unless the user asks.
- `deep`: broad multi-source research with a full `.reference-research/` report.
- `current-project`: combine external research with the current project context.

## Options To Recognize

- `--query <text>`: research topic.
- `--mode <mode>`: one of the supported modes.
- `--tech-stack <stack>`: current stack or preferred stack.
- `--scope <path>`: project subdirectory to inspect for current-project mode.
- `--sources github,docs,blogs,papers,issues,products`: source types to prioritize.
- `--output-dir <path>`: output directory; default `.reference-research/`.
- `--no-files`: only output the chat summary.
- `--quick`: quick research behavior.
- `--deep`: deep research behavior.
- `-h` / `--help`: help only.

## Core Workflow

1. Understand the request: identify what the user wants to reference, whether it is a feature, architecture, algorithm, product design, engineering scheme, or technology choice. Extract tech stack, constraints, and preference such as simple, mature, high-performance, low-cost, privacy-first, or maintainable.
2. Ask at most three clarification questions only if the missing information would materially change the research. If the user does not answer or wants to proceed, default to a practical engineering solution.
3. If the user says "current project", "my project", "fit this codebase", "migration", or asks for Codex tasks, inspect only the necessary project structure and relevant files. Do not modify business code unless explicitly requested.
4. Generate search queries, including English, Chinese, GitHub, official docs, issues/troubleshooting, and optionally paper queries. Never search only the user's original wording.
5. Browse the web when current or online sources are requested. If browsing is unavailable, say so clearly and do not invent links, repositories, or evidence.
6. Search across appropriate source types: GitHub, official docs, technical blogs, GitHub Issues/Discussions, Stack Overflow, Reddit, Hacker News, papers/technical reports, product cases, and tutorials.
7. Filter sources by relevance, authority, recency, code availability, documentation clarity, tech-stack fit, maintenance, license risk, migration cost, complexity, and security risk.
8. Prefer S/A sources. Use C/D sources only as supporting context, never as the main basis.
9. Classify solution patterns, compare tradeoffs, extract transferable ideas, recommend one approach, and explain why other approaches are less suitable.
10. Produce Codex-ready tasks with objective, files likely involved, steps, validation, risk checks, and "do not do" constraints.
11. Unless `--no-files` is set or `quick` mode only needs a summary, create or update the output directory with structured Markdown documents.
12. In chat, output only the leading summary, not the full long report.
13. Always end with the usage report described below.

## Output Directory

Default output directory in the target project:

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

Use `--output-dir <path>` if provided. Do not create files in quick mode unless the user requests it.

Bundled helpers:
- `scripts/normalize_query.sh`: create a lightweight research brief from a raw query.
- `scripts/make_research_brief.sh`: create the initial `.reference-research/` skeleton.
- `scripts/summarize_sources.sh`: format a plain source list into `sources.md`.

Reference files:
- Read `references/research_method.md` for the detailed research method.
- Read `references/source_quality_grading.md` when grading sources.
- Read `references/solution_comparison_template.md` when comparing approaches.
- Read `references/research_report_template.md` when writing report files or chat summaries.
- Read `references/codex_tasks_template.md` when producing Codex-ready tasks.
- Read `references/help.md` for help mode.

## Required Chat Summary

Use this Chinese structure by default:

```markdown
# 参考方案调研完成：{主题}

## 1. 调研目标
用 1-3 句话说明本次要参考什么方案。

## 2. 找到的主流方案
列出 3-6 类方案。

## 3. 最推荐方案
说明推荐哪个方案以及原因。

## 4. 最值得借鉴的思想
列出 3-5 个思想。

## 5. 已生成的调研文档
列出 `.reference-research/` 中创建的文件。

## 6. 下一步建议
给出 3 个下一步调用建议或 Codex 实现建议。

## 7. 使用量报告
- 真实 token / 额度百分比：当前环境未提供，无法精确读取
- 估算消耗等级：低 / 中 / 高
- 主要消耗来源：...
- 本次节约措施：...
- 下次节约建议：...
```

If real token/cost/quota data is available from the environment, report it. Otherwise, never invent it.

## Safety And Copyright Rules

- Do not copy external code by default.
- Always consider license. If a repository has no license, warn that code cannot be directly reused.
- If a license may be incompatible, mark the risk clearly.
- Summarize sources; do not reproduce long copyrighted passages.
- Distinguish verified facts from inference.
- Do not modify project code unless the user explicitly requests implementation.
- Do not leak secrets or include sensitive local data in reports.
- Do not fabricate sources, links, GitHub repositories, statistics, or dates.
- If source quality is weak or the conclusion is uncertain, say so directly.

