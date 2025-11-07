#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🔒 Critical Files Protection System
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Purpose: Detect unauthorized changes to critical files
# Usage: Run before committing changes
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
LOCK_FILE="$REPO_ROOT/.github/.critical-files-lock"
HASH_FILE="$REPO_ROOT/.github/.critical-files-hash"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔒 Critical Files Protection Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if lock file exists
if [ ! -f "$LOCK_FILE" ]; then
    echo "ℹ️  No critical files configured"
    echo "   Create .github/.critical-files-lock to enable protection"
    exit 0
fi

# Read locked files
LOCKED_FILES=$(cat "$LOCK_FILE")
CHANGES_DETECTED=false
CHANGED_FILES=()

echo "🔍 Checking protected files for unauthorized changes..."
echo ""

# Check each locked file
while IFS= read -r file; do
    # Skip empty lines and comments
    [[ -z "$file" || "$file" =~ ^# ]] && continue
    
    FILE_PATH="$REPO_ROOT/$file"
    
    if [ ! -f "$FILE_PATH" ]; then
        echo "⚠️  Protected file missing: $file"
        continue
    fi
    
    # Check if file has uncommitted changes
    if git diff --name-only | grep -q "^$file$"; then
        echo "🚨 UNAUTHORIZED CHANGE DETECTED: $file"
        echo "   This file is protected and requires explicit approval to modify"
        CHANGES_DETECTED=true
        CHANGED_FILES+=("$file")
    elif git diff --cached --name-only | grep -q "^$file$"; then
        echo "🚨 STAGED CHANGE DETECTED: $file"
        echo "   This file is protected and requires explicit approval to commit"
        CHANGES_DETECTED=true
        CHANGED_FILES+=("$file")
    else
        echo "✅ OK: $file"
    fi
done <<< "$LOCKED_FILES"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$CHANGES_DETECTED" = true ]; then
    echo "❌ CRITICAL FILES PROTECTION: CHANGES BLOCKED"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "The following protected files have been modified:"
    for file in "${CHANGED_FILES[@]}"; do
        echo "  - $file"
    done
    echo ""
    echo "🔧 To proceed, you must:"
    echo "   1. Review the changes carefully"
    echo "   2. Understand WHY the file is protected"
    echo "   3. Get explicit approval OR"
    echo "   4. Revert the changes: git checkout -- <file>"
    echo ""
    echo "💡 To see what changed:"
    for file in "${CHANGED_FILES[@]}"; do
        echo "   git diff $file"
    done
    echo ""
    exit 1
else
    echo "✅ CRITICAL FILES PROTECTION: ALL CLEAR"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "No unauthorized changes to protected files detected."
    echo ""
    exit 0
fi
