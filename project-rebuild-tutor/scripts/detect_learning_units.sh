#!/usr/bin/env bash
set -e

SCOPE="."

usage() {
  cat <<'EOF'
detect_learning_units.sh - heuristic learning-unit detector

Purpose:
  Guess learning units in a project for project-rebuild-tutor. Categories include entry, config, ui, service, api, state, storage, algorithm, model, route, command, event, test, build, deploy.

Options:
  --scope PATH      Project or module path to scan. Default: .
  -h, --help        Show this help.

Output format:
  Tab-separated rows: file path, guessed category, suggested importance A/B/C/D/E, reason.

Common examples:
  ./detect_learning_units.sh --scope .
  ./detect_learning_units.sh --scope ./src/features/chat

Safety rules:
  Heuristic only; not AST-perfect.
  Does not install dependencies.
  Does not modify files.
  Skips .git, node_modules, target, dist, build, vendor, .next, coverage.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --scope)
      SCOPE="${2:-.}"
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

if [ ! -d "$SCOPE" ]; then
  echo "Scope is not a directory: $SCOPE" >&2
  exit 1
fi

has_rg=0
if command -v rg >/dev/null 2>&1; then
  has_rg=1
fi

list_files() {
  if [ "$has_rg" -eq 1 ]; then
    rg --files "$SCOPE" \
      -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/target/**' -g '!**/dist/**' \
      -g '!**/build/**' -g '!**/vendor/**' -g '!**/.next/**' -g '!**/coverage/**'
  else
    find "$SCOPE" \
      \( -name .git -o -name node_modules -o -name target -o -name dist -o -name build -o -name vendor -o -name .next -o -name coverage \) -prune -o \
      -type f -print
  fi
}

echo "# Heuristic learning-unit detection"
echo "# path	category	importance	reason"

list_files | sort | while IFS= read -r file; do
  lower=$(printf '%s' "$file" | tr '[:upper:]' '[:lower:]')
  category="model"
  importance="B"
  reason="general source or model-like file"

  case "$lower" in
    *package.json|*cargo.toml|*pyproject.toml|*requirements*.txt|*tsconfig*.json|*vite.config*|*next.config*|*tauri.conf*|*.eslintrc*|*eslint.config*|*.prettierrc*|*prettier.config*)
      category="config"; importance="C"; reason="configuration or dependency manifest";;
    *dockerfile|*docker-compose*|*.github/workflows/*|*deploy*|*k8s*|*helm*)
      category="deploy"; importance="D"; reason="deployment or CI related";;
    *makefile|*cmakelists.txt|*build.gradle|*pom.xml|*rollup.config*|*webpack.config*)
      category="build"; importance="C"; reason="build script or build configuration";;
    *main.*|*index.*|*app.*|*bootstrap*|*entry*)
      category="entry"; importance="A"; reason="likely application entry point";;
    *component*|*page*|*view*|*screen*|*.tsx|*.jsx|*.vue|*.svelte)
      category="ui"; importance="A"; reason="UI layer or visual workflow";;
    *service*|*client*|*provider*|*manager*)
      category="service"; importance="A"; reason="service or orchestration layer";;
    *api*|*request*|*http*|*fetch*|*endpoint*)
      category="api"; importance="A"; reason="API boundary or network request flow";;
    *store*|*state*|*redux*|*zustand*|*context*|*reducer*)
      category="state"; importance="A"; reason="state management or state transition logic";;
    *storage*|*db*|*database*|*repository*|*repo*|*cache*|*persist*)
      category="storage"; importance="B"; reason="storage, cache, persistence, or repository layer";;
    *algorithm*|*parser*|*rank*|*search*|*match*|*score*|*engine*)
      category="algorithm"; importance="A"; reason="algorithmic or engine-like logic";;
    *route*|*router*|*navigation*)
      category="route"; importance="B"; reason="routing or navigation";;
    *command*|*cmd*|*cli*)
      category="command"; importance="B"; reason="command or CLI behavior";;
    *event*|*listener*|*subscriber*|*handler*)
      category="event"; importance="B"; reason="event handling or handler logic";;
    *test*|*spec*|*/tests/*|*/__tests__/*)
      category="test"; importance="B"; reason="test file or verification example";;
    *snapshot*|*generated*|*lock|*.map)
      category="build"; importance="E"; reason="generated, lock, or snapshot-like file";;
  esac

  printf '%s\t%s\t%s\t%s\n' "$file" "$category" "$importance" "$reason"
done
