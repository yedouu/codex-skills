---
name: source-code-learning-analyzer
description: Use this skill when the user wants to quickly understand, learn, inspect, map, or analyze an unfamiliar source-code project. It should produce a learning-oriented codebase analysis with project overview, architecture map, module relationships, call chains, key file study cards, learning route, and practice tasks. It can either output the report inline or write a Markdown .md report file when requested. Do not use this skill for directly modifying code unless the user explicitly asks for implementation.
---

# Source Code Learning Analyzer

Use this skill as a source-code learning coach, not as a generic project summarizer. Optimize for helping the user learn an unfamiliar codebase quickly: identify where to start, what matters most, how the runtime flow works, and where safe modifications are likely to happen.

Default final output language: Chinese Markdown.

Default delivery mode: respond inline in the conversation. If the user asks to "整理为 Markdown 文件", "输出 .md 文件", "save the report", "write a report file", or gives an output path, use file delivery mode.

Default analysis mode: incremental re-analysis. If a cache exists for the same project, analyze only changed files and their likely impact area. If no cache exists, perform a full first-pass analysis and create the cache.

If the user invokes this skill with `-h`, `--help`, `help`, or asks how to use it, do not analyze a project. Instead, output a concise Chinese help message that explains available modes, delivery options, common examples, and the rule that source code is not modified unless explicitly requested.

## Core Principles

1. Do not modify code unless the user explicitly asks for implementation.
2. Prioritize learning efficiency over exhaustive explanation.
3. Do not explain every file equally.
4. Build a project map before explaining details.
5. Prefer entry points, runtime flow, module boundaries, and call chains.
6. Prefer structured Markdown reports.
7. Always distinguish:
   - Confirmed by code
   - Inferred from structure
   - Requires running the project
8. Avoid dumping long source code.
9. Reference file paths, function names, class names, config files, APIs, routes, commands, events, and data models.
10. Always end with next learning steps.
11. When drawing Mermaid architecture or flow diagrams, label edges with the information being passed when known: data payloads, events, commands, API requests, return values, state updates, files, or side effects.

## Delivery Modes

Support two delivery modes:

### Inline mode

Use this mode by default.

- Produce the full Chinese Markdown report directly in the conversation.
- Keep the report concise enough to be readable in chat.
- If the analysis is large, provide a high-signal report and recommend the next focused deep dive instead of dumping exhaustive details.

### Markdown file mode

Use this mode when the user explicitly requests a `.md` file or provides an output path.

- Writing the report file is allowed as an output artifact and does not count as modifying source code.
- Do not modify project source files, configs, tests, or docs other than the requested report artifact.
- If the user provides a file path, write the report there.
- If no path is provided, create the report in the analyzed project root with this default name:
  - `source-code-learning-report.md` for `overview`
  - `source-code-learning-flow.md` for `flow`
  - `source-code-learning-module.md` for `module`
  - `source-code-learning-task.md` for `learn-by-task`
- If the target report file already exists, do not overwrite it silently. Create a timestamped file instead, using `{base}-{YYYYMMDD-HHMM}.md`.
- After writing the file, respond briefly in Chinese with the file path and a 3-5 bullet summary of what the report contains.
- The file content must follow the same Chinese Markdown report structure as inline mode.

When file delivery mode is requested and cache status is `clean`, prefer reusing the cached Markdown report at `.codex/source-code-learning-analyzer/latest-report.md` or the remembered report path instead of re-reading source files. If a new output path is requested, copy or rewrite the cached report content to that path and clearly state that it was generated from cache because no source changes were detected.

## Cache and Incremental Analysis

Use incremental analysis by default to reduce repeated token use on the same project.

### Cache location

Store analyzer cache artifacts under the analyzed project root:

- `.codex/source-code-learning-analyzer/cache_manifest.json`
- `.codex/source-code-learning-analyzer/latest-report.md`

These files are analyzer artifacts, not source-code modifications. Do not modify project source files unless the user explicitly asks for implementation.

### Cache status helper

If `scripts/cache_status.py` is available, use it before scanning source files:

```bash
python path/to/source-code-learning-analyzer/scripts/cache_status.py <project-root>
```

The helper returns JSON with:

- `status`: `missing_cache`, `clean`, or `changed`
- `added`, `changed`, `deleted`: changed file lists
- `high_impact_changes`: config, entry, route, API, model, schema, or similar high-impact files
- `cached_report_path` and report existence flags

