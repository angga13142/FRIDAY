#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🧪 FRIDAY Memory Enforcement Test Suite
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Purpose: Validate that memory MUST be loaded before AI responds
# Usage: bash .github/scripts/test-memory-enforcement.sh
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Don't use set -e - we want to continue on failures
set +e

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
MEMORY_DIR="$REPO_ROOT/.github/memory"
TEST_RESULTS=0
TESTS_PASSED=0
TESTS_FAILED=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 FRIDAY Memory Enforcement Test Suite"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Helper functions
pass_test() {
    echo "  ✅ PASS: $1"
    ((TESTS_PASSED++))
}

fail_test() {
    echo "  ❌ FAIL: $1"
    ((TESTS_FAILED++))
    TEST_RESULTS=1
}

info() {
    echo "  ℹ️  INFO: $1"
}

# Test 1: Memory directory structure exists
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 1: Memory Directory Structure"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ -d "$MEMORY_DIR" ]; then
    pass_test "Memory directory exists"
    
    # Check subdirectories
    for dir in implementations decisions issues archive; do
        if [ -d "$MEMORY_DIR/$dir" ]; then
            pass_test "Subdirectory $dir exists"
        else
            fail_test "Missing subdirectory: $dir"
        fi
    done
else
    fail_test "Memory directory does not exist at $MEMORY_DIR"
fi
echo ""

# Test 2: Required memory files exist
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 2: Required Memory Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ -f "$MEMORY_DIR/INDEX.md" ]; then
    pass_test "INDEX.md exists"
    
    # Verify INDEX.md has minimum required content
    if grep -q "Memory Index" "$MEMORY_DIR/INDEX.md"; then
        pass_test "INDEX.md has proper header"
    else
        fail_test "INDEX.md missing proper header"
    fi
else
    fail_test "INDEX.md does not exist (CRITICAL)"
fi

if [ -f "$MEMORY_DIR/current-state.md" ]; then
    pass_test "current-state.md exists"
else
    info "current-state.md missing (will trigger warning)"
fi
echo ""

# Test 3: Copilot instructions have memory protocol
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 3: Copilot Instructions Enforcement"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
COPILOT_FILE="$REPO_ROOT/.github/copilot-instructions.md"

if [ -f "$COPILOT_FILE" ]; then
    pass_test "copilot-instructions.md exists"
    
    # Check for MANDATORY keyword
    if grep -q "MANDATORY MEMORY PROTOCOL" "$COPILOT_FILE"; then
        pass_test "Contains MANDATORY MEMORY PROTOCOL section"
    else
        fail_test "Missing MANDATORY MEMORY PROTOCOL section"
    fi
    
    # Check for enforcement steps
    if grep -q "BEFORE RESPONDING TO ANY USER REQUEST" "$COPILOT_FILE"; then
        pass_test "Has 'BEFORE RESPONDING' enforcement trigger"
    else
        fail_test "Missing enforcement trigger"
    fi
    
    # Check for INDEX.md loading
    if grep -q "Check & Load INDEX" "$COPILOT_FILE"; then
        pass_test "Enforces INDEX.md loading"
    else
        fail_test "Does not enforce INDEX.md loading"
    fi
    
    # Check for silent operation
    if grep -q "SILENT" "$COPILOT_FILE"; then
        pass_test "Specifies SILENT operation"
    else
        fail_test "Does not specify silent operation"
    fi
    
    # Check for context verification
    if grep -q "Context Verification" "$COPILOT_FILE"; then
        pass_test "Includes context verification step"
    else
        fail_test "Missing context verification"
    fi
    
else
    fail_test "copilot-instructions.md not found"
fi
echo ""

# Test 4: Memory instructions file
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 4: Memory Instructions"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
MEMORY_INST="$REPO_ROOT/.github/instructions/memory.instructions.md"

if [ -f "$MEMORY_INST" ]; then
    pass_test "memory.instructions.md exists"
    
    # Should NOT have overly strict language
    if grep -qi "MUST RUN" "$MEMORY_INST" || grep -qi "MANDATORY.*script" "$MEMORY_INST"; then
        fail_test "Contains overly strict script enforcement (bad)"
    else
        pass_test "Does not enforce external scripts (good)"
    fi
