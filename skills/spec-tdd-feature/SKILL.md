---
name: spec-tdd-feature
description: >-
  Guides AI coding agents through disciplined Spec-Driven + TDD feature delivery inspired by Kent
  Beck (Augmented Coding / TDD) and StrongDM (Holdout Scenarios). Turns a feature request into a
  concise executable spec covering edge cases, writes failing tests first for human approval, and
  enforces separation between acceptance criteria and implementation so agents cannot reward-hack
  their own tests. Use whenever implementing a non-trivial feature, bug fix, or business rule.
---

# Spec-Driven & TDD Feature Delivery

Eliminates "happy-path-only" AI code and self-validating blind spots by turning tests into an **executable specification** before writing implementation code.

## Step 1: Concise Executable Spec (Before Any Code)

Write a short, concrete spec (10-25 lines, saved in `docs/specs/<feature>.md` for non-trivial features) covering **both** the happy path and the 4 failure modes where LLMs consistently underperform:

1. **Goal & User Story:** Exact observable behavior.
2. **Happy Path:** Expected inputs → outputs / state transitions.
3. **Failure Modes Checklist (Mandatory):**
   - **Error handling:** Invalid inputs, timeouts, upstream failures, empty/null states.
   - **Edge cases:** Boundaries (0, max, duplicates, timezone/encoding, empty collections).
   - **Concurrency / Idempotency:** Double submits, race conditions, retries.
   - **Security / Permissions:** Authz checks, tenant isolation, injection/validation boundaries.
4. **Out of Scope:** What must *not* be changed.

## Step 2: Red Phase — Write Failing Tests First (Kent Beck TDD)

Before modifying production code:
1. Write **domain unit tests** (fast, pure, zero DB/network) for the core business rules and edge cases.
2. Write **integration / contract tests** (or E2E acceptance scenarios) covering the boundary behavior and at least 1 error path.
3. Run the test suite and **confirm the new tests fail for the right reason** (missing behavior, not syntax/import errors).
4. **Pause for quick approval** if the feature introduces new public APIs or critical business rules, so the human validates the acceptance criteria *before* implementation burns tokens.

## Step 3: Green Phase — Implement Without Cheating (Holdout Discipline)

Now implement the minimal production code to make all tests pass:
- **Strict Holdout Rule:** Do **not** weaken assertions, delete failing edge-case tests, or mock away the system under test just to turn the suite green. If a test truly has a flawed assumption, stop and explain why to the user before touching the test.
- Respect all architectural boundaries (`arch-craft` / `AGENTS.md`).
- Keep changes tightly scoped to the spec.

## Step 4: Refactor & Harden

Once green:
1. Run the **full** test suite + linters + architecture boundary tests (not just the single new test file).
2. Clean up duplication, overly complex functions, and any unnecessary AI-generated comments (*what*-comments).
3. Verify no regressions were introduced.
4. For user-facing UI/web features, hand off to **`browser-demo-review`** for real browser verification and hostile review.

## Exit Criteria
- Spec explicitly covers error handling, edge cases, concurrency, and security.
- Tests were written and observed failing before implementation.
- Full test suite + linters pass with zero weakened assertions or skipped tests.
