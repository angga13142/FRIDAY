#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🗂️ FRIDAY Memory Lifecycle Management
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Purpose: Manage memory freshness, archival, and cleanup
# Usage: bash .github/scripts/memory-lifecycle.sh [action]
# Actions: check, archive, cleanup, stats
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set +e

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
MEMORY_DIR="$REPO_ROOT/.github/memory"

# Configuration (days)
STALE_THRESHOLD=30      # Files older than 30 days = stale
ARCHIVE_THRESHOLD=90    # Files older than 90 days = archivable
CLEANUP_THRESHOLD=180   # Archived files older than 180 days = cleanupable

ACTION="${1:-check}"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🗂️  FRIDAY Memory Lifecycle Management"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Stats function
show_stats() {
    echo "📊 Memory Statistics"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    # Count files by category
    IMPL_COUNT=$(find "$MEMORY_DIR/implementations" -type f -name "*.md" 2>/dev/null | wc -l)
    DEC_COUNT=$(find "$MEMORY_DIR/decisions" -type f -name "*.md" 2>/dev/null | wc -l)
    ISSUE_COUNT=$(find "$MEMORY_DIR/issues" -type f -name "*.md" 2>/dev/null | wc -l)
    ARCH_COUNT=$(find "$MEMORY_DIR/archive" -type f -name "*.md" 2>/dev/null | wc -l)
    
    echo "  📁 Active Memory:"
    echo "     Implementations: $IMPL_COUNT files"
    echo "     Decisions:       $DEC_COUNT files"
    echo "     Issues:          $ISSUE_COUNT files"
    echo "  📦 Archived:        $ARCH_COUNT files"
    echo ""
    
    # Find stale files
    STALE_COUNT=$(find "$MEMORY_DIR/implementations" "$MEMORY_DIR/decisions" "$MEMORY_DIR/issues" \
        -type f -name "*.md" -mtime +$STALE_THRESHOLD 2>/dev/null | wc -l)
    
    echo "  ⚠️  Stale files (>$STALE_THRESHOLD days): $STALE_COUNT"
    
    # Find very old files
    OLD_COUNT=$(find "$MEMORY_DIR/implementations" "$MEMORY_DIR/decisions" "$MEMORY_DIR/issues" \
        -type f -name "*.md" -mtime +$ARCHIVE_THRESHOLD 2>/dev/null | wc -l)
    
    echo "  📦 Archivable (>$ARCHIVE_THRESHOLD days): $OLD_COUNT"
    echo ""
}

