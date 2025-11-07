# Implementation Plan: [Feature Name]

Created: [YYYY-MM-DD HH:MM TZ] Status: Planning Owner: FRIDAY Protocol

## 1) Requirements Analysis

- User problem:
- Target users:
- Expected behavior (happy path):
- Non-goals / out-of-scope:
- Assumptions:

## 2) Success Metrics (KPIs)

- Primary:
- Secondary:
- Guardrails (latency, error rate):

## 3) Technical Approach

- Architecture impact (handlers/services/router):
- Data model/storage changes:
- External dependencies (APIs, SDKs):
- Config/feature flags:
- Security/PII considerations:
- Monitoring/observability (logs, metrics, alerts):
- Rollout strategy (flag, gradual, A/B):
- Backout plan:

## 4) File List (create/modify)

- [ ] path/to/file.ext — purpose

## 5) Risks & Mitigations

- Risk: … → Mitigation: …
- Risk: CI/CD file-size limit (>700 lines) → Mitigation: handler delegation/new files
- Risk: Secrets exposure → Mitigation: use env vars, no hardcoded keys

## 6) Test Strategy (Jest)

- Unit tests:
- Integration tests:
- Edge cases (empty/null, large/slow, auth/permissions, timeouts):
- Acceptance criteria (must pass):
- Non-regression checks (lint 0 errors, tests green):

---

## Implementation Summary (fill AFTER completion)

Completed: [YYYY-MM-DD HH:MM TZ] Status: ✅ Success / ❌ Partial

### Final Result

- Summary of behavior & UX

### Change Summary

- Files created (n):
- Files modified (n):
- Tests added/updated:

### Deviations from Plan

- What changed and why

### How to Run / Validate

- Commands (lint/test/dev):
- Feature flag/env updates:
- Manual test steps:
- Post-deploy verification & monitoring:
