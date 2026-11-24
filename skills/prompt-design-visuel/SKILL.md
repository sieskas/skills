---
name: prompt-design-visuel
description: >-
  Generates highly structured prompts to build standout visuals, UI/UX interfaces, websites,
  landing pages, or 3D/WebGL scenes with AI coding agents (Antigravity, Claude Code, Cursor,
  Codex). Integrates 2026 anti-"AI slop" and anti-"Claude Code look" craft practices (visual
  reference decomposition from Siteinspire/Godly/Mobbin, intentional imperfection, human
  signature details, Paul Bakaus / Impeccable, Emil Kowalski, DESIGN.md, Anthropic's
  Generator-Evaluator loop, 70%/95% quality gates, Visual Feedback Loop, and Ralph Wiggum
  Loop). Use whenever the user wants a prompt to design or redesign a standout visual,
  website, interface, animation, or 3D scene with an AI agent.
---

# Visual & Agentic Design Prompt Generato

Transforms a raw idea (website, interface, landing page, animation, 3D/WebGL scene) into a **complete, executable, high-bar prompt** designed to break AI coding agents out of statistical-median "AI slop" (both the *"Claude Code look"* and *"v0/Linear Bento slop"*) and force visual iteration up to distinctive, studio-grade craft.

## Core Rule: Never Let an LLM Invent Taste from Vague Adjectives

Prompting for *"modern, clean, warm, original"* without external visual anchors always collapses to the training-data median:
- **The "Claude Code look":** beige/cream + terracotta/rust + italicized serif headings + uniform `1px` rounded cards.
- **The "v0 / Cursor / Linear slop":** dark carbon slate + indigo/purple glow + `Inter`/`Space Grotesk` + symmetrical 3-4 card Bento grids.

Originality comes from **decomposed real-world visual references**, **intentional imperfection/asymmetry**, and **one unmistakably human signature detail**.

## Step 1: Express Framing ("Taste First" & Anti-Rework)

If the user has already answered these clearly in their request, **generate the prompt directly** without asking unnecessary questions.

Otherwise, before writing the first line of code or final prompt, ask **in one short message** only the missing questions among these 4 axes (they prevent ~70% of token-expensive rework):
1. **2-3 real visual references (highest leverage):** screenshots or URLs the user genuinely loves (from *Siteinspire*, *Godly*, *DeadSimpleSites*, *Mobbin*, *Awwwards* — **ideally non-tech**: architecture, publishing, music, gaming, hospitality...) + 1 line on *what to extract* from each (e.g. *"Ref 1 = rhythm/margins, Ref 2 = palette, Ref 3 = typography"*).
2. **True scope & human signature detail:** minimal footprint (single view/scene) or broader exploration (multi-view) + **1 personal/interactive signature detail** that makes the site memorable (something an AI would never invent on its own).
3. **Assets & realism level:** real external assets (photos, HD textures, bespoke SVGs, real copywriting) from v1, or 100% procedural/generated?
4. **Execution mode & iteration budget:**
   - **Mockups / directions first, then code** *(recommended for redesigns)* — propose 2-3 distinct structural directions with trade-offs before touching code,
   - **Fast (2 targeted cycles)** — 1 major rework + 1 polish *(best quality-to-token ratio)*,
   - **Antigravity (`/goal`, 3-4 cycles)** — autonomous high-bar loop with browser subagent,
   - **Ralph Wiggum Loop (long-horizon CLI)** — external `while` loop with state file and `--max-iterations`.

> **Architecture rule (token efficiency):** always instruct the agent to split code into **small domain-focused modules** rather than a single monolithic file, so every visual iteration reads and edits minimal context.

## Step 2: Match the Recipe to the Visual Type

Select the matching craft guidelines and negative constraints:

| Project Type | References & Techniques to Inject | Anti-Patterns to Ban Explicitly |
|---|---|---|
| **UI / App / Dashboard** | **Paul Bakaus (Impeccable)** + **Emil Kowalski** principles: strict hierarchy, flat surfaces + `1px` borders, explicit color/spacing tokens, `empty / loading / error` states, `ease-out` micro-interactions (150-250ms) or spring physics | Default fonts (`Inter`, `Roboto`, `Space Grotesk`) with no rationale, generic indigo/purple dark-mode gradients, cards nested inside cards, symmetrical 4-card Bento grids, soft drop shadows everywhere, cluttered badges |
| **Website / Landing / Portfolio** | **Decomposed real-world references** (cross-industry/non-tech preferred), distinctive font pairing, **intentional imperfection** (mix sharp `0px` corners with organic shapes, break symmetry, alternate dense blocks with massive breathing room), **1 human signature detail**, real copywriting + bespoke media/SVG strategy | "Claude Code look" (default beige + terracotta + italic serif), generic hero ("headline + subhead + 2 buttons + 3 icon cards"), artificial uniformity (identical padding/border-radius on every box), empty marketing fluff, decorative emojis, gratuitous glassmorphism |
| **3D / WebGL / Shaders** | Three.js + custom GLSL shaders, `ACESFilmic` tone mapping, selective Bloom, clean multi-scale transitions without z-fighting, logarithmic/cinematic camera curves, 60 fps | "Plastic" primitive meshes without shaders, basic procedural noise instead of real textures, square confetti stars, robotic linear camera motion, cluttered debug UI over the scene |
| **Animation / Canvas / Generative** | Real physics (springs, damping, inertia), restrained palette (3-4 colors max), HiDPI (`devicePixelRatio`), `prefers-reduced-motion` support | Linear transitions (`linear`), harsh flashing, visual overload without hierarchy |

