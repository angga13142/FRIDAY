# Common Tasks & Modifications (Template)

Use these examples to add or modify features in a modular project. Replace with your domain
specifics.

## Adding a New Feature Module

1. Create handler/service under `src/modules/<feature>/` or `src/handlers/` + `src/services/`.
2. Register route in `RequestRouter` (HTTP path, CLI command, or event name).
3. Inject dependencies via Container/DI.
4. Add unit tests (handler + service) and update docs.

Example:

```javascript
// src/handlers/ReportHandler.js
class ReportHandler {
  constructor(reportService) {
    this.reportService = reportService;
  }
  async getWeekly(req) {
    return this.reportService.weekly(req.userId);
  }
}
```

## Updating Configuration

- Add new env var in `.env.example` and read in `src/config/app.config.js`.
- Provide sane defaults; validate at startup.

## Adjusting Rate Limits

- Implement token bucket in middleware; expose config key `RATE_LIMIT_PER_MIN`.
- Increase/decrease limits per route if needed.

## Adding Background Jobs

- Use a worker (BullMQ/Celery/etc.); define job schema and idempotency key.
- Add retry/backoff and dead letter queue.

## Observability

- Add structured logs for critical paths.
- Emit metrics counters/histograms if stack supports.

## Testing Tips

- Mock external APIs in unit tests.
- Include edge cases and error paths.
- Keep tests fast and deterministic.

## Documentation

- For significant changes, create a short doc in `docs/features/` and link from
  `recent-features.md`.
