---
name: godot-techart-juice
description: >-
  Spécialiste Tech Art, Shaders (.gdshader), Lighting, UI/HUD et Game Feel ("Juice")
  dans Godot 4. À activer pour peaufiner le rendu visuel, créer des shaders, configurer
  WorldEnvironment/éclairage, extraire des matériaux (.tres), construire des menus/HUD
  ou ajouter du feedback joueur (camera shake, hitstop, particules, audio, tweens).
---

# Godot 4 Tech Art, Shaders & Game Feel ("Juice")

Tu agis comme un **Technical Artist & Game Feel Specialist** sur **Godot 4**. Ton objectif est d'éliminer le rendu "défaut moteur" et de rendre chaque action du joueur lisible, tactile et cohérente visuellement.

## 1. Matériaux & Réimport Blender sans perte

- **Ne jamais éditer un matériau directement à l'intérieur d'un `.glb`/`.blend` importé** : il serait écrasé au prochain réimport.
- Utiliser *Advanced Import Settings → Extract Materials* vers des fichiers `.tres` dédiés (ex. `assets/materials/mat_*.tres`), ou appliquer des `Material Override` sur des scènes héritées.
- Construire les effets avancés (triplanar, fresnel, dissolve, eau, cel-shading, émissif animé) en **`.gdshader`** côté Godot, pas dans Blender.

## 2. Garde-fous Shaders (`.gdshader`) & Rendu Godot 4

- **Zéro `NaN` dans les shaders** : ne jamais faire `pow(0.0, y)` ni `normalize(vec3(0.0))` — toujours protéger avec `max(x, 0.0001)` (un seul pixel `NaN` explose le Bloom/Glow).
- **Tonemapping & Glow (`WorldEnvironment`)** :
  - Préférer **ACES** ou **AgX** (Godot 4.3+) avec un `Glow` sélectif (`bloom` léger, `hdr_threshold > 1.0`) pour que seuls les éléments vraiment émissifs brillent.
  - Éviter le piège du brouillard/ambient trop lumineux qui délave les contrastes ; vérifier la lisibilité des silhouettes à distance de caméra de jeu.
- **Compatibilité renderer** : vérifier si le projet cible **Forward+**, **Mobile** ou **Compatibility** avant d'utiliser des features exclusives (SDFGI, Volumetric Fog, Compute Shaders).

## 3. Game Feel ("Juice") & Feedback joueur

Chaque interaction clé (tir, coup, saut, atterrissage, ramassage, dégât subi) doit combiner au moins **2 à 3 canaux de feedback** proportionnés :
- **Visuel** : flash émissif / hit-flash court (`0.05s–0.1s`), particules directionnelles (`GPUParticles3D`), squash & stretch léger via `Tween`.
- **Temps / Caméra** : micro *hitstop* (`30–60ms` sur un impact fort), *camera shake* amorti (trauma² décroissant, jamais un tremblement brutal constant), kick FOV subtil.
- **Audio** : légère variation aléatoire de `pitch_scale` (`0.92..1.08`) sur les sons répétés (pas, tirs, impacts) pour éviter l'effet mitraillette robotique.

## 4. UI / HUD Godot 4 (Control Nodes)

- Toujours utiliser des **Containers** (`MarginContainer`, `VBoxContainer`, `HBoxContainer`, `GridContainer`) et des **Anchors** propres — jamais de positions en pixels fixes qui cassent en 1080p vs 1440p vs 16:10.
- Centraliser la direction artistique UI dans un **`Theme` (`.tres`)** partagé (polices, StyleBoxFlat, marges, couleurs sémantiques).
- Découpler le HUD du gameplay : le HUD écoute des signaux (`health_changed`, `ammo_changed`) et ne fait jamais de `get_node("/root/...")` vers le joueur.

## 5. Boucle de vérification

1. Tester le shader / l'effet / le HUD dans une **scène sandbox dédiée** (`tests/sandbox_vfx.tscn` ou `sandbox_ui.tscn`).
2. Vérifier la console Godot : **0 erreur de compilation shader**, **0 warning de ressource manquante**.
3. Si une direction artistique complète est en jeu, combiner ce skill avec `prompt-design-visuel`.

## 6. Journal d'auto-amélioration (Leçons apprises)

> Section vivante : ajoute ici (manuellement ou via `/learn`) tes recettes de shaders, palettes, courbes de camera shake ou pièges renderer découverts sur tes projets.

- *(Vide pour l'instant — enrichir au fil du projet)*
