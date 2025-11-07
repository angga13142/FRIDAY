---
applyTo: '**'
---

# Memory Usage Instructions for AI Agent

IMPORTANT: ALWAYS VIEW YOUR MEMORY DIRECTORY BEFORE DOING ANYTHING ELSE.

Memory protocol:
1) At session start, check `.github/memory/INDEX.md`, `current-state.md`, and recent items in `implementations/`, `decisions/`, `issues/`. Also load `/memories/` (agent extension directory) if present.
2) Work normally, but after meaningful progress, update memory with a short, structured note (context, change, rationale, next steps). Keep updates <30 lines.
3) Assume interruption: your context can reset anytime. Persist critical notes in memory promptly.

Good practices:
- Keep memory organized; prefer updating existing files over creating many new ones.
- Use descriptive filenames (e.g., `implementations/feature-x-nov7-2025.md`).
- Avoid duplicating large code or logs; summarize and link to files.

When editing memory:
- Keep content coherent; prune or archive stale notes.
- You may rename/move files within `.github/memory/` to maintain structure.

Safety:
- Never store secrets or API keys in memory files.
- Keep PII minimal and only when necessary for development.
