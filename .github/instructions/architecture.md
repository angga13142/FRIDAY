# Architecture Template (Project-Agnostic)

Use this as a starting point to document your system architecture. Replace placeholders with your
project’s components.

## System Overview

Adopt a modular design with clear separation of concerns to optimize maintainability, testability,
and scalability.

## Example Project Structure

```
project/
├── src/
│   ├── core/                    # Framework & infrastructure
│   │   ├── AppRuntime.ts/js     # App lifecycle/bootstrap
│   │   ├── EventBus.ts/js       # Event/Message handling
│   │   ├── RequestRouter.ts/js  # Routing logic
│   │   └── Container.ts/js      # Dependency injection
│   ├── modules/                 # Domain modules (handlers/services)
│   ├── services/                # Cross-cutting services (cache, db, ai)
│   ├── models/                  # Data models / DTOs
│   ├── middleware/              # Logging, validation, auth, rate limits
│   ├── utils/                   # Helpers & utilities
│   └── config/                  # Environment & feature flags
├── tests/                       # Unit & integration tests
├── docs/                        # Project documentation
└── scripts/                     # Tooling & automation
```

## Architectural Principles

1. Single Responsibility: each module has one purpose
2. Dependency Injection: pass dependencies, don’t hardcode
3. Separation of Concerns: isolate business from infrastructure
4. Testability: unit-test modules in isolation
5. Explicit Contracts: define stable interfaces between modules

## Core Layer (suggested)

- Runtime: app boot & shutdown lifecycle
- Router: maps requests/events to handlers
- Container: manages dependencies & configuration

## Module Layer (suggested)

- Feature modules group handlers, services, and models for a domain.
- Keep module files < 700 lines (if you adopt file-size CI rules).
- Delegate to submodules if a file approaches the limit.

## Service Layer (examples)

- Persistence: database/repository abstractions
- Cache/Queue: Redis, message broker, background jobs
- Observability: logging, metrics, tracing
- AI/External APIs: optional integrations (abstract behind interfaces)

## Configuration

- Centralize environment variables and feature flags in `src/config/`
- Provide sane defaults and document overrides in `.env.example`

## Delegation Pattern (large modules)

Split large handlers/services into submodules and register them in a routing map for O(1) lookup.
Keep public interfaces stable to reduce coupling.

## Notes

- Customize names and folders to your stack (Node, Python, Go, etc.)
- Document any CI file-size constraints, test frameworks, and coding standards in your project’s
  workflow docs.
