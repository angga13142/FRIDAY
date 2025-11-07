#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
OUT_FILE="$REPO_ROOT/.github/copilot-instructions.md"
TMP_DIR="${TMPDIR:-/tmp}"
GEN_FILE="$TMP_DIR/copilot_instructions_generated_$$.md"

PROMPT=$(cat << 'PROMPT'
Analyze this codebase to generate or update `.github/copilot-instructions.md` for guiding AI coding agents.

Focus on discovering the essential knowledge that would help an AI agents be immediately productive in this codebase. Consider aspects like:
- The "big picture" architecture that requires reading multiple files to understand - major components, service boundaries, data flows, and the "why" behind structural decisions
- Critical developer workflows (builds, tests, debugging) especially commands that aren't obvious from file inspection alone
- Project-specific conventions and patterns that differ from common practices
- Integration points, external dependencies, and cross-component communication patterns

Source existing AI conventions from `**/{.github/copilot-instructions.md,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md}` (do one glob search).

Guidelines (read more at https://aka.ms/vscode-instructions-docs):
- If `.github/copilot-instructions.md` exists, merge intelligently - preserve valuable content while updating outdated sections
- Write concise, actionable instructions (~20-50 lines) using markdown structure
- Include specific examples from the codebase when describing patterns
- Avoid generic advice ("write tests", "handle errors") - focus on THIS project's specific approaches
- Document only discoverable patterns, not aspirational practices
- Reference key files/directories that exemplify important patterns

Update `.github/copilot-instructions.md` for the user, then ask for feedback on any unclear or incomplete sections to iterate.
PROMPT
)

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI not found. Please install GitHub CLI to enable auto-updates." >&2
  exit 0
fi

# Try to generate content using gh copilot
if gh extension list | grep -q "github/gh-copilot"; then
  gh copilot suggest -p "$PROMPT" > "$GEN_FILE" || {
    echo "gh copilot suggest failed; aborting this run." >&2
    exit 0
  }
else
  echo "gh copilot extension not installed; skipping generation." >&2
  exit 0
fi

STAMP=$(date -u +"%Y-%m-%d %H:%M UTC")
START_MARK="<!-- AUTO-GENERATED: COPILOT-ANALYSIS START -->"
END_MARK="<!-- AUTO-GENERATED: COPILOT-ANALYSIS END -->"

insert_block() {
  {
    echo ""
    echo "$START_MARK"
    echo "> Last updated: $STAMP"
    echo ""
    cat "$GEN_FILE"
    echo ""
    echo "$END_MARK"
  } >> "$OUT_FILE"
}

replace_block() {
  awk -v start="$START_MARK" -v end="$END_MARK" -v stamp="$STAMP" \
    'BEGIN{inblock=0}
     $0 ~ start {print start; print "> Last updated: " stamp; system("cat '"$GEN_FILE"' "); inblock=1; next}
     $0 ~ end && inblock==1 {print end; inblock=0; next}
     inblock==0 {print $0}' "$OUT_FILE" > "$OUT_FILE.tmp" && mv "$OUT_FILE.tmp" "$OUT_FILE"
}

if [ -f "$OUT_FILE" ]; then
  if grep -q "$START_MARK" "$OUT_FILE" && grep -q "$END_MARK" "$OUT_FILE"; then
    replace_block
  else
    insert_block
  fi
else
  mkdir -p "$REPO_ROOT/.github"
  echo "# Copilot Instructions" > "$OUT_FILE"
  insert_block
fi

echo "Auto-update complete: $OUT_FILE"
