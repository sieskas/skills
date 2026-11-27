---
name: figma-rapid-mockup
description: >-
  Conçoit et produit des maquettes Figma de niveau studio en temps record (mode hackathon,
  sprint produit ou démo client) en combinant les références d'apps réelles Mobbin, le MCP
  Figma (création/édition directe de frames, Variables et Auto Layout) et les meilleures
  pratiques d'experts UI/UX anti-"AI slop". À activer dès que l'utilisateur veut maquetter
  rapidement une app, un SaaS, un dashboard ou un prototype cliquable dans Figma avec
  Mobbin, préparer une démo de hackathon, ou passer d'une idée à des écrans Figma crédibles.
---

# Figma Rapid Mockup (Workflow Experts Hackathon : Mobbin + Figma MCP)

Transforme une idée brute en **maquettes Figma propres, éditables et bluffantes** en un minimum de temps, en combinant :
- **Mobbin** pour s'ancrer sur des patterns d'apps réelles (jamais de page blanche ni de moyenne statistique "AI slop"),
- **Figma MCP** (`use_figma` / `generate_figma_design` / lecture de tokens) pour construire et itérer directement sur le canvas avec de vrais **Variables** et **Auto Layout**,
- **La discipline Hackathon** : un seul parcours clé irréprochable avec de vraies données métier.

---

## Prérequis & Vérification d'outils (Pre-flight)

Avant de démarrer, vérifier quels outils MCP sont actifs dans la session :
1. **Plugin Figma** (`figma`) : nécessaire pour lire/créer/modifier les frames, Variables et composants directement sur le canvas Figma.
2. **Plugin Mobbin** (`mobbin`) : nécessaire pour rechercher et décomposer de vrais écrans d'apps de référence.

- Si l'un des plugins n'est pas encore activé ou connecté, le signaler clairement à l'utilisateur en 1 phrase (et lui proposer soit de l'activer d'abord, soit de continuer en mode dégradé : brief structuré + tokens + layout prêt pour Figma Make / HTML-to-Figma).

---

## Phase 1 : Cadrage Express — Le « Vertical Slice » (2 min)

Ne jamais maquetter une application entière en mode rapide. Si l'utilisateur n'a pas déjà précisé ces points, poser **en un seul message court** uniquement les questions manquantes :

1. **Parcours clé (*Happy Path*)** : quel est **l'unique flux de 3 à 5 écrans** qui prouve la valeur du produit ? *(Bannir Login, Forgot Password, Settings, CGU en v1.)*
2. **Format cible** : Web App Desktop (`1440×900`), Mobile (`390×844` iOS), ou Landing + 1 écran produit ?
3. **Ton & 1 détail signature** : quelle ambiance (ex. *outil pro dense type Linear/Raycast*, *éditorial chaleureux*, *fintech sobre*) et **1 détail mémorable** qui distingue le produit ?
4. **Fichier Figma cible** : URL d'un fichier Figma existant (avec ou sans UI Kit déjà importé) ou création dans un nouveau fichier ?

---

## Phase 2 : Ancrage Visuel via Mobbin (Zéro page blanche)

Ne jamais inventer un layout à partir d'adjectifs vagues (*« moderne, clean, épuré »*).

1. Interroger **Mobbin** sur le type d'écran exact du parcours clé (ex. *onboarding step*, *AI chat workspace*, *analytics dashboard*, *mobile booking flow*).
2. Sélectionner **2 à 3 références réelles** et les **décomposer explicitement** avant de dessiner :
   - **Réf 1 — Architecture & densité** : structure de navigation, grille, hiérarchie de l'information.
   - **Réf 2 — Composants & micro-patterns** : forme des cartes, tableaux, filtres, barres d'action.
   - **Réf 3 — Rythme & respiration** : marges, contraste surface/fond, traitement typographique.
3. Présenter cette mini-planche de direction en 5 lignes à l'utilisateur (ou enchaîner directement s'il est en mode sprint autonome).

> **Règle d'or :** on extrait des **patterns UX éprouvés**, on ne copie jamais l'identité ni la marque d'une référence.

---

## Phase 3 : Fondation Tokens & Architecture Figma (5 min)

Avant de dessiner le premier écran, poser une base propre dans Figma pour que toute modification globale prenne 5 secondes :

### 1. Structure des pages du fichier Figma
- `📌 00 Cover` — vignette propre (nom du projet, date, statut).
- `🚀 01 Demo Flow` — uniquement les **3 à 5 écrans finaux** du parcours clé, alignés de gauche à droite.
- `🧩 02 Tokens & Components` — composants maîtres réutilisables (Header, Sidebar, Card, Button, Input, Badge).
- `🧪 03 Sandbox` — brouillons et variantes exploratoires (jamais dans la présentation).

### 2. Verrouillage des Variables Figma (Zéro valeur en dur)
Définir immédiatement les **Variables** (ou réutiliser celles du UI Kit présent dans le fichier — *shadcn/ui*, *Untitled UI*, *Tailwind*) :
- **Couleurs** : `bg/canvas`, `bg/surface`, `bg/surface-subtle`, `border/default`, `text/primary`, `text/secondary`, `accent/primary`, `status/success|warning|danger`.
- **Échelle d'espacement (`8px` grid)** : `4, 8, 12, 16, 24, 32, 48, 64`.
- **Rayons (`radius`)** : cohérents par niveau (ex. `6px` inputs/boutons, `12px` cartes, `999px` pills).
- **Typographie** : 1 famille principale (ou 1 paire lisible Display + Sans), 4–5 niveaux max (`Display`, `H1`, `H2`, `Body`, `Caption/Mono`). Éviter `Inter`/`Roboto` par défaut sans justification si le produit cherche une identité forte.

