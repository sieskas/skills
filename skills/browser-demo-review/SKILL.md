---
name: browser-demo-review
description: >-
  Verifies any web/fullstack feature through real browser execution, visual proof-of-work demos
  (inspired by Simon Willison's Showboat & Rodney pattern), and an isolated Hostile Code Review.
  Starts the local app, runs real end-to-end user journeys + error states in a browser, checks for
  zero console/network errors, captures desktop/mobile screenshots, and audits the git diff for
  comment noise, architecture violations, and missed edge cases. Use after implementing a feature
  or before opening a Pull Request.
---

# Browser Demo & Hostile Code Review

Applies the **Never Self-Certify From Code Alone** rule to every full-stack or frontend feature. Combines **Agentic Manual Testing** (real browser demo with irrefutable visual proof) and an **isolated Hostile Code Review**.

## Phase 1: Real Browser Demo (Proof of Work)

Never trust passing unit tests or static code inspection as proof that a web feature works.

### 1. Start the Real Stack
- Boot the local app (frontend + backend/API if applicable) using the verified commands in `AGENTS.md`.
- Confirm the server is reachable before running browser steps.

### 2. Execute Real User Journeys (via `browser` subagent, Playwright, or Rodney/CDP)
Exercise the feature like a demanding QA engineer:
1. **Primary Happy Path:** Complete the full user flow from start to finish (navigation, clicks, form submission, persistence after page reload if stateful).
2. **Error / Edge State:** Trigger at least one invalid input, empty state, or error condition and verify graceful UI feedback.
3. **Runtime Health Check:** Inspect browser console and network requests — require **0 uncaught console errors** and **0 unexpected 4xx/5xx responses**.
4. **Responsive & Accessibility Spot-Check:**
   - Capture **Desktop (~1440px)** and **Mobile (~390px)** views (check for layout overflow, clipped text, broken alignment).
   - Verify keyboard focusability, button/input labels, and contrast (or run `axe-core` if configured).

### 3. Produce a Showboat-Style Demo Artifact
Deliver a concise, reproducible demo report (in the PR description, chat, or a markdown artifact) containing:
- **Exact commands run** (test suite + build + browser checks) with real pass/fail output.
- **Step-by-step walkthrough** of what was tested in the browser.
- **Embedded screenshots / traces** proving the rendered UI states (Desktop, Mobile, interactive/result state).

## Phase 2: Isolated Hostile Code Review

Run a dedicated, skeptical pass over `git diff` (ideally in a fresh subagent context with no sunk-cost bias from implementation). Inspect **only** high-signal defects:

1. **Comment Hygiene:** Flag and remove any AI-generated comments that narrate *what* the code does or contradict the code. Keep only *why*-comments and public contracts.
2. **Architecture & Coupling:** Check for layer leaks (business logic in controllers/UI, direct DB/fetch calls bypassing ports/services, god functions).
3. **AI Blind Spots:** Explicitly check error handling, null/empty boundaries, race conditions, input validation, and auth/security checks.
4. **Test Integrity:** Verify tests actually assert meaningful behavior (no tautological mocks or weakened assertions).

## Quality Gate & Verdict

Assign a clear verdict:
- **PASS (Ready to Merge):** All automated tests green, browser demo verified with 0 console/5xx errors, screenshots confirm clean UI, and 0 critical/high findings in Hostile Review.
- **FAIL (Fix Required):** List the exact blocking defects (with file/line references and screenshot evidence), fix them, and re-run Phase 1 on the affected flows.
