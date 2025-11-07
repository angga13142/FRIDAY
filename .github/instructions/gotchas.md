# Critical Gotchas & Troubleshooting (Template)

## 1. State Not Persisted

Problem: Restart clears in-memory state. Solution: Use external store (Redis/Postgres). Wrap access
in repository/service; set TTL for ephemeral sessions.

## 2. File Size / Complexity Creep

Problem: Single module grows too large. Solution: Enforce size threshold (e.g., <700 lines). Apply
delegation pattern, split by domain responsibility.

## 3. Rate Limiting Missing

Problem: Abuse or accidental overload. Solution: Implement fixed window or token bucket middleware;
expose config; add headers (`X-RateLimit-Remaining`).

## 4. Secrets Leaked

Problem: Hardcoded API keys in source. Solution: Centralize env access; scan pre-commit; rotate
leaked keys.

## 5. Unhandled Errors

Problem: Crashes or silent failures. Solution: Global error handler + typed error classes; log with
correlation ID; return normalized error object.

## 6. Missing Observability

Problem: Hard to trace performance issues. Solution: Add structured logs (op, duration, success),
metrics (latency histogram), and optional tracing.

## 7. Cache Staleness

Problem: Serving outdated data. Solution: Add invalidation strategy (time-based + event-driven).
Include ETag for HTTP responses.

## 8. Concurrency Conflicts

Problem: Race conditions updating shared resources. Solution: Use optimistic locking (version field)
or distributed locks (Redis Redlock) for critical sections.

## 9. Inefficient Queries

Problem: N+1 query patterns. Solution: Add batching layer, use JOINs or SELECT IN, add indices;
profile with EXPLAIN.

## 10. Feature Flag Drift

Problem: Old flags accumulate. Solution: Flag lifecycle policy: introduce → evaluate →
remove/archive after expiry date.

## Troubleshooting Checklist

| Symptom         | Checks                                              |
| --------------- | --------------------------------------------------- |
| Slow responses  | DB latency, cache hit rate, external API timeouts   |
| High error rate | Recent deploy diff, error logs categories           |
| Memory leak     | Heap snapshot comparison, long-lived listeners      |
| Timeouts        | Retry storm, circuit breaker status, dependency SLA |

## Debug Workflow

1. Reproduce minimal failing case.
2. Categorize (performance, correctness, infra).
3. Gather metrics/logs.
4. Form hypothesis; create small test or sandbox script.
5. Apply fix; verify with tests + metrics.
6. Document root cause + remediation.

## Preventative Measures

- Pre-deploy smoke tests.
- Static analysis (lint, complexity thresholds).
- Dependency audit (monthly).
- Automated secret scan.

---

Adapt items to your stack; remove those not applicable.
