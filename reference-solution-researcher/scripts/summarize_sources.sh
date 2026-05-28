#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: summarize_sources.sh --input sources.txt [--output sources.md]

Formats a simple source list into a Markdown sources table.
Input format: one source per line, ideally "title | url | type | notes".
This script does not browse the web and does not verify sources.
EOF
}

INPUT=""
OUTPUT="sources.md"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --input)
      INPUT="${2:-}"
      shift 2
      ;;
    --output)
      OUTPUT="${2:-sources.md}"
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

if [[ -z "$INPUT" || ! -f "$INPUT" ]]; then
  echo "Error: --input must point to an existing file." >&2
  usage >&2
  exit 1
fi

{
  echo "# Sources"
  echo
  echo "| 来源标题 | 链接 | 来源类型 | 可信度 | 相关点 | 是否推荐继续阅读 | license / 使用风险 | 备注 |"
  echo "|---|---|---|---|---|---|---|---|"
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "${line// }" ]] && continue
    IFS='|' read -r title url type notes extra <<< "$line"
    title="${title:-待补充}"
    url="${url:-待补充}"
    type="${type:-待判断}"
    notes="${notes:-待补充}"
    echo "| ${title} | ${url} | ${type} | 待评级 | ${notes} | 待判断 | 待检查 | ${extra:-} |"
  done < "$INPUT"
} > "$OUTPUT"

echo "Created $OUTPUT"

