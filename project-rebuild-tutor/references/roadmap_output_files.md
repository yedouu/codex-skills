# Roadmap Output Files

## Directory Structure

```text
.learning-roadmap/
  README.md
  learner_profile.md
  project_learning_map.md
  roadmap.md
  progress.md
  chapters/
  exercises/
  references/
  notes.md
```

## File Purposes and Required Content

### README.md

Learning entry. Include:
- purpose of the learning directory;
- current project learning mainline;
- recommended reading order;
- how to start chapter 0;
- how to continue next chapter;
- how to ask AI to update progress;
- how to switch learning goals;
- how to switch from whole project to module learning;
- how to switch from rebuild mode to refactor mode.

### learner_profile.md

Include:
- user background;
- learning goal;
- learning scope;
- L0-L4 level;
- explanation depth;
- default assumptions;
- if zero-baseline was chosen, record it explicitly.

### project_learning_map.md

Include:
- one-sentence project positioning;
- core modules;
- learning mainline;
- prerequisite dependency graph;
- A/B/C/D/E grading;
- what to study deeply;
- what to understand lightly;
- what to skip for now;
- what to learn later.

### roadmap.md

Full course table of contents. Each chapter includes:
- chapter number;
- title;
- type;
- core problem to solve;
- theory and core concepts;
- implementation thinking;
- original project design interpretation;
- teaching-version simplification strategy;
- minimal implementation and practice tasks placed after theory;
- corresponding original files;
- completion criteria;
- verification method;
- expected artifact;
- prerequisites;
- connection to next chapter.

### progress.md

Include:
- current stage;
- recommended next chapter;
- completed chapters;
- pending chapters;
- skipped content;
- weak-point area;
- user-question area;
- next-step suggestions;
- last update time.

### chapters/*.md

Each chapter must read like a tutorial: theory and design first, source-code design interpretation next, practice last. Use this order:

1. `0. 本章导读`;
2. `1. 本章要解决的核心问题`;
3. `2. 理论背景与核心概念`;
4. `3. 实现思路`;
5. `4. 原项目设计解读`;
6. `5. 教学版简化策略`;
7. `6. 最小实现方案`;
8. `7. 推荐编码步骤`;
9. `8. 完成标准`;
10. `9. 验证方式`;
11. `10. 与原项目的对比`;
12. `11. 自测问题`;
13. `12. 下一章预告`.

Do not put hands-on implementation or coding steps near the beginning. For A-level content, write detailed theory and design reasoning. For B-level content, explain role and basic principle. For C-level content, cover purpose, common fields, common errors, and risk only. For D-level content, defer to later chapters. For E-level content, state the skip reason.

### exercises/*.md

Include basic tasks, advanced tasks, challenge tasks, self-test questions, checkpoints, common errors, and acceptance criteria.

### references/important_files.md

Include important files, priority, role, why important, and recommended reading method.

### references/config_files.md

Downgrade config files. Include purpose, common fields, common breakages, and when to revisit.

### references/glossary.md

Include key terms, framework concepts, business concepts, abbreviations, and suggested learning order.

### notes.md

Include learner notes, AI summary, unresolved questions, and future ideas.

## Chat Lead-In Standard

After generation, chat should only include:
- adopted route;
- deeply taught content;
- lightly covered content;
- note that chapter content uses theory and implementation thinking before coding practice;
- created files;
- recommended start file/chapter;
- next invocation examples;
- current limitations.

Do not paste every chapter body into chat.

## Continue Learning

When continuing:
1. read `progress.md`;
2. read `roadmap.md`;
3. read the selected chapter;
4. teach only the next small slice;
5. update `progress.md` when the user asks or state changes.
