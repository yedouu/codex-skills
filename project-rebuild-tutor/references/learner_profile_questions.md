# Learner Profile Questions

Use this reference before generating a concrete roadmap unless the user has already opted out or supplied enough context.

## Required Questions

Ask in Chinese:

1. 你的基础如何？
   - 是否熟悉这个项目的主要语言？
   - 是否熟悉这个项目的主要框架？
   - 是否能看懂基本项目结构？
2. 你的学习目标是什么？
   - 只是看懂项目；
   - 能修改项目；
   - 能从零复刻核心功能；
   - 能重构优化项目；
   - 为面试 / 答辩 / 工作交接做准备；
   - 只学习其中一个模块。
3. 你的学习范围是什么？
   - 整个项目；
   - 某个模块；
   - 某条功能链路；
   - 某种技术点。
4. 你希望的学习方式是什么？
   - 边写边学；
   - 先看讲解再动手；
   - 直接给任务让我做；
   - 先重构现有代码；
   - 先复刻一个简化版。
5. 你希望讲解深度如何？
   - 零基础详细讲；
   - 跳过基础概念；
   - 只讲核心难点；
   - 偏工程实践；
   - 偏架构设计。

Then add:

`如果你不想逐项回答，可以直接说：“按零基础开始”。`

## Skip Conditions

Do not repeat questions when the prompt clearly means:
- 不用询问；
- 直接按零基础开始；
- 直接生成学习目录；
- 我已经知道自己的目标；
- 只学习某个模块；
- 为面试/答辩准备.

## Default Route

If the user says `按零基础开始`, use:
- learner level: L0;
- goal: from-zero rebuild of core functionality;
- scope: whole project unless a module is named;
- mode: build a simplified MVP first, then approach the original project;
- explanation depth: detailed for core logic, light for config.

## Learning Levels

- L0: zero-baseline. Explain concepts, write less code per chapter, start from the smallest runnable project.
- L1: beginner. User knows basic syntax but not project structure.
- L2: advanced. User knows the stack and wants architecture, module boundaries, call chains, and tradeoffs.
- L3: engineering practice. User wants maintenance, modification, debugging, tests, and extension points.
- L4: expert. User wants architecture optimization, performance, refactoring, and technical debt analysis.

## Goal Types

- Read-only understanding: emphasize maps, data flow, call chains, and self-test questions.
- Modification ability: emphasize high-frequency change points, risks, tests, and debugging.
- From-zero rebuild: emphasize MVP, hands-on tasks, completion criteria, and original comparison.
- Refactor learning: emphasize behavior preservation, test coverage, minimal safe steps, and before/after structure.
- Interview/defense: emphasize architecture narrative, design tradeoffs, module responsibilities, and common questions.
- Partial module: generate a local rebuild route around input/output, core logic, integration, fallback, tests, and comparison.
