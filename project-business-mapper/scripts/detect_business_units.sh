#!/usr/bin/env bash
set -e

SCOPE="${1:-.}"

echo "# BUSINESS UNIT CANDIDATES"
echo
echo "This is heuristic detection only. Candidates are not final business conclusions."
echo "Scope: $SCOPE"
echo
echo "| File | Candidate Type | Importance | Reason | Confidence |"
echo "| --- | --- | --- | --- | --- |"

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

emit() {
  file="$1"
  type="$2"
  importance="$3"
  reason="$4"
  confidence="$5"
  printf '| `%s` | %s | %s | %s | %s |\n' "$file" "$type" "$importance" "$reason" "$confidence"
}

while IFS= read -r file; do
  lower="$(printf '%s' "$file" | tr '[:upper:]' '[:lower:]')"

  case "$lower" in
    *readme*|*docs/*|*prd*|*requirement*|*spec*)
      emit "$file" "business_goal" "A/B" "Documentation often states project purpose, users, and scenarios." "medium"
      ;;
  esac

  case "$lower" in
    */api/*|*/apis/*|*/route/*|*/routes/*|*/controller/*|*/controllers/*|*controller.*|*route.*|*/handler/*|*/handlers/*)
      emit "$file" "api_entry" "A/B" "API, route, controller, or handler files often expose business entry points." "high"
      ;;
  esac

  case "$lower" in
    */service/*|*/services/*|*/usecase/*|*/usecases/*|*/workflow/*|*/workflows/*|*/job/*|*/jobs/*|*service.*|*usecase.*|*workflow.*)
      emit "$file" "service / workflow / core_flow" "A/B" "Service, usecase, workflow, and job files often contain business processes." "high"
      ;;
  esac

  case "$lower" in
    */model/*|*/models/*|*/entity/*|*/entities/*|*/schema/*|*/schemas/*|*/dto/*|*/dtos/*|*/domain/*|*model.*|*entity.*|*schema.*|*dto.*)
      emit "$file" "domain_object / model" "A/B" "Model, entity, schema, DTO, or domain files often define business objects." "high"
      ;;
  esac

  case "$lower" in
    */state/*|*/states/*|*/status/*|*/statuses/*|*/enum/*|*/enums/*|*state.*|*status.*|*enum.*|*transition*)
      emit "$file" "state_machine" "A" "State, status, enum, or transition files often define sensitive business state." "high"
      ;;
  esac

  case "$lower" in
    */event/*|*/events/*|*event.*)
      emit "$file" "event" "A/B" "Event files may represent business lifecycle changes." "medium"
      ;;
  esac

  case "$lower" in
    */command/*|*/commands/*|*command.*|*/action/*|*/actions/*)
      emit "$file" "command" "B" "Command or action files may represent user or system operations." "medium"
      ;;
  esac

  case "$lower" in
    */config/*|*/configs/*|*config.*|*settings*)
      emit "$file" "config_affecting_business" "B/C" "Config may affect permissions, thresholds, feature behavior, or integrations." "low"
      ;;
  esac

  case "$lower" in
    */util/*|*/utils/*|*/lib/*|*/common/*|*/shared/*|*/infra/*|*/infrastructure/*)
      emit "$file" "technical_glue" "C/D" "Utility, shared, or infrastructure files are usually implementation support unless business rules appear inside." "medium"
      ;;
  esac
done < <(list_files | head -n 1200)

echo
echo "## Keyword Hints"
if has_rg; then
  rg -n -i --glob '!**/.git/**' --glob '!**/node_modules/**' --glob '!**/dist/**' --glob '!**/build/**' \
    'role|actor|user|admin|order|task|session|conversation|payment|status|state|transition|permission|policy|rule|validate|retry|callback|event|workflow|cancel|approve|reject|timeout|expired|failed|success|error|exception' "$SCOPE" \
    | head -n 120 || true
else
  grep -RInE 'role|actor|user|admin|order|task|session|conversation|payment|status|state|transition|permission|policy|rule|validate|retry|callback|event|workflow|cancel|approve|reject|timeout|expired|failed|success|error|exception' "$SCOPE" 2>/dev/null \
    | grep -v '/node_modules/' | grep -v '/.git/' | head -n 120 || true
fi