---

## Phase 4 : Construction Rapide sur le Canvas Figma

Construire **l'écran héros (écran #1 du parcours)** en premier, le valider visuellement, puis dérouler les 2 à 4 écrans suivants.

### Règles de construction non-négociables
1. **Auto Layout partout (`Shift + A`)** : chaque section, carte, liste, barre d'outils et bouton doit utiliser Auto Layout avec `Fill container` / `Hug contents` correctement configurés. Zéro positionnement absolu fragile (sauf badges/overlays justifiés).
2. **Composants maîtres + Properties** : privilégier **1 composant propre** avec *Text*, *Boolean* et *Instance Swap* properties plutôt que d'exploser le fichier en 30 variants.
3. **Zéro « Lorem Ipsum »** : injecter 100 % de **vraies données métier crédibles** (vrais prénoms, vrais montants/métriques, vrais statuts, micro-copy soignée). Les juges et clients jugent la crédibilité produit sur le réalisme du contenu.
4. **États réalistes** : si un écran contient une action IA, une recherche ou une liste, montrer un état rempli réaliste (et prévoir au besoin 1 état actif/sélectionné pour rendre le prototype vivant).
5. **Anti-"AI Slop" strict & Imperfection intentionnelle** :
   - **Bannir le « Claude Code look »** : beige/crème + terracotta/rouille + titres serif en italique + cartes `1px` uniformément arrondies partout.
   - **Bannir le « v0 / Linear Bento slop »** : fond noir ardoise + halos indigo/violet + grilles Bento 4 colonnes parfaitement symétriques sans hiérarchie + cartes imbriquées dans des cartes + ombres portées molles partout + badges décoratifs inutiles.
   - **Privilégier le craft** : surfaces propres + bordures `1px` subtiles, **variation assumée de densité et de géométrie** (alterner zones denses et grandes respirations), 1 point focal évident par écran et **1 détail signature humain** qu'une IA n'inventerait pas seule.

---

## Phase 5 : Boucle Generator-Evaluator & Audit Visuel (*Hostile Design Review*)

Ne jamais s'arrêter au premier jet (traiter la v1 comme un brouillon à ~60 %). Séparer mentalement le rôle **Generator** (construit sur Figma) du rôle **Hostile Evaluator** (inspecte les **captures réelles des frames Figma** avec un œil critique — contrat *default-FAIL* : aucun critère ne passe sans preuve visuelle).

### Grille de notation stricte (`/100` — 5 critères sur 20)
1. **Clarté & Test des 3 secondes (`/20`)** : un jury ou client comprend immédiatement la proposition de valeur et l'action principale de l'écran.
2. **Hiérarchie, Grille `8px` & Auto Layout (`/20`)** : espacements cohérents sur la grille `8px`, zéro alignement approximatif, zéro texte tronqué, Auto Layout propre.
3. **Cohérence Tokens & Contraste WCAG AA (`/20`)** : zéro hex isolé hors Variables Figma, contraste `>= 4.5:1` (texte) et `>= 3:1` (grands titres / contrôles UI).
4. **Réalisme métier (`/20`)** : zéro *Lorem Ipsum*, zéro *User 1*, données/métriques/micro-copy crédibles comme un produit déjà lancé.
5. **Distinctivité & Personnalité (`/20`)** : présence du détail signature, identité mémorable, zéro cliché IA. **Plafond strict à `14/20`** si la maquette est « propre » mais ressemble à un template IA générique.

### Quality Gates & Condition d'arrêt
- **`< 70 / 100`** : échec critique — rejeter la direction actuelle, diagnostiquer la cause racine (layout, densité ou palette) et reconstruire proprement.
- **`70 – 94 / 100`** : insuffisant — lister explicitement les **3 pires défauts visuels** observés sur les captures Figma, puis les corriger dans le cycle suivant.
- **`>= 95 / 100`** avec **chaque critère `>= 18/20`** et **minimum 2 cycles capture/correction** : validé pour le pitch.

### Finalisation Démo / Pitch (une fois `>= 95%`)
- Configurer **1 seul Flow Starting Point** nommé `Demo Flow` sur `🚀 01 Demo Flow`.
- Garder des transitions sobres (*Instant*, *Dissolve*, ou *Smart Animate* sur 2–3 transitions clés max).
- Ordonner les frames de gauche à droite pour raconter l'histoire produit sans friction.

---

## Phase 6 : Pont Figma → Code & `DESIGN.md` (Optionnel)

Si l'utilisateur souhaite passer à l'implémentation après validation des maquettes :
1. **Exporter un `DESIGN.md`** à la racine du projet à partir des Variables Figma validées (palette, échelle typographique, rayons, espacements, règles anti-slop et détail signature) — directement compatible avec le skill `prompt-design-visuel`.
2. Lire les frames validées via **Figma MCP** (arbre Auto Layout + Variables + captures).
3. Implémenter le même *Vertical Slice* écran par écran en préservant strictement la hiérarchie, les espacements et les vraies données validées dans Figma.
