#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: normalize_query.sh --query "<text>" [--tech-stack "<stack>"] [--mode "<mode>"]

Creates a lightweight research brief from a raw user request.
This script does not perform NLP, browse the web, inspect a project, or modify code.
It only prints a Markdown template for Codex to refine.
EOF
}

QUERY=""
TECH_STACK="未指定"
MODE="overview"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --query)
      QUERY="${2:-}"
      shift 2
      ;;
    --tech-stack)
      TECH_STACK="${2:-未指定}"
      shift 2
      ;;
    --mode)
      MODE="${2:-overview}"
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

cat <<EOF
# 调研 Brief 草稿

## 原始需求
${QUERY}

## 目标类型
- 待 Codex 判断：功能 / 架构 / 算法 / 产品设计 / 工程方案 / 技术选型 / 避坑排查

## 调研模式
${MODE}

## 技术栈
${TECH_STACK}

## 约束
- 默认优先：可落地、可维护、低迁移成本、尊重 license、避免照搬外部代码

## 推荐搜索方向
- GitHub 开源实现
- 官方文档与示例
- 技术博客与教程
- Issues / Discussions / troubleshooting
- 产品案例或论文资料，按模式选择

## 英文关键词草稿
- ${QUERY} implementation
- ${QUERY} architecture
- ${QUERY} best practices
- ${QUERY} open source
- ${QUERY} pitfalls

## 中文关键词草稿
- ${QUERY} 实现方案
- ${QUERY} 架构设计
- ${QUERY} 开源项目
- ${QUERY} 最佳实践
- ${QUERY} 常见问题
EOF

