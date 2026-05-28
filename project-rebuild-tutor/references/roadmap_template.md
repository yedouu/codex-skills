# Roadmap Template

Use this as the structure for `.learning-roadmap/roadmap.md`. Replace placeholders with real project analysis.

## Route Summary

- 学习档位：L0/L1/L2/L3/L4
- 学习目标：从零复刻 / 局部模块 / 重构 / 面试答辩 / 快速维护 / 专家优化
- 学习范围：整个项目或指定模块
- 主线：每章先讲理论和实现思路，再解读原项目设计，最后安排最小实现、编码步骤和验证；整体路线先核心闭环，再模块拆分，再工程化，再原项目对比，再重构优化。

## Chapter Teaching Order

Every chapter should be planned as a tutorial, not a task list. Roadmap entries should make clear which concept/design topic comes before practice.

Required chapter flow:
1. 本章导读；
2. 本章要解决的核心问题；
3. 理论背景与核心概念；
4. 实现思路；
5. 原项目设计解读；
6. 教学版简化策略；
7. 最小实现方案；
8. 推荐编码步骤；
9. 完成标准；
10. 验证方式；
11. 与原项目的对比；
12. 自测问题；
13. 下一章预告。

Importance rules:
- A 级：理论背景和实现思路详细，必须解释原项目设计原因，实践任务后置；
- B 级：讲清楚作用和基本原理，不必过度展开源码细节；
- C 级：只讲用途、常改字段、常见错误和风险，不安排大量编码任务；
- D 级：说明解决的高级问题，放到后期章节；
- E 级：标明暂时跳过原因。

## Phase 1: MVP Version

Only keep the core loop.

Goal:
- run a tiny version quickly;
- expose the project's central idea;
- avoid early complexity.

Typical chapters:
- 00_intro
- 01_minimal_skeleton
- 02_core_concepts
- 03_core_feature_loop

## Phase 2: Standard Version

Add major features and module boundaries.

Goal:
- understand the main modules;
- connect data flow, state, UI/API/service layers;
- compare simplified implementation with original files.

Typical chapters:
- 04_module_split
- 05_original_project_comparison

## Phase 3: Engineering Version

Add practical project concerns.

Goal:
- understand why real projects become complex;
- add config, error handling, persistence, tests, and build flow.

Typical chapters:
- 06_engineering_details

## Phase 4: Close-to-Original Version

Gradually add original features and architecture details.

Goal:
- identify what the original project adds beyond the teaching version;
- learn which complexity is valuable and which can be postponed.

## Phase 5: Refactor and Optimization Version

Learn through improvement.

Goal:
- identify design weaknesses;
- propose safe refactor steps;
- verify behavior remains unchanged.

Typical chapters:
- 07_refactor_and_extend

## Chapter Entry Format

For every chapter include:
- 章节编号；
- 章节标题；
- 章节类型；
- 理论与核心概念；
- 要解决的核心问题；
- 实现思路；
- 原项目设计解读重点；
- 教学版简化策略；
- 最后才安排的最小实现和实践任务；
- 对应原项目文件；
- 完成标准；
- 验证方式；
- 预计产物；
- 前置依赖；
- 下一章衔接。