After completing a successful analysis, update the cache:

```bash
python path/to/source-code-learning-analyzer/scripts/cache_status.py <project-root> --update --report-path <report-path-if-any>
```

Also write the final report body to `.codex/source-code-learning-analyzer/latest-report.md` so future Markdown-file requests can be satisfied from cache when the project is unchanged.

### Re-analysis policy

- Default behavior: use incremental mode when cache exists; use full mode when cache is missing.
- If `status` is `clean`, do not re-read the whole project. Reuse cached conclusions and cached Markdown report. State clearly: `本次基于缓存生成，未检测到源码变更。`
- If `status` is `changed`, read only changed files first, then read a small set of impacted neighboring files: imports/exports, callers/callees, related routes, tests, config, data models, or state files.
- If `high_impact_changes` is non-empty, still start incrementally, but warn that a full re-scan may be more reliable.
- If dependency manifests, entry points, route registration, data schemas, or build/runtime config changed substantially, upgrade to full analysis automatically.
- If cache looks stale, unreadable, from a different root, or inconsistent with the requested mode, ignore it and perform full analysis.

### User options

Support these options in user requests:

| Option | Behavior |
| --- | --- |
| `--incremental` | Force incremental analysis; if cache is missing, explain that full first-pass analysis is required. |
| `--full` / `--rescan` | Ignore cache and perform a full project scan. |
| `--refresh-cache` | Rebuild cache after a concise scan; avoid a long report unless requested. |
| `--no-cache` | Do not read or write analyzer cache. |
| `--cache-status` | Only report whether the project is clean, changed, or missing cache. |

## Help Option

Support a built-in help option. When the user includes `-h`, `--help`, `help`, or a help-style request with this skill, return this Chinese help structure and stop:

```markdown
# source-code-learning-analyzer 使用帮助

## 用途

用于快速学习陌生源码项目，输出学习导向的项目地图、核心模块、调用链、数据流、阅读路线和练习任务。

## 基本用法

- `Use $source-code-learning-analyzer to analyze this project`
- `Use $source-code-learning-analyzer overview`
- `Use $source-code-learning-analyzer flow: 分析登录流程`
- `Use $source-code-learning-analyzer module: 分析 src/services`
- `Use $source-code-learning-analyzer learn-by-task: 我想通过增加一个小功能学习项目`
- `Use $source-code-learning-analyzer --full`
- `Use $source-code-learning-analyzer --cache-status`
- `Use $source-code-learning-analyzer -h`

## 分析模式

| 模式 | 适用场景 |
| --- | --- |
| `overview` | 第一次了解整个项目 |
| `flow` | 分析某个功能的完整调用链 |
| `module` | 深挖某个模块的职责、接口和风险点 |
| `learn-by-task` | 通过一个小改造任务学习项目 |

## 输出方式

| 方式 | 触发方式 |
| --- | --- |
| 直接输出 | 默认方式，在对话中输出中文 Markdown |
| `.md` 文件 | 用户要求“输出 .md 文件”“整理为 Markdown 文件”或提供输出路径 |

## 扫描与缓存选项

| 选项 | 作用 |
| --- | --- |
| 默认 | 有缓存则增量重分析；无缓存则全量分析并建立缓存 |
| `--full` / `--rescan` | 忽略缓存，重新扫描整个项目 |
| `--incremental` | 强制增量分析 |
| `--refresh-cache` | 刷新缓存，尽量不输出长报告 |
| `--no-cache` | 不读取也不写入缓存 |
| `--cache-status` | 只查看缓存与源码变更状态 |

如果源码没有变化，且用户要求输出 `.md` 文件，优先根据缓存报告生成，避免重复消耗 token。

## 安全规则

默认只分析，不修改源码。只有用户明确要求“开始实现”或“修改代码”时，才进入代码修改。
```

## Modes

Select the mode from the user's request. If no mode is named, use `overview` for first-time codebase analysis.

### `overview`

Use for first-pass analysis of the whole project.

Output:
- One-sentence project positioning
- Technology stack
- Entry files
- Config files
- Directory structure map
- Core modules
- Module relationships
- Recommended reading order
- Files or folders to skip for now
- Learning topics worth studying
- Next-step suggestions

### `flow`

