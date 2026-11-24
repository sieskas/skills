# Agent Skills

A curated collection of ready-to-use skills for AI coding and product agents (**Antigravity**, **Claude Code**, **Cursor**, **Codex**).

## Included Skills

| Skill | Description | File |
|---|---|---|
| **`ideation-saas`** | Generates original, monetizable feature, acquisition, and pricing ideas for SaaS products while bypassing LLM mode collapse (*Verbalized Sampling*, *CreativeDC* Divergence/Convergence separation, Ethan Mollick's anti-cliche blacklist, frameworks from Teresa Torres, Elena Verna, Kyle Poyar, Bob Moesta, Lenny Rachitsky, and Shreyas Doshi). | [`skills/ideation-saas/SKILL.md`](./skills/ideation-saas/SKILL.md) |
| **`prompt-design-visuel`** | Transforms a raw idea (UI/UX, landing page, animation, 3D/WebGL scene) into a complete anti-"AI slop" prompt with anti-rework framing, art direction, Anthropic's *Generator-Evaluator* loop, quality gates, and *Visual Feedback Loop*. | [`skills/prompt-design-visuel/SKILL.md`](./skills/prompt-design-visuel/SKILL.md) |
| **`webgl-threejs-craft`** | Battle-tested WebGL / Three.js / GLSL guardrails derived from real Windows GPU (ANGLE/Direct3D11) bugs: anti-`NaN` Bloom squares, opaque depth sorting + `renderOrder`, UV/mipmap seam prevention, shimmer-free starfields, linear ACES Filmic color calibration, and bubble-free `BackSide` atmospheres. | [`skills/webgl-threejs-craft/SKILL.md`](./skills/webgl-threejs-craft/SKILL.md) |

## Installation

### Antigravity (global)
Copy the desired skill folders into `~/.gemini/config/skills/`:
```bash
cp -r skills/ideation-saas skills/prompt-design-visuel skills/webgl-threejs-craft ~/.gemini/config/skills/
```

### Claude Code / Cursor / Codex (or per-project)
Copy the folders into `.agents/skills/` (or `.claude/skills/`) at your repository root, or run:
```bash
npx skills add sieskas/skills
```
