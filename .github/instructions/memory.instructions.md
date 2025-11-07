---
applyTo: '**'
---

# Memory Usage Instructions for AI Agent

## Memory Protocol (Simplified)

**At session start (RECOMMENDED):**
1. Check `.github/memory/INDEX.md` and `current-state.md` for project context
2. Review recent files in `implementations/`, `decisions/`, `issues/` if relevant
3. Load `/memories/` if agent-memory extension is available

**During work:**
1. After meaningful progress, update memory with structured note (< 30 lines)
2. Format: context, change, rationale, next steps
3. Be mindful of files in `.github/.critical-files-lock` (advisory list)

**Assume interruption:**
- Context can reset anytime - persist critical notes promptly
- Re-check memory if you lose context mid-session

## Good Practices

- Keep memory organized; prefer updating existing files over creating many new ones
- Use descriptive filenames (e.g., `implementations/feature-x-nov8-2025.md`)
- Avoid duplicating large code or logs; summarize and link to files
- When editing memory: keep content coherent; prune or archive stale notes
- You may rename/move files within `.github/memory/` to maintain structure

## Safety

- **NEVER** store secrets or API keys in memory files
- Keep PII minimal and only when necessary for development
- Files in `.github/.critical-files-lock` are marked as sensitive - modify with caution
- If modifying a critical file, briefly explain WHY in commit message

## Optional Helper Scripts

```bash
# Memory checkpoint (shows what to read - OPTIONAL, not mandatory)
bash .github/scripts/memory-checkpoint.sh

# Critical files review (advisory warnings - OPTIONAL)
bash .github/scripts/protect-critical-files.sh

# View memory checkpoint status
cat .github/.memory-checkpoint
```

**Note:** These scripts are helpers, not blockers. Use them when helpful.
