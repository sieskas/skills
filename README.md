# Agent Skills

A curated collection of ready-to-use skills for AI coding and product agents (**Antigravity**, **Claude Code**, **Cursor**, **Codex**).

> Some skills are written in French (marked 🇫🇷).

## Product, ideation & design

| Skill | Description |
|---|---|
| [`ideation-saas`](./skills/ideation-saas/SKILL.md) | Generates original, monetizable feature, acquisition, and pricing ideas for SaaS products while bypassing LLM mode collapse (*Verbalized Sampling*, *CreativeDC* Divergence/Convergence separation, Ethan Mollick's anti-cliche blacklist, frameworks from Teresa Torres, Elena Verna, Kyle Poyar, Bob Moesta, Lenny Rachitsky, and Shreyas Doshi). |
| [`prompt-design-visuel`](./skills/prompt-design-visuel/SKILL.md) | Transforms a raw idea (UI/UX, landing page, animation, 3D/WebGL scene) into a complete anti-"AI slop" prompt with anti-rework framing, art direction, Anthropic's *Generator-Evaluator* loop, quality gates, and *Visual Feedback Loop*. |
| [`figma-rapid-mockup`](./skills/figma-rapid-mockup/SKILL.md) 🇫🇷 | Studio-grade Figma mockups in record time (hackathon, product sprint, client demo), combining Mobbin references, the Figma MCP (frames, Variables, Auto Layout) and a scored review grid. |
| [`webgl-threejs-craft`](./skills/webgl-threejs-craft/SKILL.md) | Battle-tested WebGL / Three.js / GLSL guardrails derived from real Windows GPU (ANGLE/Direct3D11) bugs: anti-`NaN` Bloom squares, opaque depth sorting + `renderOrder`, UV/mipmap seam prevention, shimmer-free starfields, linear ACES Filmic color calibration, and bubble-free `BackSide` atmospheres. |

## Engineering workflow

| Skill | Description |
|---|---|
| [`arch-craft`](./skills/arch-craft/SKILL.md) | Defines, enforces and audits clean architecture for AI-assisted development (Hexagonal / Clean Architecture, Modular Monolith, decoupled frontend), with boundaries encoded mechanically via ArchUnit and ESLint. |
| [`spec-tdd-feature`](./skills/spec-tdd-feature/SKILL.md) | Disciplined Spec-Driven + TDD feature delivery inspired by Kent Beck and StrongDM holdout scenarios: executable spec, failing tests first, then implementation. |
| [`project-harness-init`](./skills/project-harness-init/SKILL.md) | Initializes or audits an AI-ready context harness for any repository using Harness Engineering and Progressive Disclosure practices. |
| [`browser-demo-review`](./skills/browser-demo-review/SKILL.md) | Verifies web/fullstack features through real browser runs, visual proof-of-work demos (Showboat & Rodney pattern) and an isolated Hostile Code Review. |
| [`claude-code-bridge`](./skills/claude-code-bridge/SKILL.md) 🇫🇷 | Delegates coding tasks from Antigravity to Claude Code (headless `claude.exe` with sessions resumable in Claude Desktop, or clipboard handoff). Includes a PowerShell helper script. |

## Replica pack (clone an app, make it your own)

| Skill | Description |
|---|---|
| [`replica-recon`](./skills/replica-recon/SKILL.md) | Reverse-engineers an app into a recon map: screens, flows, components, inferred data model and feature matrix. First step of the pack. |
| [`replica-entrepreneur`](./skills/replica-entrepreneur/SKILL.md) | Mines public user reviews of the target app and ranks pains, gaps and unsolved problems into a positioning angle. |
| [`replica-architect`](./skills/replica-architect/SKILL.md) | Plans stack, SQL schema, API routes and build order from the recon map. |
| [`replica-design`](./skills/replica-design/SKILL.md) | Rebuilds the design system as tokens and component specs, with original assets and a contrast checker. |
| [`replica-brand`](./skills/replica-brand/SKILL.md) | Names and rebrands the clone: name checks, palette, logo brief, voice guide and a sweep tool for leftovers of the original. |
| [`replica-build`](./skills/replica-build/SKILL.md) | Builds the app screen by screen as vertical slices, ticking off the feature matrix. |
| [`replica-backend`](./skills/replica-backend/SKILL.md) | Auth, migrations, access rules, Stripe payments, email, jobs and integrations, plus a security checklist. |
| [`replica-test`](./skills/replica-test/SKILL.md) | Test plan from the recon flows, Playwright E2E tests, browser click-through and structured bug reports. |
| [`replica-diff`](./skills/replica-diff/SKILL.md) | Feature parity score and colour-blind screenshot layout diff against the original. |
| [`replica-launch`](./skills/replica-launch/SKILL.md) | Landing page, pricing and store listings linted against App Store / Google Play limits and copycat rules. |
| [`replica-deploy`](./skills/replica-deploy/SKILL.md) | Preflight gate, production database, hosting, DNS, email and Stripe live on the user's own domain. |

## Game development (Godot 4 + Blender) 🇫🇷

| Skill | Description |
|---|---|
| [`game-designer-gdd`](./skills/game-designer-gdd/SKILL.md) | Game designer and keeper of a living, queryable Game Design Document. |
| [`godot-gameplay-architect`](./skills/godot-gameplay-architect/SKILL.md) | Gameplay, architecture and systems in Godot 4 (typed GDScript or C#): mechanics, scenes, state machines, `.tres` data resources. |
| [`godot-techart-juice`](./skills/godot-techart-juice/SKILL.md) | Tech art, shaders, lighting, UI/HUD and game feel ("juice") in Godot 4. |
| [`godot-qa-review`](./skills/godot-qa-review/SKILL.md) | Headless QA, smoke tests and Hostile Code Review for Godot 4 and Blender projects. |
| [`blender-asset-pipeline`](./skills/blender-asset-pipeline/SKILL.md) | Blender → Godot 4 pipeline: `bpy` scripts, blender-mcp, procedural modeling, rigging, NLA animations and glTF export. |

## Installation

### Antigravity (global)
Copy the desired skill folders into `~/.gemini/config/skills/`:
```bash
cp -r skills/ideation-saas skills/prompt-design-visuel ~/.gemini/config/skills/
```

### Claude Code / Cursor / Codex (or per-project)
Copy the folders into `.agents/skills/` (or `.claude/skills/`) at your repository root, or run:
```bash
npx skills add sieskas/skills
```
