#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🧠 FRIDAY Memory Checkpoint System
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Purpose: Ensure AI loads memory BEFORE starting work
# Usage: Run at start of every session
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
MEMORY_DIR="$REPO_ROOT/.github/memory"
CHECKPOINT_FILE="$REPO_ROOT/.github/.memory-checkpoint"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧠 FRIDAY Memory Checkpoint System"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if memory directory exists
if [ ! -d "$MEMORY_DIR" ]; then
    echo "❌ ERROR: Memory directory not found at $MEMORY_DIR"
    echo "   Initialize memory first: mkdir -p .github/memory"
    exit 1
fi

# Display mandatory reading checklist
echo "📚 MANDATORY MEMORY READING CHECKLIST:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

REQUIRED_FILES=(
    "INDEX.md"
    "current-state.md"
)

OPTIONAL_DIRS=(
    "implementations"
    "decisions"
    "issues"
)

ALL_READ=true

# Check required files
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$MEMORY_DIR/$file" ]; then
        echo "✅ MUST READ: .github/memory/$file"
        echo "   Preview:"
        head -n 3 "$MEMORY_DIR/$file" | sed 's/^/   │ /'
        echo ""
    else
        echo "⚠️  MISSING: .github/memory/$file"
        ALL_READ=false
    fi
done

# Check optional directories
for dir in "${OPTIONAL_DIRS[@]}"; do
    if [ -d "$MEMORY_DIR/$dir" ]; then
        FILE_COUNT=$(find "$MEMORY_DIR/$dir" -type f -name "*.md" | wc -l)
        if [ "$FILE_COUNT" -gt 0 ]; then
            echo "📂 CHECK: .github/memory/$dir/ ($FILE_COUNT files)"
            echo "   Recent files:"
            find "$MEMORY_DIR/$dir" -type f -name "*.md" -exec ls -t {} + | head -n 3 | sed 's|.*/||' | sed 's/^/   │ - /'
            echo ""
        fi
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 CRITICAL CODE PROTECTION STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for critical files lock
LOCK_FILE="$REPO_ROOT/.github/.critical-files-lock"
if [ -f "$LOCK_FILE" ]; then
    echo "🔒 Protected files (DO NOT MODIFY without explicit approval):"
    cat "$LOCK_FILE" | sed 's/^/   │ /'
    echo ""
else
    echo "ℹ️  No critical files locked yet"
    echo "   Create .github/.critical-files-lock to protect important files"
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 SESSION SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Generate quick context summary
if [ -f "$MEMORY_DIR/current-state.md" ]; then
    echo "📌 Current Project State:"
    grep -E "^\*\*.*\*\*|^##" "$MEMORY_DIR/current-state.md" | head -n 10 | sed 's/^/   /'
    echo ""
fi

# Recent activity
echo "🕐 Recent Memory Updates:"
find "$MEMORY_DIR" -type f -name "*.md" -mtime -7 -exec ls -lt {} + | head -n 5 | awk '{print "   " $9 " (modified " $6 " " $7 ")"}' || echo "   No recent updates"
echo ""

# Save checkpoint
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
cat > "$CHECKPOINT_FILE" << EOF
Memory checkpoint created at: $TIMESTAMP
Session ID: session_$(date +%s)
Memory files read: ${#REQUIRED_FILES[@]} required
Last checkpoint: $TIMESTAMP
EOF

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ MEMORY CHECKPOINT COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "⚠️  REMINDER FOR AI AGENT:"
echo "   1. You MUST have read the files shown above"
echo "   2. Do NOT modify locked files without explicit approval"
echo "   3. Update memory after significant changes"
echo "   4. Re-run this checkpoint if context is lost"
echo ""
echo "🤖 FRIDAY: Context loaded. Ready to assist with full memory awareness."
echo ""
