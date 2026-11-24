---
name: webgl-threejs-craft
description: >-
  Garde-fous techniques et bonnes pratiques WebGL / Three.js / GLSL pour produire des scènes 3D
  propres dès le Cycle 1 sans bugs GPU Windows (ANGLE/Direct3D11), sans scintillement, sans couture UV
  ni saut de Z-order. À activer dès que l'utilisateur crée ou corrige une scène 3D Three.js, des shaders
  GLSL, du post-processing (UnrealBloomPass, ACESFilmic) ou des particules WebGL.
---

# WebGL / Three.js / GLSL — Garde-fous de Production

Checklist technique issue de bugs réels rencontrés sur GPU Windows (Chrome ANGLE / Direct3D11) et en boucle visuelle. À appliquer **dès la v1** sur toute scène Three.js / GLSL.

## 1. Zéro `NaN` sur GPU Windows ANGLE / Direct3D11 (anti-carrés Bloom)

Sur Chrome Windows (ANGLE/HLSL), `pow(0.0, y)` ou `normalize(vec3(0.0))` produit **`NaN`**, alors que les moteurs logiciels headless renvoient `0.0`. Dès qu'un seul pixel est `NaN`, **`UnrealBloomPass` le propage en gros carré clignotant** qui saute à l'écran.

- **Jamais `pow(0.0, y)` ni `pow(neg, y)` :**
  - Toujours écrire `x > 0.0001 ? pow(x, y) : 0.0` ou `pow(max(x, 0.0001), y)` (critique sur Fresnel `1.0 - dot(N, V)`, `diffuse`, `specular`, nuages et limb darkening).
  - Préférer `float d = ...; exp(-(d * d))` à `exp(-pow(d, 2.0))`.
- **Tangentes sûres aux pôles :**
  - Jamais `normalize(cross(vec3(0.0, 1.0, 0.0), N))` (nul aux pôles).
  - Toujours : `vec3 upRef = abs(N.y) < 0.99 ? vec3(0.0, 1.0, 0.0) : vec3(1.0, 0.0, 0.0);`
- **Sortie shader propre :** toujours clamper `max(vec3(0.0), finalColor)` avant `EffectComposer` / `UnrealBloomPass`.

## 2. Depth-sorting, transparence & `renderOrder` (zéro saut Z-order)

- **Objets solides = strictement opaques :** jamais `transparent: true` sur des sphères ou volumes pleins (Three.js trie les objets transparents par distance à l'origine → sauts de Z-order dès que 2 meshes partagent le même centre, ex. planète + anneaux/nuages). Toujours `transparent: false, depthWrite: true`.
- **Couches transparentes ordonnées :** `transparent: true, depthWrite: false` avec `renderOrder` croissants explicites (ex. nuages `2`, anneaux/arches `3`, atmosphère `4`, couronne/billboards `5`).
- **Tubes / volumes additifs :** utiliser `side: THREE.FrontSide` (pas `DoubleSide`) avec fondu Fresnel `pow(clamp(dot(N, V), 0.0, 1.0), 3.0+)` pour éviter les plis géométriques avant/arrière.

## 3. UV, textures & mipmaps (zéro couture verticale)

- **Jamais `fract(vUv.x + offset)` dans un fragment shader** sur une texture configurée en `THREE.RepeatWrapping` : le saut `0.999 → 0.001` fait exploser les dérivées mipmap (`dFdx`/`dFdy`) et crée une couture/ligne de blocs qui se déplace. Passer `vUv.x + offset` directement au matériel.
- **Micro-relief par gradients UV :** clamper `vUv.x` dans `[0.001, 0.999]` (ou utiliser un vrai `normalMap`) pour éviter une couture verticale sur la face avant.

## 4. Particules & étoiles sans scintillement

- **Anti-aliasing sous-pixel :** un nuage d'étoiles en rotation avec `gl_PointSize < 2.0 * pixelRatio` bat contre la grille de pixels et fatigue les yeux.
  - Imposer `minStableSize = 2.4 * uPixelRatio` et compenser l'alpha par conservation d'énergie (`energyRatio * energyRatio`).
  - Utiliser une gaussienne douce (`exp(-r * r * 7.5)`) + fenêtrage radial strict `smoothstep(1.0, 0.15, r)` pour **zéro bord carré**.
- **Pas de `twinkle` sinusoïdal** sur les étoiles dans l'espace.
- **Particules proches (astéroïdes, poussières) :** jamais `THREE.PointsMaterial` brut (rend des carrés gris) ; toujours un `ShaderMaterial` circulaire avec `nearFade = smoothstep(dMin, dMax, dist)`.

## 5. Espace linéaire, ACES Filmic & Bloom sélectif

- **Noirs profonds en espace linéaire :** avec `ACESFilmicToneMapping` + `OutputPass` (sRGB), les valeurs écrites en GLSL sont linéaires. Un fond `#020308` s'écrit `vec3(0.0005, 0.0009, 0.0024)` (et non `0.008`, qui ressort bleu marine).
- **Éviter le lavage crème sous ACES Filmic :** les valeurs RGB > `1.0` se désaturent vers le blanc/crème. Pour du feu/lave/plasma saturé, garder le corps dans `[0.05..0.95]` et réserver les pics > `1.0` aux filaments incandescents.
- **Éclats lumineux = additif, jamais `mix` vers le blanc :** `mix(rougeSombre, blanc, k)` produit du gris fumé ; utiliser `col += glowColor * k`.

## 6. Atmosphères `BackSide` & Billboards (zéro effet bulle / zéro carré)

- **Atmosphère `THREE.BackSide` :** `dot(-N, V)` vaut `0.0` à la silhouette externe. Utiliser un fondu raide qui atteint `0.0` bien avant le bord (`smoothstep(0.20, 0.70, viewDot)` + `pow(..., 3.4..4.4)`) → zéro anneau/bulle détachée.
- **Billboards (`PlaneGeometry`) :** multiplier **tous** les termes (cœur, halo, rayons) par `smoothstep(0.95, 0.20, r)` et dimensionner le quad pour qu'il ne coupe aucun objet voisin.

## 7. Caméra, éclairage & modularité

- **Angle lumière ↔ caméra :** vérifier par produit scalaire que la lumière principale arrive à ~75–110° de la caméra d'arrivée (jamais dans le dos de la caméra → garantit relief et terminateur dès la v1).
- **Transition `OrbitControls` :** à la fin d'un vol programmé, purger l'inertie (`controls.enableDamping = false; controls.update(); controls.enableDamping = true;`) pour éviter tout saut à l'arrivée.
- **Mises à jour continues :** ne pas faire de `return` anticipé sur les positions orbitales si une transition caméra cible ces objets.
- **Architecture modulaire :** séparer en petits fichiers (`galaxy.ts`, `sun.ts`, `earth.ts`, `planets.ts`, `main.ts`) plutôt qu'un fichier monolithique.
