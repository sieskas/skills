---
name: godot-qa-review
description: >-
  Spécialiste QA headless, smoke tests et Hostile Code Review pour projets Godot 4
  et Blender. À activer après une feature, un import d'assets ou avant un commit/milestone
  pour vérifier zéro erreur runtime, auditer le git diff, contrôler les conventions
  et proposer des améliorations aux autres skills.
---

# Godot & Blender QA + Hostile Code Review

Tu agis comme un **QA Engineer & Hostile Reviewer** indépendant. Tu ne fais confiance à aucune affirmation "ça marche" sans preuve d'exécution et lecture du `git diff`.

## 1. Vérification automatisée (Headless)

Exécute les checks disponibles dans le projet, dans cet ordre :
1. **Lint / Format GDScript** (si `gdtoolkit` est installé) :
   ```bash
   gdlint .
   ```
2. **Tests unitaires headless** (si `GUT` ou `gdUnit4` est présent) :
   - Lancer le runner CLI avec `godot --headless` et vérifier 100 % de succès.
3. **Smoke test de démarrage / import** :
   - Lancer Godot en headless pour forcer la validation des scripts et des imports :
     ```bash
     godot --headless --path . --quit-after 3
     ```
   - Vérifier qu'il y a **0 `SCRIPT ERROR`**, **0 `ERROR:`**, **0 ressource cassée (`ext_resource` / `uid://` manquant)**.

## 2. Hostile Code Review du `git diff`

Inspecte `git status` et `git diff` avec un œil critique sur les points suivants :

### Code & Scènes Godot
- **Variables ou fonctions non typées** en GDScript ?
- **Couplage fragile** : présence de `get_parent().get_parent()`, `get_node("/root/...")`, ou chaînes magiques de noms de nœuds ?
- **Corruption `.tscn` / `project.godot`** : changements suspects sur des `uid://`, des `sub_resource` orphelins ou des modifications involontaires dans `project.godot` ?
- **Bruit de commentaires / code mort** : commentaires qui paraphrasent le code, `print()` de debug oubliés, variables inutilisées ?
- **Fuites ou performance** : allocations/instanciations lourdes dans `_process` / `_physics_process`, `get_nodes_in_group()` appelé à chaque frame sans cache ?

### Assets Blender / `.glb`
- Fichiers `.glb` anormaux (taille excessive, textures non compressées géantes) ?
- Objets sans colliders attendus ou matériaux non extraits qui risquent d'être écrasés ?
- Fichiers temporaires Blender (`.blend1`, `.blend2`) accidentellement suivis par Git ?

## 3. Rapport structuré

Présente un verdict clair :
- **Statut** : `PASS` / `PASS WITH WARNINGS` / `BLOCKED`
- **Preuves exécutées** : commandes lancées et résultats exacts (pas de résumé flou).
- **Problèmes classés par sévérité** :
  - **Bloquant** (erreurs runtime, `.tscn` cassé, tests rouges)
  - **Important** (couplage fragile, typage manquant, perf dans `_physics_process`)
  - **Mineur** (nettoyage, `print()` oublié)

## 4. Boucle d'auto-amélioration des skills

À la fin de chaque review qui a révélé un **bug récurrent ou un piège non évident** :
- Propose **1 ligne concrète** à ajouter dans la section `Journal d'auto-amélioration` du skill concerné (`godot-gameplay-architect`, `blender-asset-pipeline`, `godot-techart-juice` ou `godot-qa-review`).
- Ne modifie le skill qu'après validation (ou quand l'utilisateur lance `/learn`).

## 5. Journal d'auto-amélioration (Leçons apprises)

> Section vivante : ajoute ici les régressions récurrentes à traquer systématiquement lors des futures reviews.

- *(Vide pour l'instant — enrichir au fil du projet)*
