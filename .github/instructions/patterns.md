# Design Patterns & Best Practices (Template)

Use these generalized patterns for any modular backend/service-oriented project. Replace
placeholders with your domain specifics.

## Request Processing Flow

Typical pipeline: `TransportAdapter` → `RequestRouter` → `Handler` → `ResponseFormatter`

1. Adapter normalizes raw input (lowercase, trim, parse JSON) and filters unsupported sources.
2. Router resolves route by method/path or command keyword.
3. Middleware stack (auth, rate limiting, validation) executes.
4. Handler performs business logic using injected services.
5. Response formatter serializes output into transport-specific format (HTTP, event, CLI, etc.).

### Advantages

- Single responsibility per component
- Easy middleware insertion
- Test handlers in isolation with mocked services
- Clear error boundaries

## State Machine Pattern (Optional)

Define discrete states for multi-step flows (e.g., `idle`, `collecting_input`, `processing`,
`completed`). Store in session/context object. Transition via explicit function
`transition(state, event)`.

Benefits: predictable flow control, easier debugging, resilience to partial failures.

## Configuration Pattern

Centralize config in `config/` with environment override precedence: defaults → env vars → runtime
flags. Provide accessor `getConfig()` returning a frozen object.

## Error Handling Pattern

Categorize errors: | Category | Example | Action | |----------|---------|--------| | Validation |
Missing field | 400 / structured error object | | Auth | Invalid token | 401 / refresh instructions
| | External | API timeout | Retry/backoff, fallback cache | | Internal | Null pointer | Log &
generic message |

Log with correlation IDs for multi-service tracing.

## Rate Limiting Pattern

Token-bucket or fixed window:

```
canProceed(key) {
  // key: userId/IP
  const limit = 100; // per window
  const windowMs = 60000;
  // storage lookup & update ...
}
```

Use in middleware before hitting handlers.

## Delegation Pattern

For growing modules: split into sub-handlers (e.g., `UserHandler`, `BillingHandler`). Main router
maps operation → handler method. Keeps files small (< size threshold) and improves cohesion.

## Caching Pattern

Read-through cache:

```
async getUser(id) {
  const cached = await cache.get(id);
  if (cached) return cached;
  const user = await db.find(id);
  await cache.set(id, user, { ttl: 300 });
  return user;
}
```

Avoid caching mutable data without invalidation strategy.

## Observability Pattern

Wrap critical external calls with timing + success flag; emit structured logs:

```
log.info({ op: 'fetchUser', ms: duration, success: true });
```

Add metrics if stack supports (counter, histogram).

## Feature Flag Pattern

Simple boolean flags or percentage rollout stored in config; guard new logic:

```
if (flags.newPricingModel) { ... } else { ... }
```

## Testing Guidelines

| Layer         | Test Type          | Focus                                   |
| ------------- | ------------------ | --------------------------------------- |
| Utils         | Unit               | Pure functions, edge cases              |
| Services      | Unit + integration | External interactions mocked vs sandbox |
| Handlers      | Unit               | Input → output correctness              |
| Router        | Integration        | Route resolution & middleware ordering  |
| State machine | Unit               | Event → state transitions               |

Mock external APIs; assert side effects (logs, metrics) when relevant.

## Performance Considerations

- Avoid synchronous CPU-heavy loops in request path; offload to worker/batch.
- Use connection pooling for DB / HTTP clients.
- Stream large payloads where possible.

## Security Checklist

- Input sanitization (avoid injection attacks)
- Output encoding (XSS prevention for web)
- Principle of least privilege for credentials
- Secure storage of secrets (never in source)
- Audit logging for sensitive operations

## Internationalization (Optional)

Store translations as key-value JSON; never hardcode copy in logic. Provide fallback language.

## Extensibility Tips

- Define stable interfaces at domain boundaries.
- Prefer composition over inheritance for service augmentation.
- Document assumptions inline (JSDoc or comments) for non-obvious logic.

## Anti-Patterns to Avoid

- God object handlers doing unrelated tasks.
- Hidden global mutable state.
- Catch-all error swallowing stack traces.
- Overuse of caching without invalidation.

## Template TODO (Customize for Your Project)

- [ ] Define core domain modules
- [ ] List external integrations in integration guidelines
- [ ] Establish logging format & correlation ID strategy
- [ ] Pick rate limiting algorithm
- [ ] Decide on feature flag storage

---

Adapt these patterns; remove what you don't use.
