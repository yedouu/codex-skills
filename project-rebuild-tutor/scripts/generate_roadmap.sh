#!/usr/bin/env bash
set -e

SCOPE="."
OUT_DIR=".learning-roadmap"
ROUTE="L0 zero-baseline rebuild"

usage() {
  cat <<'EOF'
generate_roadmap.sh - create initial .learning-roadmap scaffold

Purpose:
  Generate a rough .learning-roadmap directory for project-rebuild-tutor. This is only a draft scaffold; Codex must fill it with real project-specific analysis.

Options:
  --scope PATH      Project or module path used in the draft metadata. Default: .
  --out DIR         Output directory. Default: .learning-roadmap
  --route TEXT      Learning route label. Default: L0 zero-baseline rebuild
  -h, --help        Show this help.

Output format:
  Markdown files under .learning-roadmap/, including README.md, learner_profile.md, project_learning_map.md, roadmap.md, progress.md, chapters/, exercises/, references/, and notes.md.

Common examples:
  ./generate_roadmap.sh --scope .
  ./generate_roadmap.sh --scope ./src/features/chat --route "L2 partial module route"

Safety rules:
  Creates or updates only the selected roadmap output directory.
  Does not modify business code.
  Does not install dependencies.
  Draft content must be replaced or enriched by Codex before final delivery.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --scope)
      SCOPE="${2:-.}"
      shift 2
      ;;
    --out)
      OUT_DIR="${2:-.learning-roadmap}"
      shift 2
      ;;
    --route)
      ROUTE="${2:-L0 zero-baseline rebuild}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

mkdir -p "$OUT_DIR/chapters" "$OUT_DIR/exercises" "$OUT_DIR/references"

now=$(date '+%Y-%m-%d %H:%M:%S %z')

cat > "$OUT_DIR/README.md" <<EOF
# 项目复刻式学习路线

用途：这里保存当前项目的长期学习材料，用于从零复刻、局部模块学习或重构式学习。

当前范围：$SCOPE
当前路线：$ROUTE
生成时间：$now

确认状态：
- 已确认内容：已创建学习目录结构。
- 根据目录结构推断：需要 Codex 继续填充项目定位、模块、章节和任务。
- 需要运行项目确认：运行方式、交互行为、测试命令。

推荐阅读顺序：
1. learner_profile.md
2. project_learning_map.md
3. roadmap.md
4. chapters/00_intro.md

继续学习时可以说：
- 继续第 0 章
- 根据 progress.md 继续下一章
- 更新学习重点
- 改成重构模式
EOF

cat > "$OUT_DIR/learner_profile.md" <<EOF
# 学习画像

- 用户基础：默认按零基础开始，除非用户另行说明。
- 学习目标：从零复刻核心功能，并逐步接近原项目。
- 学习范围：$SCOPE
- 学习档位：$ROUTE
- 讲解深度：核心逻辑详细讲，配置和构建脚本只做必要说明。
- 默认假设：用户希望边写边学，不希望一次性获得完整代码。
- 确认状态：这是脚本生成的初始画像，需要 Codex 根据用户回答更新。
EOF

cat > "$OUT_DIR/project_learning_map.md" <<EOF
# 项目学习地图

项目一句话定位：需要进一步阅读源码确认。

项目核心模块：需要进一步阅读源码确认。

项目学习主线：
1. 先建立最小可运行闭环。
2. 再理解核心数据流和调用链。
3. 再拆分模块并对比原项目。
4. 最后补工程化和重构优化。

A/B/C/D/E 重要性分级：
- A：核心逻辑、主数据流、关键调用链，必须亲手实现。
- B：工具封装、错误处理、存储、模型转换，需要理解原理。
- C：配置、构建、格式化、CI，会配置即可。
- D：性能、插件、自动更新、复杂部署，后期再学。
- E：生成文件、构建产物、无关模块，暂时跳过。

确认状态：需要 Codex 根据项目文件填充真实模块和文件列表。
EOF

cat > "$OUT_DIR/roadmap.md" <<EOF
# 课程总目录

