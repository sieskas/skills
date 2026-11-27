---
name: arch-craft
description: >-
  Defines, enforces, and audits clean software architecture for AI-assisted development
  (Hexagonal / Clean Architecture, Modular Monolith, decoupled frontend). Encodes architectural
  boundaries mechanically via ArchUnit (Java/Spring/Quarkus), ESLint boundaries / dependency-cruiser
  (TypeScript/React), cognitive complexity limits, and strict comment hygiene so coding agents
  cannot introduce architectural sprawl. Use when designing a new app/service architecture, adding
  mechanical architecture tests, or reviewing structural health.
---

# Architecture Craft & Mechanical Guardrails

Prevents "vibe-based" architectural sprawl when building with AI coding agents. LLMs optimize locally for the current prompt; this skill establishes **global boundaries** and enforces them **mechanically** in CI so agents get an immediate red build on any boundary violation.

## Step 1: Right-Size the Architecture (Proportionality)

Never over-engineer a disposable script, and never under-structure a durable product. Pick the tier that matches the project's lifespan and domain complexity:

| Project Tier | Recommended Architecture | When to Use |
|---|---|---|
| **Tier 1 — Script / Prototype** | Flat feature modules (small files, pure functions separated from I/O) | Throwaway tools, spikes, single-purpose scripts |
| **Tier 2 — Web App / SaaS MVP** | **Modular Monolith** (vertical slices by domain + shared `core` / `infra`) | Most SaaS products, full-stack web apps |
| **Tier 3 — Complex Domain / Enterprise** | **Hexagonal / Clean Architecture** (pure `domain` → `application` use cases/ports → `adapters` inbound/outbound) | Financial/business-critical backends (Java/Spring/Quarkus, Go, TS) |

> **Why Clean/Hexagonal excels with AI agents:** Pure domain modules have zero framework or DB imports. Agents can read a tiny context window and run unit tests in milliseconds.

## Step 2: Define Explicit Layer Contracts

Document the chosen boundaries concisely in `docs/architecture/overview.md` and an ADR (`docs/architecture/adr/`):
1. **Dependency direction:** Inner layers (`domain`) must **never** import outer layers (`adapters`, `controllers`, `persistence`, `ui`, framework annotations).
2. **DTO vs Domain isolation:** HTTP/JSON DTOs and ORM/JPA entities stay in adapters; map them at the boundary.
3. **Frontend separation (React/Vue/Svelte):** Keep presentational UI components, state/hooks, and API/infrastructure clients in distinct folders—no raw `fetch` or business rules buried inside JSX.
4. **Module size & complexity:** Keep files small and domain-focused (target < 250 lines per file, cognitive complexity <= 15 per function) so every agent iteration reads minimal context.

## Step 3: Encode Boundaries Mechanically (Mandatory)

Never rely on prose alone to protect architecture. Add automated checks that run in `test` or `lint`:

### Java / Spring Boot / Quarkus → **ArchUnit**
Add an `ArchitectureTest` enforcing:
- `domain` has zero dependencies on `org.springframework..`, `jakarta.persistence..`, `io.quarkus..`, or `..adapter..`.
- `application` (use cases) depends only on `domain` and ports, never on concrete adapters.
- `adapters.in` (controllers) never bypass use cases to call repositories directly.
- No cyclic dependencies between domain slices.

### TypeScript / Node / React → **ESLint Boundaries or `dependency-cruiser`**
Add a mechanical rule enforcing:
- `domain/` cannot import from `infra/`, `api/`, or `ui/`.
- `ui/` components cannot import `infra/` directly (must go through hooks/services).
- No circular dependencies (`no-circular`).
- Complexity cap (`complexity` / `sonarjs/cognitive-complexity`) and strict TypeScript (`strict: true`, no `any` in core).

### Python → **`import-linter` + `ruff`**
- Define `layers` or `forbidden` contracts in `pyproject.toml` so `domain` never imports FastAPI/Django/SQLAlchemy.

## Step 4: Comment & Code Hygiene Rules

Enforce these standards in code reviews and `AGENTS.md`:
- **Ban *what*-comments:** Reject AI-generated narration (*"loop through users and save"*).
- **Mandate *why*-comments:** Only comment non-obvious business invariants, concurrency assumptions, or workarounds for upstream bugs.
- **Public contract docs only:** Document inputs, outputs, and thrown errors on public ports/APIs; skip docstrings on obvious private helpers.

## Exit Criteria
- Architecture tier and layer boundaries are documented in `docs/architecture/overview.md`.
- At least one **mechanical boundary check** (ArchUnit, `dependency-cruiser`, ESLint boundaries, or `import-linter`) runs and passes in the project's test/lint suite.
- Verify the guardrail actually works by confirming an intentional violation would fail the check.
