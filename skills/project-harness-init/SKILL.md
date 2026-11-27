---
name: project-harness-init
description: >-
  Initializes or audits an AI-ready Software Factory context harness for any repository using 2026
  Harness Engineering & Progressive Disclosure best practices (Martin Fowler / Birgitta Böckeler,
  OpenAI Harness Engineering, Anthropic ablation, ETH Zurich AGENTS.md findings). Creates a lean
  AGENTS.md map, on-demand docs/product and docs/architecture folders, and runs context garbage
  collection to prevent context rot. Use when bootstrapping a new repo, onboarding AI agents to an
  existing codebase, or auditing/pruning bloated AGENTS.md / CLAUDE.md files.
---

# Project Harness & Context Engineering

Sets up or audits a repository's **Context Harness** so coding agents (Antigravity, Claude Code, Cursor, Codex) operate with high reliability and low token waste—avoiding monolithic context files and context rot.

## Core Principles (2026 Consensus)

1. **Map, not manual:** `AGENTS.md` must stay under ~80 lines. Only include **non-inferable facts** (exact commands, known landmines, strict invariants, and pointers to deep docs). Never summarize directory trees or obvious code the agent can inspect directly.
2. **Progressive Disclosure:** Deep product, domain, and architecture knowledge lives in `docs/product/` and `docs/architecture/` and is loaded **only** when a task touches that area.
3. **Mechanical over prose:** Anything enforceable by a linter, typechecker, or test (formatting, imports, layer boundaries) belongs in tooling/CI, **not** in `AGENTS.md` prose.
4. **Comment hygiene:** Explicitly ban comments that paraphrase *what* the code does. Only allow comments explaining *why* (non-obvious business constraints, external bug workarounds, invariants) and public API contracts.

## Mode Selection

Determine the mode from the user's request (or inspect the repo root first):
- **Bootstrap mode:** No `AGENTS.md` or `docs/` structure exists yet.
- **Audit / Garbage Collection mode:** `AGENTS.md` / `CLAUDE.md` / `docs/` already exist and may have drifted or bloated.

## Mode A: Bootstrap a New or Existing Repo

### Step 1: Inspect Before Writing
Read the repo's real tooling files (`package.json`, `pom.xml`, `build.gradle`, `Makefile`, `pyproject.toml`, CI workflows) to extract the **exact** build, test, lint, and dev commands. Never invent or guess commands.

### Step 2: Create a Lean `AGENTS.md` (Root)
Keep it strictly under ~80 lines using this structure:

```markdown
# AGENTS.md

## Commands (Verified)
- Install: `<exact command>`
- Dev: `<exact command>`
- Test (unit): `<exact command>`
- Test (e2e): `<exact command>`
- Lint / Arch check: `<exact command>`

## Non-Negotiable Rules
- **Comments:** Never add comments explaining *what* the code does. Only document *why* (non-obvious constraints, workarounds, invariants) and public API contracts.
- **Scope:** Keep modules small and domain-focused. Do not modify unrelated files.
- **Verification:** Never claim a task is done without running the relevant tests and proving behavior.

## Known Landmines
- <Only non-obvious gotchas: env quirks, legacy constraints, forbidden patterns>

## Deep Context (Read On Demand)
- Product vision, personas & domain glossary: `docs/product/`
- System architecture & ADRs: `docs/architecture/`
- UI tokens & design system (if applicable): `DESIGN.md`
```

### Step 3: Scaffold On-Demand Context Folders
Create only the files that add real, non-inferable value (ask the user 3-4 short questions if product/business rules are missing):
- `docs/product/vision.md` — Target user, core problem solved, non-goals.
- `docs/product/glossary.md` — Ubiquitous Language (exact domain terms so agents never invent synonyms).
- `docs/product/business-rules.md` — Critical invariants, pricing/access/compliance rules, edge-case policies.
- `docs/architecture/overview.md` — High-level module boundaries, data flow, and dependency rules.
- `docs/architecture/adr/0001-initial-architecture.md` — First Architecture Decision Record.

## Mode B: Audit & Context Garbage Collection

Run this periodically to fight context drift:
1. **Bloat check:** Flag any `AGENTS.md` / `CLAUDE.md` over 100 lines or containing directory dumps / generic advice ("write clean code"). Propose concrete cuts (ablation).
2. **Stale command check:** Verify every command listed in `AGENTS.md` still exists in `package.json` / `pom.xml` / `Makefile`.
3. **Prose-to-tool migration:** Identify rules written in prose that should be moved into ESLint, Checkstyle, ArchUnit, or CI.
4. **Drift check:** Compare `docs/architecture/` and `docs/product/` against the actual codebase and flag outdated claims.

## Exit Criteria
- `AGENTS.md` is concise (< 80 lines), verified against real repo scripts, and contains zero redundant code summaries.
- Deep context is cleanly separated into `docs/product/` and `docs/architecture/` with explicit pointers.
- Every proposed rule is either non-inferable human intent or backed by a mechanical check.
