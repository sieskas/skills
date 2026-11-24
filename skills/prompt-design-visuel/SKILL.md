---
name: prompt-design-visuel
description: >-
  Génère des prompts ultra-structurés pour créer de beaux visuels, interfaces UI/UX,
  landing pages ou scènes 3D/WebGL avec des agents IA (Antigravity, Claude Code, Cursor, Codex).
  Intègre les techniques des références du design IA (Paul Bakaus / Impeccable, Emil Kowalski,
  DESIGN.md, boucle Generator-Evaluator d'Anthropic, seuils 70%/99%, Visual Feedback Loop et
  Ralph Wiggum Loop). À utiliser dès que l'utilisateur veut un prompt pour créer un beau visuel,
  un site, une interface, une animation ou une scène 3D avec un agent IA.
---

# Générateur de Prompts — Design Visuel & Agentique

Transforme une idée brute (interface, landing page, animation, scène 3D/WebGL) en un **prompt complet, exécutable et exigeant**, conçu pour empêcher les agents IA de produire du « AI slop » et les forcer à itérer visuellement jusqu'à un rendu de niveau studio.

## Étape 1 : Cadrage express (anti-refonte)

Si l'utilisateur a déjà répondu clairement à ces points dans sa demande, **générer directement le prompt** sans poser de questions inutiles.

Sinon, avant d'écrire la première ligne de code ou le prompt final, poser **en un seul message court** les questions manquantes parmi ces 4 axes (ce sont elles qui évitent 70 % des refontes coûteuses en tokens) :
1. **Portée réelle :** périmètre minimal (une seule vue/scène) ou exploration plus large (multi-vues, sous-éléments, interactions supplémentaires) ?
2. **Assets & niveau de réalisme :** vraies ressources externes (photos, textures HD, icônes/données réelles) dès la v1, ou 100 % généré/procédural ?
3. **Style des pièces maîtresses :** sobre/fidèle ou spectaculaire/stylisé (avec 1 référence visuelle concrète si possible) ?
4. **Mode d'exécution & budget d'itérations :**
   - **Rapide (2 cycles ciblés)** — 1 refonte majeure + 1 polish *(meilleur ratio qualité/tokens)*,
   - **Antigravity (`/goal`, 3–4 cycles)** — boucle autonome exigeante avec sous-agent navigateur,
   - **Ralph Wiggum Loop (CLI longue durée)** — boucle externe `while` avec fichier d'état et `--max-iterations`.

> **Règle d'architecture (économie de tokens) :** toujours structurer le prompt pour découper le code en **petits modules par domaine** plutôt qu'un gros fichier monolithique, afin que chaque itération visuelle coûte peu de contexte à relire et modifier.

## Étape 2 : Adapter la recette au type de projet

Choisir la grille technique et esthétique correspondante :

| Type de projet | Références & techniques à injecter | Anti-patterns à bannir explicitement |
|---|---|---|
| **UI / App / Dashboard** | Principes **Paul Bakaus (Impeccable)** + **Emil Kowalski** : hiérarchie stricte, surfaces planes + bordures `1px`, tokens couleurs/espacements, états `empty / loading / error`, micro-interactions `ease-out` (150–250 ms) ou ressorts physiques | Police Inter par défaut sans caractère, dégradés violet/bleu génériques, cartes imbriquées dans des cartes, ombres portées molles partout, boutons/badges surchargés |
| **Landing Page / Portfolio** | Direction artistique éditoriale marquée, paire typographique contrastée (display + body), rythme d'espacement généreux, focus sur un point focal par écran, animations subtiles au scroll | Hero générique « titre + sous-titre + 2 boutons + 3 cartes d'icônes », textes marketing creux, emojis décoratifs, glassmorphism gratuit |
| **Scène 3D / WebGL / Shaders** | Three.js + shaders GLSL custom, tone mapping `ACESFilmic`, post-processing dosé (Bloom sélectif), gestion multi-échelle sans z-fighting, courbes de caméra logarithmiques/cinématiques, 60 fps | Formes primitives « plastique » sans shader, bruit procédural basique à la place de vraies textures, particules carrées uniformes, caméra linéaire robotique, panneau UI chargé par-dessus la scène |
| **Animation / Canvas / Generative** | Physique réelle (springs, amortissement, inertie), palette restreinte (3–4 couleurs max), gestion HiDPI (`devicePixelRatio`), respect de `prefers-reduced-motion` | Transitions linéaires (`linear`), clignotements agressifs, surcharge visuelle sans hiérarchie |

