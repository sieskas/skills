---
name: prompt-design-visuel
description: >-
  Generates highly structured prompts to build standout visuals, UI/UX interfaces, landing pages,
  or 3D/WebGL scenes with AI coding agents (Antigravity, Claude Code, Cursor, Codex). Integrates
  techniques from top AI design practitioners (Paul Bakaus / Impeccable, Emil Kowalski, DESIGN.md,
  Anthropic's Generator-Evaluator loop, 70%/95% quality gates, Visual Feedback Loop, and Ralph
  Wiggum Loop). Use whenever the user wants a prompt to create a beautiful visual, website,
  interface, animation, or 3D scene with an AI agent.
---

# Visual & Agentic Design Prompt Generator

Transforms a raw idea (interface, landing page, animation, 3D/WebGL scene) into a **complete, executable, high-bar prompt** designed to prevent AI coding agents from producing generic "AI slop" and force visual iteration up to studio-grade craft.

## Step 1: Express Framing (Anti-Rework)

If the user has already answered these clearly in their request, **generate the prompt directly** without asking unnecessary questions.

Otherwise, before writing the first line of code or final prompt, ask **in one short message** only the missing questions among these 4 axes (they prevent ~70% of token-expensive rework):
1. **True scope:** minimal footprint (single view/scene) or broader exploration (multi-view, sub-elements, extra interactions)?
2. **Assets & realism level:** real external assets (photos, HD textures, real icons/data) from v1, or 100% procedural/generated?
3. **Hero visual direction:** restrained/faithful or dramatic/stylized (plus 1 concrete visual reference if available)?
4. **Execution mode & iteration budget:**
   - **Fast (2 targeted cycles)** — 1 major rework + 1 polish *(best quality-to-token ratio)*,
   - **Antigravity (`/goal`, 3-4 cycles)** — autonomous high-bar loop with browser subagent,
   - **Ralph Wiggum Loop (long-horizon CLI)** — external `while` loop with state file and `--max-iterations`.

> **Architecture rule (token efficiency):** always instruct the agent to split code into **small domain-focused modules** rather than a single monolithic file, so every visual iteration reads and edits minimal context.

## Step 2: Match the Recipe to the Visual Type

Select the matching craft guidelines and negative constraints:

| Project Type | References & Techniques to Inject | Anti-Patterns to Ban Explicitly |
|---|---|---|
| **UI / App / Dashboard** | **Paul Bakaus (Impeccable)** + **Emil Kowalski** principles: strict hierarchy, flat surfaces + `1px` borders, explicit color/spacing tokens, `empty / loading / error` states, `ease-out` micro-interactions (150-250ms) or spring physics | Default Inter font with no character, generic purple/blue gradients, cards nested inside cards, soft drop shadows everywhere, cluttered badges/buttons |
| **Landing Page / Portfolio** | Strong editorial art direction, contrasting font pairing (display + body), generous vertical rhythm, single focal point per viewport, subtle scroll choreography | Generic hero ("headline + subhead + 2 buttons + 3 icon cards"), empty marketing fluff, decorative emojis, gratuitous glassmorphism |
| **3D / WebGL / Shaders** | Three.js + custom GLSL shaders, `ACESFilmic` tone mapping, selective Bloom, clean multi-scale transitions without z-fighting, logarithmic/cinematic camera curves, 60 fps | "Plastic" primitive meshes without shaders, basic procedural noise instead of real textures, square confetti stars, robotic linear camera motion, cluttered debug UI over the scene |
| **Animation / Canvas / Generative** | Real physics (springs, damping, inertia), restrained palette (3-4 colors max), HiDPI (`devicePixelRatio`), `prefers-reduced-motion` support | Linear transitions (`linear`), harsh flashing, visual overload without hierarchy |

## Step 3: Build the Prompt (5 Mandatory Blocks)

Every generated prompt must include these 5 concrete sections (never leave generic placeholders unfilled):

### 1. Objective & Stack
- Exactly what to build, the expected visual experience, and the exact tech stack (e.g. React + Tailwind + shadcn/ui, or Vite + TypeScript + Three.js + GLSL).
- Keep the UI minimal and purposeful (zero superfluous chrome).

### 2. Art Direction & Embedded `DESIGN.md` Tokens
- **Concrete visual references** (e.g. Linear, Stripe, Teenage Engineering, SpaceEngine, NASA Eyes...).
- **Strict palette** (hex codes for background, surface, primary/secondary text, single accent + strict accent usage rule).
- **Typography & rhythm** (fonts, hierarchy, spacing scale, border-radius).
- **Motion & Micro-interactions (Emil Kowalski rules):** `ease-out` curves for entrances, crisp natural timing, zero robotic linear motion.

### 3. Banned Anti-Patterns ("Anti-AI Slop" — Paul Bakaus rules)
- 4 to 6 **project-specific** visual bans to block classic LLM shortcuts.

### 4. Generator-Evaluator Protocol & Visual Feedback Loop (Anthropic method)
- Explicitly forbid stopping at the first working prototype (treat v1 as a ~60% draft).
- Separate the **Generator** role (writes code) from a **Hostile Evaluator** role (inspects the real rendered output with fresh eyes via browser/Playwright — never self-certify from code alone).
- Specify **3 to 4 mandatory screenshots** tailored to the project (e.g. Desktop 1440px, Mobile 390px, interactive/hover state, or 4 key camera stages).
- **Strict 100-point rubric:** 5 concrete, verifiable criteria scored out of 20 each, under a *default-FAIL* contract (no criterion passes without visual proof).

### 5. Quality Gates (70% / 95-99%) & Stop Condition
- **< 70%:** Critical failure — reject the current approach, diagnose the root cause, and rebuild cleanly.
- **70% - 94%:** Insufficient — explicitly list the **top 3 worst visual defects** observed in the captures and fix them in the next cycle.
- **>= 95% (or >= 99% in perfectionist mode)** with **every criterion >= 18/20** + **minimum 2-4 full capture/fix cycles**: cleared to ship with verified final captures.
- **Never write "work for 2 hours"** in clock time inside a single prompt — replace with iteration counts and verifiable quality gates.
- *If the user asks for **Ralph Wiggum Loop** mode:* append a short block specifying the state file (`prd.json` or `EVAL_LOG.md`), exit promise (`<promise>DONE</promise>`), and iteration cap (`--max-iterations 10`).

## Step 4: Delivery to the User

1. Output the **final prompt inside a single copy-pasteable Markdown code block**.
2. For multi-page apps or sites, offer (or include directly) a companion **`DESIGN.md`** for the repository root.
3. Add one concise launch tip (e.g. *"Run it with `/goal` in Antigravity to enable the autonomous multi-cycle loop"*).