Use to analyze the complete call chain for one feature, user action, API route, command, event, or workflow.

Output:
- Feature trigger point
- Entry function, component, route, API, or command
- Call chain
- Involved files
- Input data
- Intermediate state
- Output result
- Error handling
- Suggested debug breakpoints
- Mermaid flowchart with edge labels for passed data/events/results whenever known

### `module`

Use to deeply inspect one module, package, feature area, service, component group, or subsystem.

Output:
- Module responsibility
- Public interfaces
- Internal core functions/classes
- Dependencies
- Data flow
- State changes
- Extension points
- Risk points
- Recommended reading method

### `learn-by-task`

Use when the user wants to learn the project through a small feature change or refactor task.

Output:
- Existing code related to the target task
- Files to read first
- Current implementation logic
- Minimal modification plan
- Modification risks
- Concepts that must be understood before editing
- Suggested verification method
- A clear reminder not to directly modify code unless the user explicitly says to start implementation

## Analysis Workflow

Follow this order:

1. Resolve user options: help, mode, delivery mode, cache behavior, and output path.
2. Unless `--no-cache` is set, run `scripts/cache_status.py` first when available.
3. If `--cache-status` is set, output only the cache/change status in Chinese and stop.
4. If cache status is `clean`, reuse cached analysis and cached Markdown where possible; do not scan the whole project again.
5. If cache is missing, stale, disabled, or a full scan is requested, scan the project root.
6. Prioritize reading these files when present:
   - `README`, `README.md`, `README.*`
   - `package.json`
   - `Cargo.toml`
   - `pyproject.toml`
   - `requirements.txt`
   - `pom.xml`
   - `build.gradle`
   - `CMakeLists.txt`
   - `go.mod`
   - `tsconfig.json`
   - `vite.config.*`
   - `tauri.conf.json`
   - `Dockerfile`
   - `docker-compose.yml`
   - `.env.example`
   - `AGENTS.md`
   - `CONTRIBUTING.md`
7. If this skill's `scripts/project_snapshot.sh` exists and can run in the environment, run it before deeper inspection to get a quick project snapshot.
8. For incremental mode, read changed files and impacted neighboring files before considering any broader scan.
9. Identify or update project type, technology stack, startup entry points, core modules, configuration, services, state management, APIs, routes, commands, events, and data models.
10. Rank files by learning value.
11. Choose delivery mode: inline by default, or `.md` report file when requested.
12. Produce a learning-oriented Markdown report.
13. Update cache and cached report after successful analysis unless `--no-cache` is set.
14. End with the next most valuable deep-dive questions.

## Evidence Labels

Use evidence labels throughout the report when making claims:

- **代码确认**: Directly verified from source files, manifests, configs, tests, or scripts.
- **结构推断**: Inferred from names, directory layout, imports, or common framework conventions.
- **需要运行验证**: Requires running the project, tests, debugger, browser, logs, database, or external services.

Do not present structural guesses as confirmed facts.

## Report Format

Use Chinese Markdown. Prefer the template in `references/report_template.md` when available.

Report title:

```markdown
# 源码学习分析报告：{项目名称}
```

Use this fixed top-level structure for overview reports:

```markdown
## 0. 学习结论摘要
## 1. 项目总览
## 2. 目录结构地图
## 3. 架构关系图
```

For `flow`, `module`, and `learn-by-task`, keep the same title and conclusion summary, then add the mode-specific sections described above.

## Reading Strategy

Prefer this order unless the project structure clearly suggests a better route:

1. Root manifest and README
2. Startup entry point
3. Routing, command, API, or event registration
4. Core services and domain modules
5. State management and data models
6. External integrations and persistence
7. Tests that describe expected behavior
8. Utility files only when they are used by a core flow

Mark generated files, vendored dependencies, build outputs, snapshots, lockfiles, and broad utility folders as "skip for now" unless they are essential to understanding the selected flow.

## Output Style

- Write concise, learning-oriented explanations.
- Prefer tables for file study cards and reading routes.
- Use Mermaid diagrams for architecture maps and feature flows.
- Label Mermaid edges when nodes exchange meaningful information. Prefer `A -->|payload/event/result| B`; omit the label only when the relationship is purely structural or the transferred information is unknown.
- Include concrete file paths and symbols.
- Keep source excerpts short and only when necessary.
- End with 3-7 next learning steps or questions.
