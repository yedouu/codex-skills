#!/usr/bin/env bash
set -e

SCOPE="${1:-.}"

SKIP_DIRS=(.git node_modules target dist build vendor .next coverage logs tmp)

has_rg() {
  command -v rg >/dev/null 2>&1
}

find_files() {
  if has_rg; then
    rg --files "$SCOPE" \
      -g '!*.png' -g '!*.jpg' -g '!*.jpeg' -g '!*.gif' -g '!*.webp' -g '!*.mp4' -g '!*.zip' \
      -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/target/**' -g '!**/dist/**' \
      -g '!**/build/**' -g '!**/vendor/**' -g '!**/.next/**' -g '!**/coverage/**' \
      -g '!**/logs/**' -g '!**/tmp/**'
  else
    find "$SCOPE" -type f \
      ! -path '*/.git/*' ! -path '*/node_modules/*' ! -path '*/target/*' ! -path '*/dist/*' \
      ! -path '*/build/*' ! -path '*/vendor/*' ! -path '*/.next/*' ! -path '*/coverage/*' \
      ! -path '*/logs/*' ! -path '*/tmp/*' \
      ! -iname '*.png' ! -iname '*.jpg' ! -iname '*.jpeg' ! -iname '*.gif' ! -iname '*.webp' \
      ! -iname '*.mp4' ! -iname '*.zip'
  fi
}

print_section() {
  title="$1"
  pattern="$2"
  echo
  echo "## $title"
  find_files | grep -Ei "$pattern" | head -n 80 || true
}

echo "# PROJECT SNAPSHOT"
echo "Scope: $SCOPE"
echo "Note: This is a lightweight file-path snapshot. It does not read large file contents."

echo
echo "## ROOT FILES"
find_files | awk 'BEGIN{FS="/"} NF<=2 {print}' | head -n 80 || true

print_section "DOC FILES" '(^|/)(readme|docs?|documentation|guide|manual|spec|requirements|prd|adr)|\.(md|mdx|rst|txt)$'
print_section "API / ROUTE FILES" '(^|/)(api|apis|route|routes|router|controller|controllers|endpoint|endpoints|handler|handlers)(/|\.|-|_)|(\.controller\.|\.route\.|routes\.)'
print_section "SERVICE / USECASE FILES" '(^|/)(service|services|usecase|usecases|workflow|workflows|job|jobs|action|actions|manager|managers)(/|\.|-|_)|(\.service\.|\.usecase\.|\.workflow\.)'
print_section "MODEL / ENTITY FILES" '(^|/)(model|models|entity|entities|schema|schemas|dto|dtos|message|messages|event|events|domain)(/|\.|-|_)|(\.model\.|\.entity\.|\.schema\.|\.dto\.)'
print_section "STATE / ENUM FILES" '(^|/)(state|states|status|statuses|enum|enums|constant|constants|transition|transitions)(/|\.|-|_)|(\.state\.|\.status\.|\.enum\.|constants\.)'
print_section "TEST / EXAMPLE FILES" '(^|/)(test|tests|spec|specs|example|examples|fixture|fixtures|story|stories)(/|\.|-|_)|(\.test\.|\.spec\.)'
print_section "UI PAGE FILES" '(^|/)(page|pages|screen|screens|view|views|component|components|app)(/|\.|-|_)|(\.tsx$|\.jsx$|\.vue$|\.svelte$)'
print_section "CONFIG FILES" '(^|/)(config|configs|settings|env|policy|policies|permission|permissions)(/|\.|-|_)|(\.ya?ml$|\.toml$|\.json$|\.ini$|\.env)'

echo
echo "## SKIPPED DIRECTORIES"
for dir in "${SKIP_DIRS[@]}"; do
  if [ -d "$SCOPE/$dir" ] || find "$SCOPE" -type d -name "$dir" -prune 2>/dev/null | grep -q .; then
    echo "$dir"
  fi
done