## Étape 3 : Construire le prompt (architecture en 5 blocs)

Le prompt généré doit **toujours** contenir ces 5 sections, rédigées concrètement pour le projet demandé (jamais de placeholders génériques laissés vides) :

### 1. Objectif & Stack
- Ce qui doit être construit, le rendu attendu et la stack exacte (ex. React + Tailwind + shadcn/ui, ou Three.js + GLSL + Vite).
- Garder une UI sobre et fonctionnelle (pas d'éléments superflus).

### 2. Direction Artistique & Tokens (`DESIGN.md` intégré)
- **Références visuelles concrètes** (ex. Linear, Stripe, Teenage Engineering, SpaceEngine, NASA Eyes…).
- **Palette précise** (codes hex pour fond, surface, texte principal/secondaire, accent unique + règle d'usage strict de l'accent).
- **Typographie & rythme** (polices, hiérarchie, espacements, border-radius).
- **Mouvement & Micro-interactions (règles Emil Kowalski)** : courbes `ease-out` pour les entrées, transitions rapides et naturelles, zéro mouvement linéaire robotique.

### 3. Anti-patterns interdits (« Anti-AI Slop » — règles Paul Bakaus)
- 4 à 6 interdits visuels **spécifiques au projet** pour couper court aux raccourcis classiques des LLM.

### 4. Protocole Generator – Evaluator & Boucle Visuelle (méthode Anthropic)
- Interdire formellement de s'arrêter au premier prototype fonctionnel (le qualifier explicitement de brouillon ~60 %).
- Séparer le rôle **Générateur** (qui code) et le rôle **Évaluateur sceptique / hostile** (qui inspecte le rendu réel avec un regard neuf, via navigateur/Playwright — jamais d'auto-validation sur le seul code).
- Lister **3 à 4 captures d'écran obligatoires** adaptées au projet (ex. Desktop 1440px, Mobile 390px, État interactif/hover, ou 4 étapes précises d'une animation/caméra 3D).
- **Grille de notation sur 100** : 5 critères concrets et vérifiables notés chacun sur 20, avec contrat *default-FAIL* (un critère n'est validé que preuve visuelle à l'appui).

### 5. Quality Gates (70 % / 95–99 %) & Condition de fin
- **< 70 %** : échec critique → rejeter l'approche actuelle, diagnostiquer la cause racine et reconstruire proprement.
- **70 % – 94 %** : insuffisant → lister impérativement les **3 pires défauts visuels** observés sur les captures et les corriger dans le cycle suivant.
- **≥ 95 % (ou ≥ 99 % si mode perfectionniste)** avec **chaque critère ≥ 18/20** + **minimum 3 à 4 cycles complets** de capture/correction : autorisation de livrer avec les captures finales vérifiées.
- **Zéro mention de « travaille 2h »** en temps horloge dans un prompt unique : remplacer par un nombre d'itérations et des critères vérifiables.
- *Si l'utilisateur demande le mode **Ralph Wiggum Loop*** : ajouter en plus un bloc court avec le fichier d'état (`prd.json` ou `EVAL_LOG.md`), la condition de sortie (`<promise>DONE</promise>`) et un plafond d'itérations (`--max-iterations 10`).

## Étape 4 : Livraison à l'utilisateur

1. Présenter le **prompt final dans un seul bloc de code Markdown** prêt à copier-coller.
2. Si le projet est une app ou un site multi-pages, proposer (ou fournir directement si pertinent) le **`DESIGN.md`** associé à placer à la racine du dépôt.
3. Ajouter une ligne pratique sur la meilleure façon de le lancer (ex. *« Lance-le avec `/goal` dans Antigravity pour activer la boucle autonome longue »*).
