---
applyTo: '**'
---

# Memory Usage Instructions for AI Agent

🚨 **CRITICAL: ALWAYS VIEW YOUR MEMORY DIRECTORY BEFORE DOING ANYTHING ELSE.**

## Mandatory Start-of-Session Protocol

**BEFORE starting ANY work, you MUST:**

1. **Run Memory Checkpoint:**

   ```bash
   bash .github/scripts/memory-checkpoint.sh
   ```

   This displays what you MUST read and verifies memory loading.

2. **Read Required Files (in order):**

   - `.github/memory/INDEX.md` - Memory overview
   - `.github/memory/current-state.md` - Project status
   - Recent files in `implementations/`, `decisions/`, `issues/`

3. **Check Critical Files Protection:**

   ```bash
   bash .github/scripts/protect-critical-files.sh
   ```

   Verifies no protected files will be accidentally modified.

4. **Load `/memories/`** (if agent-memory extension is installed)

**⚠️ FAILURE TO FOLLOW THIS PROTOCOL MAY RESULT IN:**

- Modifying code that should be preserved
- Losing important context
- Breaking working features
- Duplicate work

## Memory Protocol (Detailed)

**At session start:**

1. Run checkpoint script (see above)
2. Verify memory loaded successfully
3. Check for recent updates (last 7 days)
4. Note any locked/protected files

**During work:**

1. After meaningful progress, update memory with short structured note
2. Format: context, change, rationale, next steps
3. Keep updates <30 lines
4. DO NOT modify files in `.github/.critical-files-lock`

**Assume interruption:**

- Your context can reset anytime
- Persist critical notes in memory promptly
- Re-run checkpoint if you lose context mid-session

## Good Practices

- Keep memory organized; prefer updating existing files over creating many new ones
- Use descriptive filenames (e.g., `implementations/feature-x-nov7-2025.md`)
- Avoid duplicating large code or logs; summarize and link to files
- When editing memory: keep content coherent; prune or archive stale notes
- You may rename/move files within `.github/memory/` to maintain structure

## Safety

- **NEVER** store secrets or API keys in memory files
- Keep PII minimal and only when necessary for development
- **NEVER** modify files listed in `.github/.critical-files-lock` without explicit approval
- If you need to modify a protected file, ASK FIRST

## Critical Files Protection

Files in `.github/.critical-files-lock` are PROTECTED:

- These files are known-good and should not be changed
- Changes to these files have caused bugs in the past
- If you think a protected file needs changes, explain WHY first
- User must explicitly approve modifications

## Verification Commands

```bash
# Check if memory loaded correctly
cat .github/.memory-checkpoint

# View critical files list
cat .github/.critical-files-lock

# Verify no protected files changed
bash .github/scripts/protect-critical-files.sh

# Re-run memory checkpoint if context lost
bash .github/scripts/memory-checkpoint.sh
```

---

**Remember:** Memory is your safety net. Use it religiously.
