# FRIDAY Tooling Decision Matrix

Author: Copilot Agent  
Created: Nov 7, 2025  
Status: Draft v1

## Purpose

Fast, repeatable selection of the correct action tools. Prevents misuse and improves efficiency.

## Core Tools (Conceptual)

- File read/search → read_file, grep_search, semantic search (broad)
- File edits → apply_patch (atomic diff edits)
- New files/dirs → create_file, create_directory
- Terminal commands → run_in_terminal (single command, no multi-line)
- Memory ops → memory (view/update persistent context)
- Todo lifecycle → manage_todo_list (one active in-progress only)

## Decision Table

| Task Type                              | Tools                                          | Pre-Checks                                | Post-Action                            |
| -------------------------------------- | ---------------------------------------------- | ----------------------------------------- | -------------------------------------- |
| Understand large unknown codebase      | semantic_search (broad), grep_search (targets) | Confirm repo size                         | Summarize key components + next steps  |
| Find symbol usage                      | grep_search or semantic_search                 | Validate filename patterns                | List matches; decide edit scope        |
| Edit existing file                     | apply_patch                                    | Read relevant region (not whole if large) | Run lint/tests if logic changed        |
| Create doc or config                   | create_file                                    | Check for existing duplicates             | Link from index/instructions           |
| Multi-file feature plan                | manage_todo_list + create_file (plan doc)      | Gather requirements                       | Update todo statuses; memory summary   |
| Run tests/lint                         | run_in_terminal                                | Ensure package manifest exists            | Summarize PASS/FAIL and errors         |
| Update memory after change             | memory (insert/create)                         | Confirm file path naming convention       | Keep entries concise (≤ ~30 lines)     |
| Refactor large handler risk >700 lines | read_file (size), apply_patch                  | Measure lines; plan delegation            | Confirm size reduction; note in memory |
| Evaluate persona behavior              | persona-evals rubric doc                       | Select relevant dimensions                | Record scorecard; update memory        |

## Preamble Pattern

Always start batch with: one sentence: WHY + WHAT + OUTCOME. Example: “Gathering handler file
context to plan safe refactor.”

## Anti-Patterns (Avoid)

- Repeated tiny read_file calls (prefer larger chunk or semantic search).
- Editing existing file with create_file (will overwrite unexpectedly).
- Running multi-line shell scripts in one terminal invocation.
- Creating documentation for trivial clarifications.
- Multiple todos set to in-progress simultaneously.

## Verification Flow (Code Edit)

1. Context read (search + direct file read).
2. Patch prepared (minimal diff, no unrelated reformat).
3. Apply patch.
4. Run lint/tests → capture PASS/FAIL.
5. Update memory with summary.
6. Chat summary (bullets only).

## Error Handling

- If lint/test fails: attempt targeted fix ≤3 iterations.
- If still failing: summarize root cause + options; mark todo blocked or escalate.

## Metrics (Future Instrumentation)

- Track count of tool batches per task.
- Ratio of successful edits without follow-up corrections.
- Avg turnaround time from plan → implementation.

---

Version: 1.0 (Initial tooling matrix)
