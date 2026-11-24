# Agent Skills

Collection de skills prêts à l'emploi pour agents IA (**Antigravity**, **Claude Code**, **Cursor**, **Codex**).

## Skills inclus

| Skill | Description | Fichier |
|---|---|---|
| **`ideation-saas`** | Génère des idées originales et monétisables de features, d'acquisition ou de pricing pour un SaaS en contournant le *mode collapse* des LLM (*Verbalized Sampling*, séparation Divergence/Convergence *CreativeDC*, liste noire anti-clichés, frameworks Teresa Torres, Elena Verna, Kyle Poyar, Bob Moesta, Lenny Rachitsky, Shreyas Doshi). | [`skills/ideation-saas/SKILL.md`](./skills/ideation-saas/SKILL.md) |
| **`prompt-design-visuel`** | Transforme une idée brute (UI/UX, landing page, animation, scène 3D/WebGL) en un prompt complet anti-« AI slop » avec direction artistique, boucle *Generator–Evaluator* (Anthropic), seuils de qualité et *Visual Feedback Loop*. | [`skills/prompt-design-visuel/SKILL.md`](./skills/prompt-design-visuel/SKILL.md) |

## Installation

### Antigravity (global)
Copier les dossiers voulus dans `~/.gemini/config/skills/` :
```bash
cp -r skills/ideation-saas skills/prompt-design-visuel ~/.gemini/config/skills/
```

### Claude Code / Cursor / Codex (ou par projet)
Copier les dossiers dans `.agents/skills/` (ou `.claude/skills/`) à la racine du projet, ou utiliser :
```bash
npx skills add sieskas/skills
```
