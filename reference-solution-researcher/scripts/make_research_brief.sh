#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: make_research_brief.sh --query "<text>" [--output-dir ".reference-research"] [--mode "<mode>"] [--tech-stack "<stack>"]

Creates the initial reference research directory and starter README/research_brief files.
It does not browse the web and does not modify business code.
EOF
}

QUERY=""
OUTPUT_DIR=".reference-research"
MODE="overview"
TECH_STACK="未指定"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --query)
      QUERY="${2:-}"
      shift 2
      ;;
    --output-dir)
      OUTPUT_DIR="${2:-.reference-research}"
      shift 2
      ;;
    --mode)
      MODE="${2:-overview}"
      shift 2
      ;;
    --tech-stack)
      TECH_STACK="${2:-未指定}"
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

if [[ -z "$QUERY" ]]; then
  echo "Error: --query is required." >&2
  usage >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

cat > "$OUTPUT_DIR/README.md" <<EOF
# 参考方案调研

## 本次调研目的
${QUERY}

## 推荐阅读顺序
1. research_brief.md
2. search_queries.md
3. sources.md
4. solution_categories.md
5. solution_comparison.md
6. recommended_approach.md
7. implementation_notes.md
8. risks_and_tradeoffs.md
9. codex_tasks.md
10. open_questions.md

## 每个文件的作用
- research_brief.md：记录需求、范围、上下文和结论。
- search_queries.md：记录中英文关键词和搜索逻辑。
- sources.md：记录来源质量、相关点和 license 风险。
- solution_categories.md：归类主流方案。
- solution_comparison.md：比较优缺点、成本、风险和适配度。
- recommended_approach.md：说明最终推荐方案和取舍。
- implementation_notes.md：沉淀可落地设计建议。
- risks_and_tradeoffs.md：列出风险和规避策略。
- codex_tasks.md：给出可直接交给 Codex 的任务。
- open_questions.md：记录仍需确认的问题。

## 如何继续深挖
让 Codex 读取本目录，然后指定要深挖的方案、来源类型或问题。

## 如何让 Codex 根据调研结果实现功能
把 codex_tasks.md 中的任务交给 Codex，并明确允许修改哪些业务文件。

## 如何更新调研
优先基于已有 sources.md 和 open_questions.md 增量搜索，不要每次重新全量调研。
EOF

cat > "$OUTPUT_DIR/research_brief.md" <<EOF
# Research Brief

## 用户原始需求
${QUERY}

## 需求拆解
- 待补充：用户想参考的功能、架构、算法、产品设计、工程方案或技术选型。

## 当前项目上下文
- 技术栈：${TECH_STACK}
- 结合当前项目：待确认。

## 调研范围
- 模式：${MODE}
- 来源：GitHub、官方文档、技术博客、Issues/Discussions、产品案例、论文/报告，按实际需求筛选。

## 最终推荐结论
- 待联网搜索、筛选和比较后补充。

## 适用边界
- 本调研用于借鉴思路和方案取舍，不默认复用外部代码。
- 任何外部代码复用都需要单独检查 license 和兼容性。
EOF

echo "Created $OUTPUT_DIR/README.md and $OUTPUT_DIR/research_brief.md"