# Check freshness
check_freshness() {
    echo "🔍 Checking Memory Freshness"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    # Check INDEX.md
    if [ -f "$MEMORY_DIR/INDEX.md" ]; then
        DAYS_OLD=$(( ($(date +%s) - $(stat -c %Y "$MEMORY_DIR/INDEX.md" 2>/dev/null || stat -f %m "$MEMORY_DIR/INDEX.md")) / 86400 ))
        if [ "$DAYS_OLD" -gt $STALE_THRESHOLD ]; then
            echo "  ⚠️  INDEX.md is $DAYS_OLD days old (stale)"
        else
            echo "  ✅ INDEX.md is fresh ($DAYS_OLD days old)"
        fi
    else
        echo "  ❌ INDEX.md missing"
    fi
    
    # Check current-state.md
    if [ -f "$MEMORY_DIR/current-state.md" ]; then
        DAYS_OLD=$(( ($(date +%s) - $(stat -c %Y "$MEMORY_DIR/current-state.md" 2>/dev/null || stat -f %m "$MEMORY_DIR/current-state.md")) / 86400 ))
        if [ "$DAYS_OLD" -gt 7 ]; then
            echo "  ⚠️  current-state.md is $DAYS_OLD days old (should update)"
        else
            echo "  ✅ current-state.md is fresh ($DAYS_OLD days old)"
        fi
    else
        echo "  ❌ current-state.md missing"
    fi
    
    echo ""
    
    # List stale files
    echo "📋 Stale Files (>$STALE_THRESHOLD days):"
    echo ""
    
    STALE_FILES=$(find "$MEMORY_DIR/implementations" "$MEMORY_DIR/decisions" "$MEMORY_DIR/issues" \
        -type f -name "*.md" -mtime +$STALE_THRESHOLD 2>/dev/null)
    
    if [ -z "$STALE_FILES" ]; then
        echo "  ✅ No stale files found"
    else
        echo "$STALE_FILES" | while read -r file; do
            DAYS_OLD=$(( ($(date +%s) - $(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file")) / 86400 ))
            REL_PATH=${file#$MEMORY_DIR/}
            echo "  ⚠️  $REL_PATH ($DAYS_OLD days old)"
        done
    fi
    
    echo ""
}

# Archive old files
archive_old() {
    echo "📦 Archiving Old Memory Files"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    ARCHIVED_COUNT=0
    
    # Find files older than threshold
    OLD_FILES=$(find "$MEMORY_DIR/implementations" "$MEMORY_DIR/decisions" "$MEMORY_DIR/issues" \
        -type f -name "*.md" -mtime +$ARCHIVE_THRESHOLD 2>/dev/null)
    
    if [ -z "$OLD_FILES" ]; then
        echo "  ℹ️  No files to archive (all < $ARCHIVE_THRESHOLD days old)"
        return
    fi
    
    echo "  Files to archive (>$ARCHIVE_THRESHOLD days):"
    echo ""
    
    echo "$OLD_FILES" | while read -r file; do
        if [ -f "$file" ]; then
            REL_PATH=${file#$MEMORY_DIR/}
            DAYS_OLD=$(( ($(date +%s) - $(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file")) / 86400 ))
            
            # Create archive subdirectory structure
            DIR_NAME=$(dirname "$REL_PATH")
            ARCHIVE_DIR="$MEMORY_DIR/archive/$DIR_NAME"
            mkdir -p "$ARCHIVE_DIR"
            
            # Move to archive
            BASENAME=$(basename "$file")
            ARCHIVE_PATH="$ARCHIVE_DIR/$BASENAME"
            
            mv "$file" "$ARCHIVE_PATH"
            echo "  📦 Archived: $REL_PATH → archive/$DIR_NAME/"
            ((ARCHIVED_COUNT++))
        fi
    done
    
    echo ""
    echo "  ✅ Archived $ARCHIVED_COUNT files"
    echo ""
}

# Cleanup very old archived files
cleanup_old() {
    echo "🗑️  Cleaning Up Very Old Archives"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    CLEANUP_COUNT=0
    
    # Find archived files older than cleanup threshold
    OLD_ARCHIVES=$(find "$MEMORY_DIR/archive" -type f -name "*.md" -mtime +$CLEANUP_THRESHOLD 2>/dev/null)
    
    if [ -z "$OLD_ARCHIVES" ]; then
        echo "  ℹ️  No files to cleanup (all archives < $CLEANUP_THRESHOLD days old)"
        return
    fi
    
    echo "  ⚠️  WARNING: The following files will be DELETED:"
    echo ""
    
    echo "$OLD_ARCHIVES" | while read -r file; do
        REL_PATH=${file#$MEMORY_DIR/}
        DAYS_OLD=$(( ($(date +%s) - $(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file")) / 86400 ))
        echo "     $REL_PATH ($DAYS_OLD days old)"
    done
    
    echo ""
    read -p "  ❓ Continue with deletion? (yes/no): " CONFIRM
    
    if [ "$CONFIRM" = "yes" ]; then
        echo "$OLD_ARCHIVES" | while read -r file; do
            rm -f "$file"
            ((CLEANUP_COUNT++))
        done
        echo ""
        echo "  ✅ Deleted $CLEANUP_COUNT files"
    else
        echo ""
        echo "  ℹ️  Cleanup cancelled"
    fi
    
    echo ""
}

# Main action handler
case $ACTION in
    stats)
        show_stats
        ;;
    check)
        check_freshness
        echo ""
        show_stats
        ;;
    archive)
        archive_old
        ;;
    cleanup)
        cleanup_old
        ;;
    *)
        echo "Usage: $0 [action]"
        echo ""
        echo "Actions:"
        echo "  check   - Check memory freshness (default)"
        echo "  stats   - Show memory statistics"
        echo "  archive - Archive files older than $ARCHIVE_THRESHOLD days"
        echo "  cleanup - Delete archived files older than $CLEANUP_THRESHOLD days"
        echo ""
        exit 1
        ;;
esac

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
