---
name: project-business-mapper
description: Use this skill when the user wants to quickly understand the business domain of a local or remote source-code project, including GitHub repositories. This skill analyzes the project from a business perspective, extracts business goals, user/system roles, domain objects, core flows, state machines, business rules, edge cases, key ideas, and maps them back to source files. It creates a .business-understanding directory with structured business documents and outputs only a concise summary in chat.
---

# Project Business Mapper

Use this skill to analyze a source-code project from a business perspective. The default user-facing language is Chinese.

This skill supports local projects, online repositories, repository subdirectories, and user-provided archive/local paths. It is not a line-by-line code explainer, architecture report generator, call graph analyzer, code-writing tool, README summarizer, or rebuild tutorial. It is a business understanding assistant that extracts business purpose, roles, domain objects, flows, state machines, business rules, risks, and key product/design ideas.

## Help Mode

If the user asks for `project-business-mapper -h`, `project-business-mapper --help`, `显示帮助`, or `说明用法`, output only the help text from `references/help.md`.

In help mode:
- Do not scan local or remote projects.
- Do not create `.business-understanding/`.
- Do not clone repositories.
- Do not modify any files.
- Do not run helper scripts.

## Repository URL Detection

Treat the request as remote repository analysis when the user provides a repository URL or SSH Git URL, including:

- `https://github.com/owner/repo`
- `https://github.com/owner/repo/tree/branch/path`
- `https://github.com/owner/repo/blob/branch/file`
- `git@github.com:owner/repo.git`
- GitLab, Gitee, Bitbucket, or other Git URLs when accessible

Supported sources:
- Public GitHub repositories.
- Private GitHub repositories if the current Codex environment has access.
- GitLab, Gitee, Bitbucket, or other Git repositories if accessible.
- User-provided repository archives or local paths.

When a repository URL is detected, use remote analysis rules rather than local project rules.

## Supported Modes

Default local mode is `overview`. Default remote mode is `lightweight-remote`.

Local modes:
- `overview`: full-project business understanding.
- `module`: business analysis for one module or directory.
- `flow`: one concrete business flow.
- `state-machine`: state extraction and transition risk analysis.
- `rules`: business rules and test implications.
- `interview`: interview or defense-ready business explanation.
- `change-impact`: business impact analysis for a requested change or current git diff.
- `pm-view`: product manager perspective.
- `engineer-handoff`: new engineer handoff perspective.

Remote modes:
- `lightweight-remote`: read README, docs, manifests, directory tree, key file lists, and a small number of core files. Prefer this when the user has not specified a remote mode.
- `full-remote`: with user permission or explicit request, shallow clone and analyze like a local project.
- `scoped-remote`: analyze only a repository subdirectory.
- `remote-interview`: produce interview or defense-ready business explanation from an online repository.
- `remote-change-impact`: analyze business impact of a requested change against an online repository.

Supported options:
- `--repo <url>`: specify an online repository URL.
- `--branch <name>`: specify branch or tag.
- `--scope <path>`: limit analysis to a local path or repository subdirectory.
- `--mode <mode>`: choose a local mode.
- `--remote-mode lightweight|full|scoped|interview|change-impact`: choose a remote mode.
- `--no-clone`: use remote reads only; do not clone.
- `--clone-depth <n>`: shallow clone depth; default `1`.
- `--output-dir <path>`: choose output directory; default `.business-understanding/`.
- `--no-files`: only output a chat summary; do not create files.
- `--refresh`: regenerate existing business documents.
- `--diff`: include current git diff in change impact analysis.
- `-h` / `--help`: show help only.

## Core Principles

1. Business first, technology second.
2. Understand the problem before explaining implementation.
3. Prefer roles, objects, flows, states, rules, edge cases, and ideas.
4. Explicitly separate business logic from technical implementation details.
5. Avoid deep dives into build scripts, generic utilities, framework glue, and config unless they affect business behavior.
6. Map each business conclusion to source files when possible.
7. Mark uncertainty using one of: `根据目录结构推断`, `需要进一步阅读源码确认`, `需要运行项目确认`, `需要业务方确认`.
8. Do not invent business roles, flows, rules, or objects.
9. Output only a concise lead summary in chat by default.
10. Save complete results to `.business-understanding/` unless `--no-files` is used.

