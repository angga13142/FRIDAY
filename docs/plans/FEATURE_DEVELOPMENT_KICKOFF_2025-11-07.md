# FRIDAY Protocol — Feature Development Kickoff (2025-11-07)

This document starts the structured feature workflow. Pick one option below and provide the short
brief at the end.

## Recommended Feature Options (Impact → Effort)

1. Multi-language support (ID/EN)

- Impact: High (broader audience, clearer UX)
- Effort: Medium
- Outline:
  - Add messages/\* (id.js, en.js)
  - Session language preference + `/language` command
  - Router + handlers load language-specific strings

2. Voice message handling (basic)

- Impact: Medium (better UX, accessibility)
- Effort: Medium
- Outline:
  - Detect audio messages, auto-reply with supported options
  - Optional: speech-to-text (configurable) with graceful fallback

3. Loyalty points system

- Impact: High (retention, repeat purchase)
- Effort: Medium-High
- Outline:
  - Award points on completed orders
  - Balance view, redemption, expiration

4. Subscription management

- Impact: High (recurring revenue, predictable operations)
- Effort: High
- Outline:
  - Track subscription terms, renewals, reminders
  - Pause/cancel flow, payment retries

5. Product recommendations (AI-powered)

- Impact: Medium-High (AOV lift)
- Effort: Medium
- Outline:
  - Use AIIntentClassifier + product context
  - Up-sell/cross-sell suggestions during browsing/checkout

## Success Criteria (example)

- Functional: commands work in WhatsApp, correct state transitions, error cases handled
- Quality gates: ESLint 0 errors, all Jest tests passing, no new flaky tests
- Performance: reply latency within acceptable range, no rate-limit regressions

## Workflow Reminder (MANDATORY)

- Stage 1: Implementation Plan (this template: docs/plans/FEATURE_IMPLEMENTATION_PLAN_TEMPLATE.md)
- Stage 2: Implementation Summary (append to same doc after completion)

## What I need from you to proceed

Please reply with:

- Feature name (e.g., "Multi-language support")
- Goals / problem it solves
- KPIs (e.g., % usage, CSAT, response correctness)
- Constraints (budget, API costs, time)
- Priority (P0/P1/P2)

I will then fill the plan template and begin implementation.
