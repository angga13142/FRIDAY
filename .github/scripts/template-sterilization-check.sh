#!/usr/bin/env bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FRIDAY Template Sterilization Check
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Ensures template contains ONLY generic files
# Run before releasing template updates
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -euo pipefail

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$REPO_ROOT"

FAIL_COUNT=0
WARN_COUNT=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧹 FRIDAY Template Sterilization Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 1: Project-specific directories should NOT exist
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "📁 Check 1: Project-specific directories"
echo "─────────────────────────────────────────────────────"

FORBIDDEN_DIRS=(
  "src"
  "public"
  "tests"
  "test"
  "lib"
  "dist"
  "build"
  "out"
  ".next"
  ".nuxt"
  "node_modules"
  "venv"
  "__pycache__"
)

for dir in "${FORBIDDEN_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    echo "❌ FAIL: Found project directory: $dir"
    ((FAIL_COUNT++))
  fi
done

if [ $FAIL_COUNT -eq 0 ]; then
  echo "✅ PASS: No project-specific directories found"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 2: Project-specific config files should NOT exist
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "⚙️  Check 2: Project-specific config files"
echo "─────────────────────────────────────────────────────"

FORBIDDEN_CONFIGS=(
  "package.json"
  "package-lock.json"
  "yarn.lock"
  "pnpm-lock.yaml"
  "astro.config.mjs"
  "astro.config.js"
  "next.config.js"
  "next.config.mjs"
  "vite.config.js"
  "vite.config.ts"
  "vitest.config.js"
  "tailwind.config.js"
  "tailwind.config.cjs"
  "postcss.config.js"
  "postcss.config.cjs"
  "tsconfig.json"
  "jsconfig.json"
  "nuxt.config.js"
  "nuxt.config.ts"
  "svelte.config.js"
  "webpack.config.js"
  "rollup.config.js"
  "requirements.txt"
  "pyproject.toml"
  "Pipfile"
  "go.mod"
  "Cargo.toml"
)

for config in "${FORBIDDEN_CONFIGS[@]}"; do
  if [ -f "$config" ]; then
    echo "❌ FAIL: Found project config: $config"
    ((FAIL_COUNT++))
  fi
done

if [ $FAIL_COUNT -eq 0 ]; then
  echo "✅ PASS: No project-specific configs found"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 3: All placeholders must still be placeholders
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "🏷️  Check 3: Placeholder integrity"
echo "─────────────────────────────────────────────────────"

PLACEHOLDERS=(
  "{{PROJECT_NAME}}"
  "{{PROJECT_TYPE}}"
  "{{TECH_STACK}}"
  "{{PRIMARY_LANGUAGE}}"
  "{{FRAMEWORK}}"
)

PLACEHOLDER_FILES=(
  ".github/copilot-instructions.md"
  ".github/memory/INDEX.md"
  "README.md"
)

PLACEHOLDER_FAIL=0
for file in "${PLACEHOLDER_FILES[@]}"; do
  if [ -f "$file" ]; then
    for placeholder in "${PLACEHOLDERS[@]}"; do
      if ! grep -q "$placeholder" "$file" 2>/dev/null; then
        echo "⚠️  WARN: Missing placeholder $placeholder in $file"
        ((WARN_COUNT++))
        PLACEHOLDER_FAIL=1
      fi
    done
  fi
done

if [ $PLACEHOLDER_FAIL -eq 0 ]; then
  echo "✅ PASS: All placeholders intact"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 4: No hardcoded project-specific content
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "🔍 Check 4: Hardcoded project content"
echo "─────────────────────────────────────────────────────"

# Search for common project-specific patterns
PATTERNS=(
  "Portfolio"
  "CRM Dashboard"
  "chatbot"
  "WhatsApp"
  "Next.js.*Dashboard"
  "Astro.*Portfolio"
)

CONTENT_FAIL=0
for pattern in "${PATTERNS[@]}"; do
  # Exclude memory/ and docs/ folders (allowed to have examples)
  if git grep -i "$pattern" -- ':!.github/memory/' ':!docs/' ':!CHANGELOG.md' ':!.github/scripts/template-sterilization-check.sh' >/dev/null 2>&1; then
    echo "⚠️  WARN: Found potential hardcoded content: '$pattern'"
    git grep -n -i "$pattern" -- ':!.github/memory/' ':!docs/' ':!CHANGELOG.md' ':!.github/scripts/template-sterilization-check.sh' | head -3
    ((WARN_COUNT++))
    CONTENT_FAIL=1
  fi
done

if [ $CONTENT_FAIL -eq 0 ]; then
  echo "✅ PASS: No hardcoded project content detected"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 5: Required template files must exist
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "📋 Check 5: Required template files"
echo "─────────────────────────────────────────────────────"

