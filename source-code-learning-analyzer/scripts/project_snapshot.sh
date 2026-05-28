#!/usr/bin/env sh
set -eu

ROOT="${1:-.}"

cd "$ROOT"

echo "# Project Snapshot"
echo
echo "## Root"
pwd
echo

echo "## Key Files"
for pattern in \
  "README" "README.md" "README.*" \
  "package.json" "Cargo.toml" "pyproject.toml" "requirements.txt" \
  "pom.xml" "build.gradle" "CMakeLists.txt" "go.mod" \
  "tsconfig.json" "vite.config.*" "tauri.conf.json" \
  "Dockerfile" "docker-compose.yml" ".env.example" \
  "AGENTS.md" "CONTRIBUTING.md"
do
  for file in $pattern; do
    if [ -f "$file" ]; then
      printf '%s\n' "$file"
    fi
  done
done | sort -u
echo

echo "## Top-Level Entries"
find . -maxdepth 1 -mindepth 1 \
  ! -name ".git" \
  -print | sed 's#^\./##' | sort
echo

echo "## Directory Map"
if command -v tree >/dev/null 2>&1; then
  tree -a -L 3 \
    -I ".git|node_modules|dist|build|target|.venv|venv|__pycache__|.next|.turbo|coverage|vendor"
else
  find . -maxdepth 3 \
    \( -path "./.git" -o -path "./node_modules" -o -path "./dist" -o -path "./build" -o -path "./target" -o -path "./.venv" -o -path "./venv" -o -path "./__pycache__" -o -path "./.next" -o -path "./.turbo" -o -path "./coverage" -o -path "./vendor" \) -prune \
    -o -print | sed 's#^\./##' | sort
fi
echo

echo "## Entry Point Candidates"
find . -maxdepth 4 \
  \( -path "./.git" -o -path "./node_modules" -o -path "./dist" -o -path "./build" -o -path "./target" -o -path "./.venv" -o -path "./venv" -o -path "./__pycache__" -o -path "./.next" -o -path "./.turbo" -o -path "./coverage" -o -path "./vendor" \) -prune \
  -o \( \
    -name "main.*" -o -name "index.*" -o -name "App.*" -o -name "server.*" -o -name "app.*" \
    -o -name "lib.rs" -o -name "main.rs" -o -name "mod.rs" \
    -o -name "main.py" -o -name "__main__.py" \
    -o -name "cmd" \
  \) -print | sort
echo

echo "## Source File Type Counts"
find . -type f \
  \( -path "./.git/*" -o -path "./node_modules/*" -o -path "./dist/*" -o -path "./build/*" -o -path "./target/*" -o -path "./.venv/*" -o -path "./venv/*" -o -path "./__pycache__/*" -o -path "./.next/*" -o -path "./.turbo/*" -o -path "./coverage/*" -o -path "./vendor/*" \) -prune \
  -o -type f -print |
  awk '
    function ext(path, base, parts, n) {
      n = split(path, parts, "/")
      base = parts[n]
      if (base !~ /\./) return "[no extension]"
      sub(/^.*\./, ".", base)
      return base
    }
    { counts[ext($0)]++ }
    END {
      for (e in counts) print counts[e], e
    }
  ' | sort -nr | head -30
echo

echo "## Package Scripts"
if [ -f package.json ]; then
  sed -n '/"scripts"[[:space:]]*:/,/}[,]*$/p' package.json | head -80
fi
echo

echo "## Notes"
echo "- This snapshot is read-only."
echo "- Treat entry points and module roles as candidates until confirmed by source inspection."
