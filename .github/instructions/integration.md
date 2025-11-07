# Integration Guidelines (Template)

Use this file to define how your project integrates with external systems (APIs, data stores,
messaging, auth). Replace placeholders with specifics for your implementation.

## 1. External Services Inventory

Document each external dependency: | Service | Purpose | Protocol | Auth Method | Retry Policy |
Timeout | |---------|---------|----------|-------------|--------------|---------| | Example: Payment
API | Payment capture | HTTPS REST | API Key (env) | Exponential (5 tries) | 8s | | Example: Search
Engine | Full-text search | gRPC | OAuth2 | Immediate fail | 3s |

## 2. Configuration & Secrets

Place environment variables in `.env.example` with comments:

```
PAYMENT_API_KEY=your_key_here        # Secret key for payment provider
SEARCH_ENDPOINT=https://...          # External search URL
FEATURE_FLAG_RECOMMENDATIONS=false   # Toggle experimental feature
```

Never commit real secrets. Use secret managers in production.

## 3. Common Patterns

### HTTP API Wrapper

Wrap external APIs in a service class with:

- Input validation
- Error normalization
- Retries & circuit breaker (optional)

### Messaging / Events

If using queues or pub/sub:

- Define event contracts (`events/<domain>-events.md`)
- Include idempotency keys and version field
- Consumer ACK strategy documented

### Persistence

Abstract data access via repository interfaces:

```
interface UserRepository {
  findById(id: string): Promise<User|null>
  save(user: User): Promise<void>
}
```

Allows swapping DB implementations without business logic changes.

## 4. Integration Checklist

Before adding a new integration:

- [ ] Clarify SLA & latency expectations
- [ ] Decide error handling & fallback behavior
- [ ] Define request/response schema
- [ ] Add env vars & update `.env.example`
- [ ] Create service wrapper + interface
- [ ] Add unit tests with mocks
- [ ] Document in this file (inventory table)
- [ ] Update monitoring/logging if needed

## 5. Error Handling & Retries

Use exponential backoff for transient network errors: `delay = base * 2^attempt` (cap max). Abort
after N attempts and surface normalized error.

Provide categorized errors (e.g., `ExternalTimeoutError`, `ValidationError`, `AuthError`).

## 6. Observability

Log external calls at debug level with:

- service name
- endpoint/path
- duration
- success/failure flag

Add metrics (counter: calls, histogram: latency, gauge: open circuits) if using monitoring stack.

## 7. Fallback Strategies

For non-critical services:

- Serve cached/stale data
- Return partial response with `warnings` array For critical failures:
- Return standardized maintenance message

## 8. Internationalization (Optional)

To support multiple languages:

- Store text resources in `i18n/<lang>.json`
- Provide helper: `t(key, lang)`
- Avoid hardcoding copy in business logic

## 9. Security Considerations

- Validate all external input
- Enforce timeouts (no hanging requests)
- Escape/encode data before persisting or rendering
- Rotate keys & audit usage

## 10. Testing Strategy

| Test Type   | What to Cover                                 |
| ----------- | --------------------------------------------- |
| Unit        | Service wrapper methods (mock transport)      |
| Integration | Happy path + error path against sandbox/stub  |
| Contract    | Schema validation (e.g., OpenAPI/JSON Schema) |
| Resilience  | Retry/backoff logic, timeouts                 |

## 11. Versioning & Change Management

Track API version changes in `docs/integration-changelog.md`:

```
## 2025-11-07
- Added v2 /payments endpoint (supports batch capture)
```

## 12. Removal / Decommission

When removing an integration:

- [ ] Identify dependent modules
- [ ] Remove env vars & secrets
- [ ] Archive service wrapper
- [ ] Update inventory table
- [ ] Clean tests & mocks

---

Template ready; customize sections for your project.
