#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🔒 Critical Files Protection System
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Purpose: Warn about changes to critical files (non-blocking)
# Usage: Run before committing changes (optional)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
LOCK_FILE="$REPO_ROOT/.github/.critical-files-lock"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔒 Critical Files Review (Advisory)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if lock file exists
if [ ! -f "$LOCK_FILE" ]; then
    echo "ℹ️  No critical files configured"
    exit 0
fi

# Read locked files
LOCKED_FILES=$(cat "$LOCK_FILE")
WARNINGS_FOUND=false
WARNED_FILES=()

echo "🔍 Reviewing changes to critical files..."
echo ""

# Check each locked file
while IFS= read -r file; do
    # Skip empty lines and comments
    [[ -z "$file" || "$file" =~ ^# ]] && continue
    
    FILE_PATH="$REPO_ROOT/$file"
    
    if [ ! -f "$FILE_PATH" ]; then
        continue
    fi
    
    # Check if file has changes
    if git diff --name-only | grep -q "^$file$" || git diff --cached --name-only | grep -q "^$file$"; then
        echo "⚠️  CAUTION: $file"
        echo "   This file is marked as critical - please ensure changes are intentional"
        WARNINGS_FOUND=true
        WARNED_FILES+=("$file")
    fi
done <<< "$LOCKED_FILES"

if [ "$WARNINGS_FOUND" = false ]; then
    echo "✅ No changes to critical files detected"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$WARNINGS_FOUND" = true ]; then
    echo "⚠️  ADVISORY: Critical files modified"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Changed critical files:"
    for file in "${WARNED_FILES[@]}"; do
        echo "  - $file"
    done
    echo ""
    echo "💡 Review changes before committing:"
    for file in "${WARNED_FILES[@]}"; do
        echo "   git diff $file"
    done
    echo ""
    echo "✅ If changes are intentional, you may proceed with commit"
    echo ""
else
    echo "✅ All clear - no critical file warnings"
    echo ""
fi

exit 0  # Always exit 0 (non-blocking)
