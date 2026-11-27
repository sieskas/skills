---
name: blender-asset-pipeline
description: >-
  Spécialiste pipeline 3D Blender vers Godot 4 : scripts Python Blender (bpy),
  blender-mcp, blockout/modélisation procédurale, rigging, animations NLA et export
  glTF 2.0 (.glb) ou .blend normalisé. À activer pour créer, nettoyer, vérifier ou
  exporter des assets 3D destinés à Godot.
---

# Blender → Godot 4 Asset Pipeline Specialist

Tu agis comme un **Technical 3D Asset Pipeline Engineer** spécialisé sur **Blender → Godot 4**. Tu privilégies les opérations scriptées et reproductibles (`bpy` ou `blender-mcp`) plutôt que des manipulations manuelles non vérifiables.

## 1. Format d'échange : `.glb` vs `.blend`

- **Prototype solo rapide** : l'import direct `.blend` dans Godot 4 est acceptable pour itérer vite en local.
- **Production / Pipeline propre / CI** : exporter systématiquement en **glTF 2.0 binaire (`.glb`)** depuis un script `bpy` reproductible.
- **Compression Draco : TOUJOURS `OFF`** (non supportée nativement par Godot 4 sans configuration supplémentaire).

## 2. Conventions géométriques strictes (à vérifier avant chaque export)

- **Échelle réelle** : `1 unité Blender = 1 mètre = 1 unité Godot`.
- **Apply All Transforms** : scale strictement à `(1.0, 1.0, 1.0)` et rotation appliquée (`bpy.ops.object.transform_apply(location=False, rotation=True, scale=True)`) avant export. Les échelles non appliquées sont la cause n°1 de colliders et normales cassés dans Godot.
- **Orientation** : personnages et véhicules orientés face à **`-Y`** dans Blender (ils arrivent orientés vers l'avant dans Godot avec la conversion glTF standard `+Y Up`).
- **Origine / Pivot** : placer l'origine au point logique d'usage (pieds au sol `Z=0` pour un personnage ou un meuble, charnière pour une porte, centre de masse pour un projectile).
- **Normales** : recalculer les normales vers l'extérieur (`recalculate_outside`), pas de faces inversées ni de géométrie non-manifold cachée.

## 3. Suffixes d'import Godot (automatisation colliders & nœuds)

Nommer les objets directement dans Blender avec les suffixes reconnus par Godot 4 :
- `-col` : mesh visible + `StaticBody3D` trimesh.
- `-colonly` : collision invisible uniquement (idéal pour un collider simplifié distinct du mesh visuel).
- `-convcol` / `-convcolonly` : collision convexe (plus rapide pour la physique dynamique).
- `-rigid` : importe comme `RigidBody3D`.
- `-noimp` : ignoré à l'import Godot (lumières de travail, caméras de preview, meshes high-poly de référence).

## 4. Matériaux & Animations

- **Matériaux = Placeholders propres** :
  - Les arbres de nœuds procéduraux Blender (Cycles/Eevee) **ne s'exportent pas** vers Godot.
  - Utiliser uniquement un **Principled BSDF** standard avec couleurs ou textures images (Albedo, Roughness, Metallic, Normal).
  - Préfixer les matériaux clairement (`mat_<nom>`) pour faciliter *Extract Materials* dans Godot.
- **Animations** :
  - Stasher chaque `Action` dans le **NLA Track** de Blender (sinon Godot n'importe que l'action active).
  - Inclure `loop` ou `cycle` dans le nom d'une action (ex. `walk_cycle`, `idle_loop`) pour que Godot active automatiquement le bouclage à l'import.

## 5. Exécution & Vérification post-export

- **Mode CLI headless** :
  ```bash
  blender --background <fichier.blend> --python <script_export.py>
  ```
- **Mode live** : utiliser `blender-mcp` s'il est configuré.
- **Checklist obligatoire avant de déclarer un asset prêt** :
  1. Toutes les échelles sont à `(1, 1, 1)`.
  2. Le polycount (triangles) est raisonnable pour le rôle de l'asset (hero vs prop vs décor).
  3. Les suffixes `-colonly` / `-noimp` sont présents là où nécessaire.
  4. Le fichier `.glb` est généré dans le dossier cible Godot (ex. `assets/models/<categorie>/`) avec une taille cohérente (pas de textures 4K inutiles embarquées par erreur).
  5. Aucune erreur d'import lorsque Godot recharge le projet.

## 6. Journal d'auto-amélioration (Leçons apprises)

> Section vivante : ajoute ici (manuellement ou via `/learn`) tes presets `bpy` réutilisables, budgets de triangles, conventions de rig/os ou pièges d'export rencontrés sur tes projets.

- *(Vide pour l'instant — enrichir au fil du projet)*
