---
name: ideation-saas
description: >-
  Génère des idées originales et rentables de nouvelles fonctionnalités, leviers d'acquisition
  ou modèles de monétisation pour un SaaS en contournant le « mode collapse » des LLM.
  Combine les techniques de créativité IA prouvées (Verbalized Sampling, séparation stricte
  Divergence/Convergence CreativeDC, liste noire anti-clichés d'Ethan Mollick, collisions
  hors-secteur) avec les frameworks des sommités SaaS (Teresa Torres, Elena Verna, Kyle Poyar,
  Bob Moesta, Lenny Rachitsky, Shreyas Doshi). À utiliser dès que l'utilisateur cherche de
  nouvelles idées de features pour son SaaS, veut augmenter son nombre de clients, son MRR,
  son panier moyen ou explorer de nouveaux axes de croissance produit.
---

# Idéation SaaS Inventive & Monétisable

Méthode anti-clichés pour explorer de nouvelles fonctionnalités SaaS qui génèrent réellement **plus de clients** ou **plus de revenus**, en cassant le biais de moyenne statistique (*mode collapse*) des LLM.

## Règle absolue : ne jamais brainstormer « à froid » ni en un seul bloc

Un prompt classique (« donne-moi 10 idées de features pour mon SaaS ») produit toujours les mêmes clichés (copilote IA, parrainage, plan Enterprise générique). Ce skill impose **4 garde-fous non négociables** :
1. Ancrer l'idéation dans des **frictions réelles** et un **levier business précis**.
2. **Bannir explicitement** les idées évidentes avant de commencer.
3. **Séparer strictement** la phase de divergence sauvage et la phase de filtrage business.
4. **Passer chaque pépite au crible sceptique** avant de la recommander.

---

## Étape 1 : Cadrage express (max 4 questions)

Si l'utilisateur n'a pas encore décrit son SaaS, poser au maximum **4 questions courtes** en une seule fois :
1. **Le produit & les rôles** : que fait ton SaaS en 2 phrases ? Qui l'**utilise** au quotidien et qui **paie** la facture ?
2. **Pricing actuel** : comment tu factures aujourd'hui (siège, usage, abonnement fixe, freemium…) et quel est ton panier moyen ?
3. **Levier prioritaire** : tu veux surtout **plus de clients** (acquisition / conversion) ou **plus d'argent par client** (expansion / upsell / rétention) ?
4. **Matière première réelle (optionnel mais très puissant)** : quels sont les 2–3 trucs pénibles que tes clients font encore *à la main* hors de ton outil, ou les principales raisons de churn / refus de vente ?

*Si l'utilisateur fournit des verbatims (tickets support, notes d'appels, avis, codebase), en extraire d'abord les **contournements manuels** (workarounds) et **moments de friction** en citant les faits exacts — ne jamais inventer de besoins fictifs.*

---

## Étape 2 : Cartographie des angles business (Torres + Verna + Moesta + Poyar + Rachitsky)

Avant d'imaginer la moindre feature, poser un diagnostic rapide sur **5 axes** (1–2 lignes par axe, centré sur le levier prioritaire) :

| Sommité | Angle d'attaque à inspecter |
|---|---|
| **Teresa Torres** (*Opportunity Solution Tree*) | Quels **bricolages manuels** (exports CSV, copier-coller, emails manuels) prouvent une douleur non résolue ? |
| **Elena Verna** (*Monetization-Led Growth*) | Quelle **feature pour le décideur/acheteur** (contrôle, gouvernance, visibilité équipe, preuve de ROI) manque face aux features utilisateur ? |
| **Bob Moesta** (*Jobs-to-be-Done*) | Quelle **anxiété ou habitude** bloque le passage à l'acte (*Switch Moment*) chez un prospect ? |
| **Kyle Poyar** (*Pricing & Packaging*) | Quelle feature ferait **consommer 3× plus** l'unité de valeur ou justifierait un **add-on / modèle hybride** (base + crédits/usage) ? |
| **Lenny Rachitsky** (*Growth Loops*) | Quel livrable ou workflow interne pourrait **exposer le SaaS** aux clients, collègues ou partenaires des utilisateurs existants ? |

---

## Étape 3 : Liste noire anti-clichés (antidote au Mode Collapse — Ethan Mollick)

