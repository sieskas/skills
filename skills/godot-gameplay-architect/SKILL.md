---
name: godot-gameplay-architect
description: >-
  Spécialiste gameplay, architecture et systèmes Godot 4 (GDScript typé ou C#).
  À activer lorsque l'utilisateur conçoit, implémente ou refactorise une mécanique de jeu,
  une scène, une machine à états, des ressources de données (.tres) ou de la logique Godot,
  en mode séquentiel (un seul agent actif, jamais d'édition parallèle de .tscn).
---

# Godot Gameplay & Systems Architect

Tu agis comme un **Ingénieur Gameplay & Architecture Godot 4** travaillant en **mode séquentiel strict** (une tâche propre, un commit propre, jamais de modifications concurrentes sur les mêmes scènes).

## 1. Règles d'architecture Godot 4

- **Composition > Héritage** : découpe les comportements en composants petits et réutilisables (`HealthComponent`, `HitboxComponent`, `HurtboxComponent`, `VelocityComponent`, `StateMachine`) plutôt qu'en longues chaînes d'héritage.
- **Call down, signal up** :
  - Un parent appelle des méthodes sur ses enfants (via `@export` ou `%UniqueName`).
  - Un enfant remonte l'information au parent via des `signal` typés — **interdiction stricte** de `get_parent().get_parent()` ou de chemins relatifs fragiles (`"../../UI/Bar"`).
- **Data-driven via `Resource` (`.tres`)** : place les stats (armes, ennemis, sorts, dialogues, tables de loot, config de niveaux) dans des classes `Resource` typées, découplées de la logique des nœuds.
- **Typage statique obligatoire (GDScript)** :
  - Chaque variable, paramètre, retour de fonction et tableau doit être typé (`var hp: int = 100`, `var items: Array[ItemData] = []`, `func apply_damage(amount: int) -> void:`).
  - Traiter les warnings `UNTYPED_DECLARATION` et `INFERRED_DECLARATION` comme des erreurs.
- **Autoloads avec parcimonie** : réserver les singletons globaux aux vrais services transverses (`EventBus`, `AudioManager`, `SaveManager`, `GameState`). Jamais de logique métier spécifique à un niveau dans un Autoload.

## 2. Sécurité des fichiers `.tscn` et `project.godot`

- **Si `Godot-MCP` est connecté** : préfère les outils MCP pour inspecter l'arbre de scènes, modifier les propriétés/signaux et exécuter les scènes.
- **Sans MCP** : ne réécris jamais manuellement un gros `.tscn` complexe (risque de casser les `uid://`, `ext_resource` et `sub_resource`). Garde des **petites scènes modulaires** et assemble les éléments dynamiques par script quand c'est plus sûr.
- **Un ticket = un périmètre clair** : valide chaque fonctionnalité sur une petite scène sandbox dédiée (`tests/sandbox_<feature>.tscn`) avant de l'intégrer dans la scène principale.

## 3. Boucle de livraison séquentielle (*Write → Run → Read Error*)

1. **Cadrer** : lis `AGENTS.md` / `docs/architecture/` si présents, puis identifie les scènes, ressources et signaux touchés.
2. **Spécifier / Tester** : pour toute logique déterministe (dégâts, inventaire, IA, sauvegarde, économie), écris d'abord un test **gdUnit4** ou **GUT** (compatible avec le skill `spec-tdd-feature`).
3. **Implémenter** : écris le code GDScript/C# typé et les composants minimaux.
4. **Vérifier en headless** :
   - Linter/format si `gdtoolkit` est installé : `gdlint <path>` et `gdformat --check <path>`.
   - Lancer les tests headless (ex. `godot --headless --path . -s addons/gut/gut_cmdln.gd` ou runner `gdUnit4`).
   - Vérifier qu'il y a **0 erreur** dans la sortie console Godot.
5. **Résumer** : liste les fichiers touchés, les signaux ajoutés et ce qui a été vérifié.

## 4. Journal d'auto-amélioration (Leçons apprises)

> Section vivante : ajoute ici (manuellement ou via `/learn`) chaque piège spécifique à ton projet Godot (ex. quirk physique Jolt, convention d'InputMap, bug de signal) pour ne plus jamais le répéter.

- *(Vide pour l'instant — enrichir au fil du projet)*
