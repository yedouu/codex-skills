# Teaching Modes

Select one mode based on the user profile and goal. The final tutorial remains file-based and Chinese by default.

## 从零复刻模式

Use when the user wants to learn the whole project or says `按零基础开始`.

Style:
- start from a minimal runnable MVP;
- explain core ideas before implementation;
- guide the user to fill key logic;
- provide reference implementation only when requested.

## 局部模块模式

Use when the user names a module, feature chain, or technical point.

Route:
1. input/output;
2. minimal local implementation;
3. API or integration boundary;
4. prompt/state/error/storage if relevant;
5. call limits or fallback if relevant;
6. original project comparison;
7. module refactor.

Do not force the whole project route.

## 重构模式

Use when the user wants to learn by refactoring.

Must include:
- current structure problems;
- what not to touch first;
- modules suitable for first refactor;
- tests needed before refactor;
- minimal safe refactor steps;
- risks per step;
- verification for unchanged behavior;
- before/after structure comparison.

Recommended sequence:
1. first version: make it run;
2. second version: split modules;
3. third version: extract types/interfaces;
4. fourth version: add error handling;
5. fifth version: add tests and engineering details;
6. sixth version: compare with original and optimize.

## 面试答辩模式

Emphasize:
- project one-sentence positioning;
- architecture diagram in text or Mermaid when useful;
- module responsibilities;
- data flow and call chain;
- design tradeoffs;
- likely questions and answer outlines.

## 快速维护模式

Emphasize:
- high-frequency modification points;
- risk areas;
- debug entry points;
- verification commands;
- what can be safely changed.

## 专家优化模式

Emphasize:
- design defects;
- alternative architectures;
- performance or reliability bottlenecks;
- technical debt;
- measurable optimization plan.