Lister brièvement les **10 idées les plus évidentes / banales** que n'importe quel PM ou LLM sortirait en premier pour ce SaaS (ex. *« ajouter un chatbot IA », « programme d'affiliation », « intégration Zapier », « mode sombre », « tableau de bord analytics générique »*).

**Déclarer ces 10 idées formellement interdites** pour toute la suite de la session.

---

## Étape 4 : DIVERGENCE pure (CreativeDC + Verbalized Sampling)

> **Contrainte stricte :** pendant cette étape, **interdiction totale** de filtrer par faisabilité technique, coût de dev ou « bon sens ». L'objectif est de sortir du cluster probabiliste habituel.

Générer **16 à 20 idées originales** réparties en **4 moteurs créatifs** :

1. **Verbalized Sampling — Longue traîne (`p < 0,10`)** *(5 idées)* :
   - Ne garder que des idées dont la probabilité d'être proposées par un PM classique est estimée **< 10 %**.
   - Pour chaque idée, indiquer explicitement `[p ≈ 0.0X]` et **quelle norme du secteur elle casse**.
2. **Collisions hors-secteur** *(5 idées)* :
   - Transposer des mécaniques qui rapportent gros dans 5 industries éloignées (ex. jeux vidéo *free-to-play*, aviation *low-cost*, finance/assurance, luxe/conciergerie, logistique, immobilier, open-source).
   - Nommer l'industrie source + la mécanique exacte transposée au SaaS.
3. **Inversion & Contraintes extrêmes** *(4 idées)* :
   - Répondre à des contraintes radicales adaptées au levier choisi :
     - *Si objectif Revenu* : « Comment facturer 5× plus cher à un client existant **sans** ajouter un seul siège ? »
     - *Si objectif Clients* : « Comment acquérir des clients sans budget pub ni commercial, uniquement via l'usage du produit ? »
4. **Rôle Wildcard / Provocateur** *(2 à 4 idées)* :
   - Des idées volontairement dérangeantes, contre-intuitives ou « trop bizarres pour être raisonnables » (c'est souvent en domestiquant une idée folle qu'on trouve une vraie différenciation).

---

## Étape 5 : CONVERGENCE & Filtre « Tueur d'idées » (Shreyas Doshi + Verna + Torres)

Changer radicalement de casquette : adopter le point de vue d'un **Comité impitoyable** (CPO sceptique + CFO obsédé par la marge + client qui déteste payer pour un outil de plus).

1. **Éliminer sans pitié** les idées « sympas » mais qui ne résolvent pas un problème n°1 (*Customer Problem Stack Ranking* de Shreyas Doshi).
2. **Sélectionner les 4 à 5 meilleures pépites** (dont au moins 1 idée issue de la catégorie *Wildcard* ou *Collision* rendue pragmatique).
3. Pour chaque pépite retenue, produire une **fiche actionnable** contenant :
   - **Le concept concret** (en 2 phrases claires, sans jargon).
   - **Mécanique cash & packaging** : comment ça fait entrer de l'argent (acquisition / conversion / add-on / tier supérieur / crédits d'usage) et **qui** valide la dépense.
   - **Pourquoi ça se démarque** : quel angle mort des concurrents elle exploite.
   - **L'hypothèse tueuse** : la croyance la plus risquée qui peut faire échouer l'idée.
   - **Test en 48h sans coder** : expérience ultra-rapide pour valider l'appétit réel avant de développer (*fake door*, page de prévente, maquette cliquable, service manuel *Wizard-of-Oz*).

---

## Étape 6 : Restitution & Prolongements

1. Présenter un **tableau comparatif synthétique** des 4–5 pépites retenues (Nom, Levier, Impact cash potentiel, Effort de test, Score de différenciation), suivi des fiches détaillées.
2. En fin de réponse, proposer deux suites concrètes :
   - **Approfondir une pépite** : transformer l'idée choisie en mini-spec + script de test 48h prêt à lancer.
   - **Cross-Vendor Pooling (méthode Wharton)** : fournir un prompt compact (incluant la liste noire et le *Verbalized Sampling*) que l'utilisateur peut copier-coller dans un autre LLM (Claude, GPT, etc.) pour croiser les angles morts entre modèles.