else
    fail_test "memory.instructions.md not found"
fi
echo ""

# Test 5: No leftover enforcement scripts
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 5: Clean State (No Leftover Files)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

LEFTOVER_FILES=(
    ".github/scripts/memory-checkpoint.sh"
    ".github/scripts/protect-critical-files.sh"
    ".github/.critical-files-lock"
    ".github/.memory-checkpoint"
)

CLEAN_STATE=true
for file in "${LEFTOVER_FILES[@]}"; do
    if [ -f "$REPO_ROOT/$file" ]; then
        fail_test "Leftover file found: $file"
        CLEAN_STATE=false
    fi
done

if [ "$CLEAN_STATE" = true ]; then
    pass_test "No leftover enforcement files"
fi
echo ""

# Test 6: Protocol ordering
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 6: Protocol Ordering"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Memory load must be step 0 (before anything else)
if grep -A 5 "Standard protocol:" "$COPILOT_FILE" | grep -q "0.*MEMORY LOAD"; then
    pass_test "Memory load is step 0 (first priority)"
else
    fail_test "Memory load is not step 0 in protocol"
fi
echo ""

# Test 7: Verify enforcement mechanism
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 7: Enforcement Mechanism Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check enforcement is built-in (not external script)
if ! grep -q "bash.*memory-checkpoint\|bash.*protect-critical" "$COPILOT_FILE"; then
    pass_test "No external enforcement script dependency (built-in)"
else
    fail_test "Still depends on external enforcement scripts"
fi

# Check for failure consequence
if grep -q "Failure to load memory" "$COPILOT_FILE"; then
    pass_test "Documents consequences of memory failure"
else
    fail_test "Does not document failure consequences"
fi
echo ""

# Test 8: Memory lifecycle management
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test 8: Memory Lifecycle Management"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

LIFECYCLE_SCRIPT="$REPO_ROOT/.github/scripts/memory-lifecycle.sh"

if [ -f "$LIFECYCLE_SCRIPT" ]; then
    pass_test "memory-lifecycle.sh exists"
    
    if [ -x "$LIFECYCLE_SCRIPT" ]; then
        pass_test "memory-lifecycle.sh is executable"
    else
        fail_test "memory-lifecycle.sh is not executable"
    fi
    
    # Test script runs without error
    if bash "$LIFECYCLE_SCRIPT" check > /dev/null 2>&1; then
        pass_test "memory-lifecycle.sh check command works"
    else
        fail_test "memory-lifecycle.sh check command failed"
    fi
    
    # Check for memory update protocol in copilot-instructions
    if grep -q "Memory Update Protocol" "$COPILOT_FILE"; then
        pass_test "Memory Update Protocol documented"
    else
        fail_test "Memory Update Protocol not documented"
    fi
    
    # Check for memory lifecycle documentation
    if grep -q "Memory Lifecycle" "$COPILOT_FILE"; then
        pass_test "Memory Lifecycle rules documented"
    else
        fail_test "Memory Lifecycle rules not documented"
    fi
else
    fail_test "memory-lifecycle.sh not found"
fi
echo ""

# Final Results
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 TEST RESULTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Tests Passed: $TESTS_PASSED"
echo "  Tests Failed: $TESTS_FAILED"
echo ""

if [ $TEST_RESULTS -eq 0 ]; then
    echo "✅ ALL TESTS PASSED"
    echo ""
    echo "Memory enforcement is properly configured:"
    echo "  ✓ MANDATORY (cannot be skipped)"
    echo "  ✓ SILENT (no verbose output)"
    echo "  ✓ BUILT-IN (no external scripts)"
    echo "  ✓ VERIFIED (has context check)"
    echo "  ✓ CLEAN (no leftover files)"
    echo ""
else
    echo "❌ SOME TESTS FAILED"
    echo ""
    echo "Please fix the failing tests before proceeding."
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit $TEST_RESULTS