## 第 0 章：项目定位与学习路线
- 章节类型：概念章
- 章节目标：理解项目要解决的问题和学习路线。
- 学习重点：核心闭环、模块边界、重要性分级。
- 需要亲手实现：暂不写代码，先画出最小闭环。
- 对应原项目文件：需要进一步阅读源码确认。
- 完成标准：能用自己的话说明项目主线。
- 预计产物：项目学习地图草稿。
- 前置依赖：无。
- 下一章衔接：进入最小骨架。

## 第 1 章：最小可运行骨架
- 章节类型：编码章
- 章节目标：搭建能运行的教学版 MVP。
- 学习重点：入口、最小数据结构、最小交互或 API。
- 需要亲手实现：最小闭环。
- 对应原项目文件：需要进一步阅读源码确认。
- 完成标准：能运行一个最小版本并解释流程。
- 预计产物：MVP 骨架。
- 前置依赖：第 0 章。
- 下一章衔接：补核心概念。
EOF

cat > "$OUT_DIR/progress.md" <<EOF
# 学习进度

- 当前学习阶段：未开始
- 建议下一章：chapters/00_intro.md
- 已完成章节：无
- 待完成章节：00_intro, 01_minimal_skeleton, 02_core_concepts, 03_core_feature_loop, 04_module_split, 05_original_project_comparison, 06_engineering_details, 07_refactor_and_extend
- 跳过内容：暂未记录
- 薄弱点记录区：待填写
- 用户问题记录区：待填写
- 下一步建议：阅读 README.md，然后进入第 0 章。
- 最近一次更新时间：$now
EOF

for chapter in 00_intro 01_minimal_skeleton 02_core_concepts 03_core_feature_loop 04_module_split 05_original_project_comparison 06_engineering_details 07_refactor_and_extend; do
  cat > "$OUT_DIR/chapters/$chapter.md" <<EOF
# $chapter

本章目标：需要 Codex 根据真实项目分析补全。

为什么这一章重要：帮助学习者逐步从教学版接近原项目。

本章涉及的原项目文件：需要进一步阅读源码确认。

本章需要深入理解的内容：核心逻辑、数据流、调用链或模块边界，按章节主题确定。

本章只需简单了解的配置或辅助文件：需要进一步阅读源码确认。

本章需要亲手实现的内容：根据学习路线补全。

本章推荐编码步骤：先写最小骨架，再补关键逻辑，再验证。

本章完成标准：能解释、能实现、能验证、能与原项目对比。

本章验证方式：需要 Codex 根据项目运行方式补全命令、步骤、预期现象和失败检查点。

常见错误和调试建议：需要后续学习过程补充。

与原项目的对比：需要进一步阅读源码确认。

自测问题：需要 Codex 按本章内容补充。

下一章预告：见 roadmap.md。
EOF
done

for task in chapter_01_tasks chapter_02_tasks chapter_03_tasks; do
  cat > "$OUT_DIR/exercises/$task.md" <<EOF
# $task

基础任务：完成本章最低可运行目标。

进阶任务：加入真实项目中的关键支撑细节。

挑战任务：尝试接近原项目结构或进行小步重构。

自测问题：需要 Codex 根据章节内容补充。

参考检查点：能运行、能解释、能定位对应原项目文件。

常见错误：需要学习过程中记录。

验收标准：满足章节完成标准并通过验证方式。
EOF
done

cat > "$OUT_DIR/references/important_files.md" <<EOF
# 重要文件

需要 Codex 根据项目分析补全：文件学习优先级、作用、重要原因、建议阅读方式。
EOF

cat > "$OUT_DIR/references/config_files.md" <<EOF
# 配置文件

配置文件降权处理：先会用，不一开始深挖。

需要补充：重要配置文件用途、常改字段、改错后的问题、何时深入学习。
EOF

cat > "$OUT_DIR/references/glossary.md" <<EOF
# 术语表

需要补充：项目关键术语、框架概念、业务概念、缩写解释、建议学习顺序。
EOF

cat > "$OUT_DIR/notes.md" <<EOF
# 学习笔记

## 用户学习笔记区

## AI 总结区

## 待解决问题区

## 后续想法区
EOF

echo "Created initial roadmap scaffold at $OUT_DIR"
