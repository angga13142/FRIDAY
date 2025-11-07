# File-Specific Reference (Template)

Customize this reference for your project’s actual files. Replace placeholders with real paths.

## Core Entry Points

| File                           | Purpose                | Notes                          |
| ------------------------------ | ---------------------- | ------------------------------ |
| `src/index.ts/js`              | Application bootstrap  | DI init, start server/workers  |
| `src/core/AppRuntime.ts/js`    | Lifecycle (start/stop) | Hook for graceful shutdown     |
| `src/core/RequestRouter.ts/js` | Route resolution       | HTTP paths / commands / events |
| `src/core/Container.ts/js`     | Dependency injection   | Registers services & config    |

## Domain Modules (Examples)

| Module  | Files                              | Description                        |
| ------- | ---------------------------------- | ---------------------------------- |
| User    | `UserHandler`, `UserService`       | Auth, profile, preferences         |
| Billing | `BillingHandler`, `InvoiceService` | Invoice creation & payment capture |
| Catalog | `CatalogHandler`, `ProductService` | Product listing & search           |

## Services (Cross-Cutting)

| Service          | Responsibility                 |
| ---------------- | ------------------------------ |
| `CacheService`   | Read-through caching layer     |
| `EmailService`   | Outbound notifications         |
| `AIService`      | External AI model abstraction  |
| `MetricsService` | Counters/histograms publishing |

## Configuration

| File                         | Purpose                          |
| ---------------------------- | -------------------------------- |
| `src/config/app.config.*`    | App-level options (ports, flags) |
| `src/config/feature-flags.*` | Feature rollout toggles          |
| `src/config/security.*`      | Auth, CORS, rate limits          |

## Middleware (Examples)

| File                                    | Purpose                  |
| --------------------------------------- | ------------------------ |
| `src/middleware/AuthMiddleware.*`       | Token/session validation |
| `src/middleware/RateLimitMiddleware.*`  | Enforce request quotas   |
| `src/middleware/ValidationMiddleware.*` | Schema validation        |

## Utilities

| File                     | Purpose                   |
| ------------------------ | ------------------------- |
| `src/utils/logger.*`     | Structured logging helper |
| `src/utils/uuid.*`       | ID generation             |
| `src/utils/validation.*` | Common input validation   |

## Testing Layout (Suggested)

```
tests/
├── unit/          # Pure functions/services with mocks
├── integration/   # Service interactions (DB + cache)
└── e2e/           # Full user flows / contract tests
```

## Quick Lookup Template

| Need to modify  | Check file                             |
| --------------- | -------------------------------------- |
| Routing logic   | `src/core/RequestRouter.*`             |
| Business rule   | Relevant `*Service.*` & handler        |
| Feature flag    | `src/config/feature-flags.*`           |
| Rate limit      | `src/middleware/RateLimitMiddleware.*` |
| AI prompt logic | `src/services/AIService.*`             |

---

Replace placeholders once actual files are defined.