## Recommended Input Sources

Read selectively. Do not read the whole repository at once.

Priority:
1. README and docs for goals and usage scenarios.
2. Routes, controllers, APIs, pages, and commands for business entry points.
3. Services, use cases, workflows, jobs, actions, and handlers for flows.
4. Models, entities, schemas, DTOs, messages, events, and domain files for objects.
5. Enums, constants, status, state, and transition logic for state machines and rules.
6. Tests, fixtures, examples, and stories for expected behavior and edge cases.
7. UI pages and components for user paths.
8. Config only when it changes business behavior.

Skip by default:
`.git`, `node_modules`, `target`, `dist`, `build`, `vendor`, `.next`, `coverage`, `logs`, `tmp`, binary files, large assets, images, videos, archives, and third-party library internals.

For remote repositories, never read secret-like file contents such as `.env`, `secret`, `key`, `pem`, `credentials`, or certificates. If such files appear in a tree listing, only record that sensitive configuration files exist.

## Local Workflow

1. Check for help mode first.
2. Determine mode and scope; default to `overview`.
3. If continuing an existing analysis, read `.business-understanding/` first and update incrementally.
4. Read README/docs and project entry points.
5. Run or inspect helper scripts only as needed:
   - `scripts/project_snapshot.sh [scope]`
   - `scripts/detect_business_units.sh [scope]`
   - `scripts/extract_business_candidates.sh [scope] [output-dir]`
6. Confirm candidates by reading relevant source snippets.
7. Grade business importance with `references/business_importance_grading.md`.
8. Write structured documents using `references/business_output_schema.md` and templates.
9. In chat, output only the lead summary and usage report.

## Remote Repository Workflow

1. Detect repository URL and extract owner, repo, branch/tag, and path/subdirectory when possible.
2. Determine remote mode; default to `lightweight-remote`.
3. First read README and directory structure using available GitHub app/API/web/raw file access when possible.
4. Identify project type: Web app, backend service, mobile app, desktop app, AI app, robot system, SDK/tool library, algorithm library, data platform, or other.
5. Identify likely business-bearing directories: `docs`, `src`, `app`, `packages`, `services`, `server`, `backend`, `frontend`, `routes`, `controllers`, `usecases`, `workflows`, `models`, `entities`, `schemas`, `messages`, `tests`, `examples`.
6. Prefer remote reads over full clone for README, docs, manifests, directory tree, and selected key files.
7. If full analysis requires clone, explain why before cloning. Use a temporary directory or a user-specified directory, shallow clone by default with depth `1`, and skip large directories.
8. If the URL points to a subdirectory, analyze only that subdirectory unless the user asks otherwise.
9. Extract business goals, actors, objects, flows, state machines, rules, edge cases, and key ideas.
10. Save documents to the current working directory `.business-understanding/` or `--output-dir <path>`, not to the remote repository.
11. Clearly mark confirmed content, README/tree-based inference, source-confirmed content, runtime-only uncertainty, and business-owner questions.

## Remote Analysis Safety

- Default to read-only analysis.
- Do not modify remote repositories.
- Do not create commits.
- Do not push.
- Do not create pull requests.
- Do not modify remote files.
- Do not leak private repository content in unnecessary detail; summarize sensitive private context.
- Do not download large binary files.
- Do not analyze `node_modules`, `dist`, `build`, `target`, `vendor`, or similar large generated/vendor directories.
- Do not scan or print secrets, tokens, certificates, private keys, or credentials.
- If the remote repository cannot be accessed, state the access problem instead of inventing results.
- If the repository is large, suggest specifying `--scope`.
- If analysis is based only on README and tree structure, explicitly say the analysis depth is limited.

## Output Directory

For local projects, default output directory is the analyzed project:

```text
.business-understanding/
```

For remote repositories, default output directory is the current working directory:

```text
.business-understanding/
```

Use `--output-dir <path>` when the user wants another location. If `--no-files` is used, do not create files.

Expected full document set:

```text
.business-understanding/
  README.md
  business_overview.md
  business_map.md
  roles_and_actors.md
  domain_model.md
  core_flows.md
  state_machines.md
  business_rules.md
  edge_cases.md
  key_insights.md
  technical_mapping.md
  change_impact_notes.md
  interview_summary.md
  glossary.md
  open_questions.md
```

## Chat Summary Format

Default final chat output must be Chinese and concise:

```markdown
# 业务拆解完成：{项目名}

## 分析来源

- 仓库：
- 分支 / tag：
- 分析范围：
- 远程分析模式：
- 是否 clone：
- 输出目录：
- 分析深度说明：

## 1. 项目业务一句话定位

## 2. 核心业务主线

## 3. 最重要的业务对象

## 4. 最重要的业务思想

## 5. 已生成的业务理解文档

## 6. 建议下一步

## 7. 使用量报告
- 真实 token / 额度百分比：当前环境未提供，无法精确读取
- 估算消耗等级：低 / 中 / 高
- 主要消耗来源：...
- 本次节约措施：...
- 下次节约建议：...
```

For local-only analysis, omit `分析来源` unless useful. For remote analysis, always include it.

If remote analysis is lightweight, include this exact sentence:

`本次为轻量远程分析，主要基于 README、目录结构和少量关键文件。部分业务结论可能需要进一步阅读源码或运行项目确认。`

Do not paste the full generated documents into chat unless the user explicitly asks.

## Mode Guidance

For `overview`, cover project positioning, actors, objects, closed loop, flows, state machines, rules, edge cases, ideas, and source mapping.

For `module`, focus on module goal, actors, objects, inputs/outputs, flows, rules, risks, and source files.

For `flow`, cover trigger, actors, input, preconditions, normal steps, state changes, output, exceptions, rules, and source mapping.

For `state-machine`, cover state list, meanings, allowed transitions, forbidden transitions, triggers, terminal states, abnormal states, risks, and source mapping.

For `rules`, cover rules, why they exist, consequences of violation, source mapping, tests, and change notes.

For `interview`, produce a speakable version: one-line intro, background, core flow, key design ideas, difficulties, highlights, improvements.

For `change-impact`, read current git diff first if `--diff` or the user asks to analyze current changes. If not in a git repo, say diff cannot be read automatically and analyze from the user description.

For `pm-view`, minimize code discussion and emphasize user value, business path, roles, rules, experience, risk, and improvements.

For `engineer-handoff`, emphasize what to understand first, rules not to break, risky modules, where to read before changing requirements, test focus, and common pitfalls.

For `lightweight-remote`, do not clone unless the user changes mode or explicitly allows it.

For `full-remote`, shallow clone only after explaining why clone is needed or when the user explicitly requested full remote analysis.

For `scoped-remote`, treat the URL path or `--scope` as the analysis boundary.

For `remote-interview`, prioritize business positioning, core flow, ideas, highlights, difficulty, and speakable phrasing.

For `remote-change-impact`, use the user’s change description to find likely affected objects, flows, states, rules, and tests. Do not modify code.

## References

Load only the reference needed for the current task:
- `references/help.md`: help output.
- `references/business_mapping_method.md`: extraction method and uncertainty handling.
- `references/business_output_schema.md`: output files and chat summary schema.
- `references/business_importance_grading.md`: A/B/C/D/E grading.
- `references/business_report_template.md`: overview/module/flow/interview templates.
- `references/domain_model_template.md`: domain model templates.
- `references/state_machine_template.md`: state machine templates.
- `references/business_rules_template.md`: business rules templates.
- `examples/example_prompts.md`: user prompt examples.

## Safety Rules

- Do not modify business code unless the user separately asks for code changes.
- Do not install dependencies.
- Do not run destructive commands.
- Do not scan large directories.
- Do not read all code at once.
- Do not treat candidates as confirmed conclusions.
- Do not treat third-party internals as project business logic.
- In help mode, do not create or modify anything.
- For remote repositories, stay read-only and never commit, push, open PRs, or modify remote files.
- Complete business documents must be based on project content; when uncertain, label the uncertainty.