## Step 3: Build the Prompt (5 Mandatory Blocks)

Every generated prompt must include these 5 concrete sections (never leave generic placeholders unfilled):

### 1. Objective, Stack & Design-Before-Code Gate
- Exactly what to build, the expected visual experience, real copywriting/tone constraints, and the exact tech stack (e.g. React + CSS Modules, Tailwind, or Vite + TypeScript + Three.js + GLSL).
- **Exploration gate:** if no visual direction is locked yet, require the agent to propose **2-3 distinct layout directions** with explicit trade-offs (or visual mockups) and wait for human selection before refactoring code.
- Keep the UI minimal and purposeful (zero superfluous chrome).

### 2. Art Direction, Decomposed References & Embedded `DESIGN.md` Tokens
- **Decomposed visual references:** explicitly specify *what to take* and *what to ignore* from each reference screenshot/URL (never copy a whole site blindly).
- **Strict palette:** hex codes for background, surface, primary/secondary text, single accent + strict accent usage rule.
- **Typography, Asymmetry & Intentional Imperfection:** distinctive font pairing, explicit scale, deliberate variation in density and container geometry (never uniform `12px` rounded cards everywhere).
- **Human Signature Detail & Media Strategy:** define the **1 memorable, human/interactive touch** unique to the project + how photos, illustrations, or custom SVGs are sourced/crafted (no empty placeholders).
- **Motion & Micro-interactions (Emil Kowalski rules):** `ease-out` curves (`150-250ms`) for entrances and hovers, crisp natural timing, zero robotic linear motion, strict `prefers-reduced-motion` support.

### 3. Banned Anti-Patterns ("Anti-AI Slop" — Paul Bakaus + 2026 Clichés)
- 5 to 6 **project-specific** visual bans explicitly blocking the "Claude Code look", "v0/Linear Bento slop", banned default fonts (`Inter`, `Roboto`, `Space Grotesk` unless justified), nested cards, and artificial symmetry.

### 4. Generator-Evaluator Protocol & Visual Feedback Loop (Anthropic method)
- Explicitly forbid stopping at the first working prototype (treat v1 as a ~60% draft).
- Separate the **Generator** role (writes code) from a **Hostile Evaluator** role (inspects the real rendered output with fresh eyes via browser/Playwright — never self-certify from code alone).
- Specify **3 to 4 mandatory screenshots** tailored to the project (e.g. Desktop 1440px, Mobile 390px, interactive/hover state, or 4 key camera stages).
- **Strict 100-point rubric:** 5 concrete, verifiable criteria scored out of 20 each — explicitly including **Visual Distinctiveness & Personality (`/20`)** where a clean but generic AI template is capped at `14/20` — under a *default-FAIL* contract (no criterion passes without visual proof).

### 5. Quality Gates (70% / 95-99%) & Stop Condition
- **< 70%:** Critical failure — reject the current approach, diagnose the root cause, and rebuild cleanly.
- **70% - 94%:** Insufficient — explicitly list the **top 3 worst visual defects** observed in the captures and fix them in the next cycle.
- **>= 95% (or >= 99% in perfectionist mode)** with **every criterion >= 18/20** + **minimum 2-4 full capture/fix cycles**: cleared to ship with verified final captures.
- **Never write "work for 2 hours"** in clock time inside a single prompt — replace with iteration counts and verifiable quality gates.
- *If the user asks for **Ralph Wiggum Loop** mode:* append a short block specifying the state file (`prd.json` or `EVAL_LOG.md`), exit promise (`<promise>DONE</promise>`), and iteration cap (`--max-iterations 10`).

## Step 4: Delivery to the Use

1. Output the **final prompt inside a single copy-pasteable Markdown code block**.
2. For multi-page apps or sites, offer (or include directly) a companion **`DESIGN.md`** for the repository root.
3. Add one concise launch tip (e.g. *"Attach 2-3 reference screenshots from Siteinspire/Godly and run it with `/goal` in Antigravity"*).
