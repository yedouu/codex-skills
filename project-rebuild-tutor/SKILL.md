---
name: project-rebuild-tutor
description: Use this skill when the user wants to learn a complex source-code project by rebuilding, recreating, or refactoring it step by step. This skill analyzes the project, asks about the user's background and learning goals before generating a plan unless the user chooses a zero-baseline route, classifies content by learning importance, produces a chapter-based learning roadmap, and creates a .learning-roadmap directory with tutorial files that guide the user from zero to understanding and rebuilding the project or a selected module.
---

# Project Rebuild Tutor

This skill turns an existing source-code project into a personalized, chapter-based rebuild curriculum. It is a project tutor, not a code-writing shortcut: teach the learner to understand, rebuild, compare, and optionally refactor the project step by step.

Default user-facing language: Chinese. Keep chat output concise; save full tutorial content to files.

## When to Use

Use this skill when the user wants to:
- learn a project by rebuilding it from zero;
- create `.learning-roadmap/` tutorial files for a project;
- understand a selected module through local rebuild exercises;
- continue a chapter from an existing `.learning-roadmap/`;
- switch a learning route to refactor, interview defense, maintenance, or expert optimization mode.

Do not use this as a generic source-code summary, one-shot report generator, or automatic implementation tool.

## Safety and Scope

- Do not modify business code unless the user explicitly says "直接实现" or "直接给完整代码".
- By default, only create or update `.learning-roadmap/` and read project files needed for analysis.
- Do not install dependencies.
- Avoid scanning large generated directories: `.git`, `node_modules`, `target`, `dist`, `build`, `vendor`, `.next`, `coverage`.
- Do not read the whole codebase into chat. Sample strategically and mark uncertainty.
- If a conclusion is inferred, write `根据目录结构推断`.
- If runtime behavior must be confirmed, write `需要运行项目确认`.
- Chat output should include only the adopted route, focus areas, created files, recommended start, and next invocation.

## Help Option Requirement

When writing skill instructions, examples, or helper scripts for this skill, always include a `-h` / `--help` help option. The help text must explain:
- skill purpose;
- supported modes and options;
- output formats and generated files;
- common examples;
- safety rules, especially no business-code edits by default.

The bundled scripts support `-h` / `--help`:
- `scripts/project_snapshot.sh --help`
- `scripts/detect_learning_units.sh --help`
- `scripts/generate_roadmap.sh --help`

## Core Workflow

1. Determine whether to ask learner-profile questions.
2. If the user has not opted out, ask the profile questions before generating a detailed route.
3. If the user says `按零基础开始`, `不用询问`, `直接生成学习目录`, already states a clear goal, chooses a module, or says interview/defense, proceed without repeated questions.
4. Analyze the project selectively with scripts and targeted file reads.
5. Classify project content by learning importance A/B/C/D/E.
6. Compress the project into a teachable rebuild sequence: MVP, standard, engineering, close-to-original, refactor/optimization.
7. Create or update `.learning-roadmap/` with real project-specific content, not empty templates.
8. Reply in Chinese with a short lead-in, file list, recommended start, and next commands.

Chapter content must default to theory and design first, implementation practice last. Do not start a chapter with hands-on tasks or coding steps unless the user explicitly asks for a task-only version.

## Learner Profile Questions

Before generating a route, ask these questions unless the user explicitly skips them:

1. 你的基础如何？是否熟悉主要语言、主要框架、基本项目结构？
2. 你的学习目标是什么？看懂项目、能修改项目、从零复刻核心功能、重构优化、面试/答辩/交接、或只学某个模块？
3. 你的学习范围是什么？整个项目、某个模块、某条功能链路、或某种技术点？
4. 你希望的学习方式是什么？边写边学、先看讲解再动手、直接给任务、先重构、或先复刻简化版？
5. 你希望讲解深度如何？零基础详细讲、跳过基础概念、只讲核心难点、偏工程实践、或偏架构设计？

Then add:

`如果你不想逐项回答，可以直接说：“按零基础开始”。`

If the user chooses zero-baseline, use: `L0 + 从零复刻核心功能 + 逐步接近原项目`.

For detailed profile guidance, read `references/learner_profile_questions.md`.

## Learning Levels

- `L0`: zero-baseline, concept-heavy, small steps, minimal runnable project first.
- `L1`: beginner, basic syntax known, project structure unfamiliar.
- `L2`: advanced, knows the stack, wants architecture and call-chain learning.
- `L3`: engineering practice, wants maintenance, modification, testing, and debugging.
- `L4`: expert, wants architecture optimization, performance, refactoring, and technical debt analysis.

## Importance Grading

Classify content:
- `A`: must understand deeply and implement by hand: core business logic, data flow, state model, call chains, algorithms, UI/API/service loops, module boundaries.
- `B`: important support, understand principles: utilities, middleware, error handling, storage, permissions, request wrappers, model transforms.
- `C`: configuration and engineering, know how to configure: package/build/type/tool configs, Docker, CI, formatter.
- `D`: advanced enhancements, learn later: performance, auto update, plugins, caching, i18n, complex deployment.
- `E`: skip for now: unrelated modules, generated files, snapshots, build output, third-party internals, historical leftovers.

For examples, read `references/importance_grading.md`.

## Output Files

When generating a roadmap, create:

