# Memory Protection System - Quick Reference

**Created:** November 7, 2025  
**Problem:** AI tidak load memory → ubah kode yang seharusnya dipertahankan  
**Solution:** Multi-layer protection dengan enforcement scripts

---

## 🚨 CRITICAL: Start of Every Session

**BEFORE doing ANY work, run:**

```bash
bash .github/scripts/memory-checkpoint.sh
```

**This will:**

- ✅ Show you WHAT files you MUST read
- ✅ Display recent memory updates
- ✅ List protected files (cannot modify)
- ✅ Create verification checkpoint
- ✅ Prevent accidental code breakage

**Example output:**

```
✅ MUST READ: .github/memory/INDEX.md
✅ MUST READ: .github/memory/current-state.md
🔒 Protected files: 6 files locked
📌 Current Project State: [summary]
🕐 Recent updates: [files modified last 7 days]
```

---

## 🔒 Protected Files System

**Files in `.github/.critical-files-lock` CANNOT be modified without approval.**

### Check Protection Status

```bash
bash .github/scripts/protect-critical-files.sh
```

**If protected file modified:**

```
❌ CRITICAL FILES PROTECTION: CHANGES BLOCKED

The following protected files have been modified:
  - .github/copilot-instructions.md

🔧 To proceed:
   1. Review changes carefully
   2. Explain WHY modification is needed
   3. Get user approval
   4. OR revert: git checkout -- <file>
```

### Default Protected Files

```
.github/copilot-instructions.md        # AI behavior config
.github/instructions/memory.instructions.md  # Memory protocol
.github/instructions/persona-guardrails.md   # Safety rules
.github/scripts/template-sterilization-check.sh  # Quality gate
customize.sh                            # Setup automation
.github/memory/INDEX.md                # Memory structure
```

### Add Your Protected Files

Edit `.github/.critical-files-lock`:

```bash
# Add files that must not be changed
src/core/critical-module.js
src/config/production.config.js
tests/critical-test.js
```

---

## 📋 Memory Protocol (Mandatory)

### Start of Session

1. **Run checkpoint script** (see above)
2. **Read displayed files** in order:
   - `.github/memory/INDEX.md`
   - `.github/memory/current-state.md`
   - Recent files in `implementations/`, `decisions/`, `issues/`
3. **Verify memory loaded**: Check `.github/.memory-checkpoint` created
4. **Note protected files**: Do not modify without approval

### During Work

- After significant progress: Update memory (< 30 lines)
- Format: Context → Change → Rationale → Next Steps
- **Never** modify files in `.critical-files-lock`
- Re-run checkpoint if you lose context

### End of Session

- Summarize work in memory (implementation/decision/issue file)
- Update `current-state.md` if project status changed
- Commit memory changes

---

## 🛠️ Commands Reference

```bash
# Memory checkpoint (START OF EVERY SESSION)
bash .github/scripts/memory-checkpoint.sh

# Check protected files status
bash .github/scripts/protect-critical-files.sh

# View what memory was loaded
cat .github/.memory-checkpoint

# See protected files list
cat .github/.critical-files-lock

# Add file to protection
echo "path/to/critical-file.js" >> .github/.critical-files-lock

# View recent memory updates
find .github/memory -type f -name "*.md" -mtime -7

# Search memory
grep -r "keyword" .github/memory/
```

---

## ❌ Common Mistakes (AVOID)

### ❌ Starting work without running checkpoint

**WRONG:**

```
User: "Add authentication feature"
AI: *immediately starts coding*
```

**CORRECT:**

```
User: "Add authentication feature"
AI: "Let me first load project memory..."
     *runs bash .github/scripts/memory-checkpoint.sh*
     *reads INDEX.md, current-state.md*
     "I see the project uses JWT for auth. Proceeding..."
```

### ❌ Modifying protected files without approval

**WRONG:**

```
AI: *edits .github/copilot-instructions.md*
```

**CORRECT:**

```
AI: "I notice .github/copilot-instructions.md needs updating.
     This file is protected. The change I propose is:
     [explain change and reason]
     May I proceed with this modification?"
```

### ❌ Not updating memory after work

**WRONG:**

```
AI: *implements feature*
     *session ends, no memory update*
Next session: AI has no idea what was done
```

**CORRECT:**

```
AI: *implements feature*
     *creates .github/memory/implementations/auth-feature-nov7-2025.md*
     *updates current-state.md*
```

---

## 🎯 Success Criteria

Memory protection working correctly when:

- ✅ Checkpoint script runs at start of EVERY session
- ✅ AI reads required memory files BEFORE coding
- ✅ Protected files trigger warning if modified
- ✅ Memory gets updated after significant work
- ✅ No accidental breakage of working code

---

## 🆘 Troubleshooting

### "Memory checkpoint failed"

```bash
# Check memory directory exists
ls -la .github/memory/

# Recreate if missing
mkdir -p .github/memory/{implementations,decisions,issues,archive}
```

### "Protected files script fails"

```bash
# Ensure Git repository
git status

# Check lock file exists
cat .github/.critical-files-lock
```

### "Context lost mid-session"

```bash
# Re-run checkpoint
bash .github/scripts/memory-checkpoint.sh

# Read recent memory
cat .github/memory/current-state.md
```

### "Need to modify protected file"

1. Explain WHY modification needed
2. Show WHAT will change
3. Wait for explicit user approval
4. Document reason in commit message

---

## 📊 Metrics

Track effectiveness:

- **Memory Load Rate**: Did AI run checkpoint? (Target: 100%)
- **Protected File Violations**: Unauthorized changes (Target: 0)
- **Code Breakage Incidents**: Working code broken (Target: 0)
- **Memory Staleness**: Last update date (Target: < 7 days)

Check monthly and adjust protection list as needed.

---

## 🚀 Next Steps

**Immediate (Now):**

- ✅ Run `bash .github/scripts/memory-checkpoint.sh`
- ✅ Add project-specific files to `.critical-files-lock`
- ✅ Update `current-state.md` with actual project status

**Soon (This Week):**

- Consider Redis Agent Memory for semantic search (see `docs/POWERFUL_AI_MEMORY_SOLUTIONS.md`)
- Add pre-commit hook to run protection check automatically
- Create GitHub Action to verify memory checkpoint in CI

**Future (Optional):**

- Implement hybrid Git + Redis memory system
- Add automated memory summarization
- Build memory analytics dashboard

---

**Remember:** Memory protection is your insurance against accidental code breakage. Use it
religiously.