REQUIRED_FILES=(
  ".github/copilot-instructions.md"
  ".github/instructions/persona-modes.md"
  ".github/instructions/persona-guardrails.md"
  ".github/instructions/persona-fewshots.md"
  ".github/instructions/tooling-matrix.md"
  ".github/instructions/persona-evals.md"
  ".github/instructions/persona-instrumentation.md"
  ".github/instructions/architecture.md"
  ".github/instructions/development-workflow.md"
  ".github/instructions/patterns.md"
  ".github/instructions/integration.md"
  ".github/instructions/common-tasks.md"
  ".github/instructions/gotchas.md"
  ".github/instructions/file-reference.md"
  ".github/instructions/recent-features.md"
  ".github/instructions/friday-workflow.md"
  ".github/memory/INDEX.md"
  ".github/scripts/persona-validate.js"
  ".github/scripts/auto-update-copilot-instructions.sh"
  "customize.sh"
  "README.md"
  "CHANGELOG.md"
  "LICENSE"
  ".gitignore"
  ".editorconfig"
)

MISSING_COUNT=0
for file in "${REQUIRED_FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ FAIL: Missing required file: $file"
    ((FAIL_COUNT++))
    ((MISSING_COUNT++))
  fi
done

if [ $MISSING_COUNT -eq 0 ]; then
  echo "✅ PASS: All required template files exist"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 6: .gitignore properly configured
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "🚫 Check 6: .gitignore configuration"
echo "─────────────────────────────────────────────────────"

GITIGNORE_PATTERNS=(
  "src/"
  "public/"
  "tests/"
  "package.json"
  "*.config.mjs"
  "*.config.cjs"
)

GITIGNORE_FAIL=0
for pattern in "${GITIGNORE_PATTERNS[@]}"; do
  if ! grep -q "^$pattern" .gitignore 2>/dev/null; then
    echo "❌ FAIL: .gitignore missing pattern: $pattern"
    ((FAIL_COUNT++))
    GITIGNORE_FAIL=1
  fi
done

if [ $GITIGNORE_FAIL -eq 0 ]; then
  echo "✅ PASS: .gitignore properly configured"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 7: No secrets or sensitive data
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "🔐 Check 7: Secrets and sensitive data"
echo "─────────────────────────────────────────────────────"

SECRET_PATTERNS=(
  "API_KEY"
  "SECRET_KEY"
  "PASSWORD"
  "PRIVATE_KEY"
  "xnd_production"
  "sk-.*"  # OpenAI keys
  "ghp_.*" # GitHub tokens
)

SECRETS_FAIL=0
for pattern in "${SECRET_PATTERNS[@]}"; do
  if git grep -i "$pattern" -- ':!.env.example' ':!.github/scripts/' >/dev/null 2>&1; then
    echo "⚠️  WARN: Found potential secret pattern: '$pattern'"
    git grep -n -i "$pattern" -- ':!.env.example' ':!.github/scripts/' | head -3
    ((WARN_COUNT++))
    SECRETS_FAIL=1
  fi
done

if [ $SECRETS_FAIL -eq 0 ]; then
  echo "✅ PASS: No secrets detected"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CHECK 8: Git history clean (no large files)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "📜 Check 8: Git history cleanliness"
echo "─────────────────────────────────────────────────────"

# Check for files > 1MB in git history
LARGE_FILES=$(git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  awk '/^blob/ {if($3 > 1048576) print $3/1048576 " MB - " $4}' | \
  head -5)

if [ -n "$LARGE_FILES" ]; then
  echo "⚠️  WARN: Found large files in git history:"
  echo "$LARGE_FILES"
  ((WARN_COUNT++))
else
  echo "✅ PASS: No large files in git history"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FINAL REPORT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 STERILIZATION CHECK SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "❌ Failures:  $FAIL_COUNT"
echo "⚠️  Warnings:  $WARN_COUNT"
echo ""

if [ $FAIL_COUNT -eq 0 ] && [ $WARN_COUNT -eq 0 ]; then
  echo "✅ TEMPLATE IS STERILE - Safe for release!"
  echo ""
  echo "🎉 All checks passed. Template contains only generic files."
  echo ""
  exit 0
elif [ $FAIL_COUNT -eq 0 ]; then
  echo "⚠️  TEMPLATE HAS WARNINGS - Review recommended"
  echo ""
  echo "No critical issues, but please review warnings above."
  echo "Warnings are informational and may be acceptable."
  echo ""
  exit 0
else
  echo "❌ TEMPLATE IS NOT STERILE - DO NOT RELEASE!"
  echo ""
  echo "Critical issues found. Fix failures before releasing template."
  echo "Run this script again after fixes."
  echo ""
  exit 1
fi
