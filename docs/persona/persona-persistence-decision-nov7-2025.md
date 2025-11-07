# Persona Persistence Decision — FRIDAY (Nov 7, 2025)

Question: “Pilihan mana yang membuat persona bertahan permanen?”

## Short Answer

- Choose Option A first: create foundational instruction files `persona-modes.md` +
  `persona-guardrails.md` under `.github/instructions/` and reference them from the main
  `copilot-instructions.md`.
- This establishes a single source of truth used by the assistant and ensures durable behavior
  across sessions/repos because the rules live in-versioned repo config.

## Why Option A Is "Permanent"

- Modes and guardrails define core behavior (tone, verbosity, action bias, safety) — the bedrock of
  persona.
- Referenced directly by the primary config (`.github/copilot-instructions.md`), they are loaded and
  followed every session.
- Few-shots (Option B) guide style but are not authoritative if they conflict with modes/guardrails.
- Tooling matrix and evals (Option C) improve consistency and measurement but don’t themselves
  enforce behavior.

## Persistence Mechanism

1. Repo-level, versioned instructions under `.github/instructions/` act as canonical policy.
2. Main index (`.github/copilot-instructions.md`) links to them — reducing drift and duplication.
3. Memory protocol complements (not replaces) repo rules: update `/memories/` +
   `.github/memory/current-state.md` after changes for continuity.

## Minimal Implementation Steps (PR-ready)

1. Add: `.github/instructions/persona-modes.md` (response modes: concise, explanatory, code-edit,
   review, planning, support)
2. Add: `.github/instructions/persona-guardrails.md` (do/don’t, sensitive content boundaries,
   escalation rules)
3. Update: `.github/copilot-instructions.md` to reference the two new files prominently (top
   section) and de-duplicate repeated lines.
4. Update memory:
   - Append summary to `/memories/persona-strengthening-plan-nov7-2025.md`
   - Add links to `.github/memory/INDEX.md` and adjust `.github/memory/current-state.md` if needed

## Risks & Mitigations

- Risk: Instruction drift or duplication between files → Mitigate by declaring modes/guardrails as
  single source of truth and removing duplicated rules from the main index.
- Risk: Overhead from “mandatory docs for every response” → Scope to substantive actions (code
  edits, scripts, multi-step plans) in `persona-guardrails.md`.

## Next Steps

- Proceed with Option A now (draft `persona-modes.md` and `persona-guardrails.md`).
- Follow with Option B (few-shots) to accelerate training-by-example.
- Add Option C later to measure and maintain quality at scale.
