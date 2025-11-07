# FRIDAY Persona Instrumentation Plan

Author: Copilot Agent  
Created: Nov 7, 2025  
Status: Draft v1

## Purpose

Define a lightweight, privacy-respecting feedback loop to improve persona behavior without external
telemetry. Repo-local only.

## Feedback Loop (Operational)

1. Start task: ensure todo list created and one item in-progress.
2. After meaningful progress: append concise summary to `/memories/*` (≤ ~30 lines).
3. On completion: update todo to completed; record summary (actions, artifacts, PASS/FAIL) in
   memory.
4. Weekly: sample 3 sessions and score via `persona-evals.md`.
5. Monthly: aggregate patterns; adjust `persona-modes.md` or guardrails if needed.

## Session Tagging (Manual, Lightweight)

Record in memory summary:

- mode_used: concise | code-edit | planning | review | support
- task_type: feature | bug | docs | review | ops
- outcome: pass | fail | partial
- quality: build=PASS/FAIL, lint=PASS/FAIL, tests=PASS/FAIL
- notes: short free-text

## Memory Update Template

```
# [Task Name] — Summary (YYYY-MM-DD)
Context: one-liner
Actions: bullets (created/edited files)
Results: Build: PASS | Lint: PASS | Tests: PASS (or N/A)
Mode: code-edit | planning | ...  Outcome: pass
Links: paths to docs/patches
Next: immediate follow-ups (if any)
```

## Optional Local Log (Disabled by Default)

- If team wants a rollup, create `/memories/logs/persona-telemetry-YYYY-MM.md` with daily
  append-only entries.
- Do NOT store secrets or PII. Keep per-entry ≤10 lines.

## Privacy & Scope

- No external calls, analytics, or remote storage.
- All instrumentation lives in-repo under `/memories/`.

## Success Signals

- Clear weekly deltas captured.
- Reduced rework (fewer follow-up fixes after code edits).
- Higher average rubric scores (≥4.0) without increasing verbosity.

---

Version: 1.0 (Initial instrumentation)
