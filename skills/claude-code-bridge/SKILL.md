---
name: claude-code-bridge
description: Délègue les tâches de code depuis Antigravity (gestion de projet, recherche, specs, assets) vers Claude Code en utilisant le binaire claude.exe de Claude Desktop (sessions partagées visibles dans Claude Desktop via /resume) ou en mode handoff presse-papiers vers la fenêtre Claude Desktop. À utiliser dès que l'utilisateur demande d'envoyer une tâche à Claude Code, de faire coder Claude, ou de passer le relais à Claude Desktop.
---

# Pont Antigravity → Claude Code / Claude Desktop

Ce skill permet de répartir les rôles sans copier-coller manuel :
- **Antigravity (Gemini)** : gestion de projet, recherche, architecture, specs, design/assets, revue de `git diff`, tests navigateur.
- **Claude Code** : implémentation du code dans le dépôt cible.

Le script utilise le **même binaire `claude.exe` que Claude Desktop** (`%LOCALAPPDATA%\Claude-Data\claude_*\claude-code\...\claude.exe`, ou `claude` dans le `PATH`). Les sessions créées sont donc stockées dans `~/.claude/projects/` et **reprises à tout moment dans l'onglet Code de Claude Desktop** avec `/resume`.

## Script utilitaire

Chemin : `%USERPROFILE%\.gemini\config\skills\claude-code-bridge\scripts\invoke-claude.ps1`

## Les 2 modes disponibles

### Mode 1 — `auto` (par défaut, zéro copier-coller)
Exécute Claude Code en arrière-plan sur le dépôt, récupère le résultat JSON + `session_id`, et laisse la session disponible dans Claude Desktop (`/resume`).

1. **Rédiger un brief autonome** dans `<repo>\.agent-bridge\current-task.md` :
   - Objectif clair et périmètre exact (fichiers à créer/modifier, fichiers à ne pas toucher).
   - Contraintes techniques, architecture, maquettes/assets produits par Antigravity.
   - Critères de fin et commandes de vérification attendues (tests, build, lint).
   *(Le script ajoute automatiquement `.agent-bridge/` à `.git/info/exclude` pour garder `git status` propre.)*

2. **Lancer Claude Code** :
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\.gemini\config\skills\claude-code-bridge\scripts\invoke-claude.ps1" `
     -Mode auto `
     -Repo "C:\chemin\du\projet" `
     -TaskFile "C:\chemin\du\projet\.agent-bridge\current-task.md" `
     -Name "[AGY] Nom court de la tache"
   ```

   Options utiles :
   - `-Resume "<session_id>"` : poursuit la **même session** Claude Code (pour corrections après revue).
   - `-PermissionMode "acceptEdits"` *(défaut)* : autorise les éditions de fichiers sans bloquer.
   - `-MaxTurns 25` *(défaut)* : garde-fou contre les boucles infinies et la consommation de quota.
   - `-Model "sonnet"` ou `"opus"` *(optionnel)* : force un modèle précis.

3. **Vérifier après exécution** :
   - Lire le JSON retourné (`session_id`, `result`, `is_error`).
   - Vérifier `git status` et `git diff --stat` dans le dépôt.
   - Si une correction est nécessaire, relancer avec `-Resume <session_id>`.
   - Rapporter à l'utilisateur le résumé + le `session_id` (et lui rappeler qu'il peut taper `/resume` dans l'onglet Code de Claude Desktop pour reprendre la main visuellement).

---

### Mode 2 — `handoff` (piloter en direct dans l'interface Claude Desktop)
À utiliser quand l'utilisateur veut voir Claude Desktop travailler en direct (ou lorsque le protocole `claude://` MSIX ne répond pas).

1. Rédiger le brief complet dans `<repo>\.agent-bridge\current-task.md`.
2. Lancer le script en mode `handoff` :
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\.gemini\config\skills\claude-code-bridge\scripts\invoke-claude.ps1" `
     -Mode handoff `
     -Repo "C:\chemin\du\projet" `
     -TaskFile "C:\chemin\du\projet\.agent-bridge\current-task.md"
   ```
3. Le script :
   - s'assure que `.agent-bridge/` est exclu localement de Git (`.git/info/exclude`),
   - copie automatiquement dans le presse-papiers Windows le court prompt prêt à coller (`Lis .agent-bridge/current-task.md et exécute la tâche...`),
   - amène la fenêtre **Claude Desktop** au premier plan.
4. L'utilisateur n'a plus qu'à faire `Ctrl+V` puis `Entrée` dans l'onglet Code de Claude Desktop.

## Règles de qualité du brief
- Toujours écrire le brief dans `.agent-bridge/current-task.md` plutôt que de passer un énorme prompt en argument CLI (évite les limites de ligne de commande Windows et garde une trace propre).
- Ne jamais inclure de secrets ou mots de passe dans le brief.
- Si Claude Code renvoie une erreur de quota / limite atteinte, ne pas réessayer en boucle : prévenir l'utilisateur immédiatement.
