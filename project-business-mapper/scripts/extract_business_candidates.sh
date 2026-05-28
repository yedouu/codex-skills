#!/usr/bin/env bash
set -e

SCOPE="${1:-.}"
OUTPUT_DIR="${2:-.business-understanding}"
OUTPUT_FILE="$OUTPUT_DIR/_candidates.md"

mkdir -p "$OUTPUT_DIR"

has_rg() {
  command -v rg >/dev/null 2>&1
}

list_files() {
  if has_rg; then
    rg --files "$SCOPE" \
      -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/target/**' -g '!**/dist/**' \
      -g '!**/build/**' -g '!**/vendor/**' -g '!**/.next/**' -g '!**/coverage/**' \
      -g '!**/logs/**' -g '!**/tmp/**' \
      -g '!*.png' -g '!*.jpg' -g '!*.jpeg' -g '!*.gif' -g '!*.webp' -g '!*.mp4' -g '!*.zip'
  else
    find "$SCOPE" -type f \
      ! -path '*/.git/*' ! -path '*/node_modules/*' ! -path '*/target/*' ! -path '*/dist/*' \
      ! -path '*/build/*' ! -path '*/vendor/*' ! -path '*/.next/*' ! -path '*/coverage/*' \
      ! -path '*/logs/*' ! -path '*/tmp/*'
  fi
}

search_terms() {
  title="$1"
  pattern="$2"
  echo
  echo "## $title"
  if has_rg; then
    rg -n -i --glob '!**/.git/**' --glob '!**/node_modules/**' --glob '!**/dist/**' --glob '!**/build/**' "$pattern" "$SCOPE" | head -n 80 || true
  else
    grep -RInE "$pattern" "$SCOPE" 2>/dev/null | grep -v '/node_modules/' | grep -v '/.git/' | head -n 80 || true
  fi
}

{
  echo "# Business Candidates"
  echo
  echo "Scope: $SCOPE"
  echo
  echo "This file contains candidates extracted from file names, directory names, and keywords. Do not treat these candidates as final conclusions. Codex must confirm them by reading source and context."

  echo
  echo "## Candidate Files by Path"
  list_files | grep -Ei 'user|admin|role|actor|order|task|job|session|conversation|message|payment|invoice|map|pose|robot|sensor|state|status|event|command|workflow|rule|policy|permission|approval|cancel|retry|callback|notification|memory|model|entity|schema|dto|controller|service|usecase|route|api' | head -n 200 || true

  search_terms "Role Candidates" 'role|actor|user|admin|owner|operator|customer|member|guest|robot|device|sensor|client|provider|consumer|upstream|downstream'
  search_terms "Object Candidates" 'entity|model|schema|dto|message|event|task|order|session|conversation|pose|map|particle|memory|invoice|payment|workflow|job'
  search_terms "State Candidates" 'state|status|pending|processing|running|active|inactive|completed|success|failed|cancelled|canceled|expired|timeout|approved|rejected|draft|published'
  search_terms "Flow Candidates" 'create|submit|send|receive|process|approve|reject|cancel|complete|finish|checkout|pay|callback|upload|review|schedule|dispatch|navigate|localize|reply'
  search_terms "Rule Keywords" 'must|should|required|forbidden|allow|deny|permission|policy|validate|guard|constraint|limit|threshold|quota|unique|duplicate|idempotent'
  search_terms "Edge Case Keywords" 'error|exception|fail|failed|timeout|expired|missing|null|undefined|invalid|conflict|retry|rollback|fallback|not found|unauthorized|forbidden|out of order'
  search_terms "API Path Candidates" 'GET |POST |PUT |PATCH |DELETE |router\.|route\(|endpoint|@Get|@Post|@Put|@Patch|@Delete|/api/'
  search_terms "Event / Command Candidates" 'event|emit|publish|subscribe|dispatch|command|handler|listener|queue|topic|callback'
} > "$OUTPUT_FILE"

echo "$OUTPUT_FILE"