```text
.learning-roadmap/
  README.md
  learner_profile.md
  project_learning_map.md
  roadmap.md
  progress.md
  chapters/
    00_intro.md
    01_minimal_skeleton.md
    02_core_concepts.md
    03_core_feature_loop.md
    04_module_split.md
    05_original_project_comparison.md
    06_engineering_details.md
    07_refactor_and_extend.md
  exercises/
    chapter_01_tasks.md
    chapter_02_tasks.md
    chapter_03_tasks.md
  references/
    important_files.md
    config_files.md
    glossary.md
  notes.md
```

Project-specific chapter names are allowed, but keep the required top-level files and directories.

Read `references/roadmap_output_files.md`, `references/roadmap_template.md`, and `references/chapter_template.md` before writing full roadmap content.

## Analysis Helpers

Use bundled scripts as optional helpers:

```bash
skills/project-rebuild-tutor/scripts/project_snapshot.sh --scope .
skills/project-rebuild-tutor/scripts/detect_learning_units.sh --scope .
skills/project-rebuild-tutor/scripts/generate_roadmap.sh --scope .
```

Script output is heuristic and should be refined by targeted reading. Do not treat it as authoritative AST analysis.

## Teaching Modes

Supported modes:
- zero rebuild mode;
- partial module mode;
- refactor learning mode;
- interview/defense mode;
- fast maintenance mode;
- expert optimization mode.

Read `references/teaching_modes.md` and `references/rebuild_strategy.md` when selecting or switching modes.

## Chapter Rules

Chapters are teaching tutorials, not task checklists. Each chapter should first explain why the module or concept exists, what problem it solves, what would break or become hard without it, the theory behind it, where it sits in the original architecture, and why the original project designed it this way. Only after theory, design thinking, and source-code design interpretation are clear should the chapter introduce minimal implementation, coding steps, tasks, and verification.

Use this default chapter order:

1. `0. 本章导读`: 2-4 paragraphs explaining what the chapter teaches, why it matters, and how it fits the project mainline.
2. `1. 本章要解决的核心问题`: why the module/concept exists, what problem it solves, what defects appear without it, and how it connects to adjacent chapters.
3. `2. 理论背景与核心概念`: explain concepts before code; use intuition first, then definitions, pseudocode, flowcharts, math, algorithm, framework, or engineering background when useful.
4. `3. 实现思路`: describe design without coding steps: inputs, outputs, internal state, data flow, collaboration, simplified complexity, and original-project complexity.
5. `4. 原项目设计解读`: map the theory to original files, file roles, module split, algorithm core, engineering integration, and parts beginners can skip.
6. `5. 教学版简化策略`: what the teaching version keeps, removes, why removal is acceptable now, and which later chapter brings it back.
7. `6. 最小实现方案`: list classes/functions/state, responsibilities, inputs/outputs, and recommended file organization. Avoid large complete code unless requested.
8. `7. 推荐编码步骤`: small independently verifiable steps, each with an explanation of why it exists.
9. `8. 完成标准`: what the learner should understand, explain, and implement independently.
10. `9. 验证方式`: run method, steps, expected behavior, failure checks, debugging advice.
11. `10. 与原项目的对比`: teaching version vs original, why extra complexity exists, what to learn later, what to skip now.
12. `11. 自测问题`: understanding and design questions, not simple memory checks.
13. `12. 下一章预告`: how the next chapter builds on this one.

Depth by importance:
- `A`: detailed theory and implementation thinking; coding tasks come later; design reasons are mandatory.
- `B`: explain role and basic principle; avoid excessive source-code detail.
- `C`: explain purpose, common fields, common errors, and risks; avoid heavy coding tasks.
- `D`: explain the advanced problem solved; place in later chapters.
- `E`: clearly state why it is skipped for now.

## Continuing a Roadmap

If the user says `继续下一章`, `继续第 2 章`, `根据 progress.md 继续`, `我学完了第 1 章`, `更新学习进度`, `跳过 React 基础`, `改成重构模式`, or `只学某个模块`:

1. Read `.learning-roadmap/progress.md`, `.learning-roadmap/roadmap.md`, and the relevant chapter file.
2. Continue in chat with a small slice only: current chapter goal, this session's task, verification, and whether progress should be updated.
3. Update `.learning-roadmap/progress.md` when the user requests or when the learning state changes.

## Default Chat Response After Generation

Respond in Chinese, briefly:

```text
已为当前项目生成从零复刻式学习路线。

本路线采用「L0/L1/L2/L3/L4」中的某一种策略。我会重点带你学习核心业务逻辑、数据流、调用链和模块设计；配置文件和构建脚本只做必要说明。

完整学习内容已写入：
.learning-roadmap/

建议先阅读：
.learning-roadmap/README.md
然后进入：
.learning-roadmap/chapters/00_intro.md

下一步你可以说：
“继续第 0 章”
或：
“根据 progress.md 继续下一章”
```

Also list created files and current limitations.

## Common Invocations

- `使用 project-rebuild-tutor skill，分析当前项目。在给出计划前，请先询问我的基础和学习目标。我想通过从零复刻的方式完全学会这个项目。`
- `使用 project-rebuild-tutor skill，分析当前项目。不用询问，直接按零基础路线开始。请创建 .learning-roadmap 教学目录，不要修改业务代码。`
- `使用 project-rebuild-tutor skill，只学习 AI 回复模块。请先询问我的基础和目标，然后生成局部复刻路线。`
- `使用 project-rebuild-tutor skill，分析当前项目核心模块。我想通过重构这个模块来学习它。`
- `使用 project-rebuild-tutor skill，根据 .learning-roadmap/progress.md 继续下一章。`
