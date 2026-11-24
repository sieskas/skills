---
name: webgl-threejs-craft
description: >-
  Battle-tested WebGL, Three.js, and GLSL guardrails for producing clean 3D scenes from Cycle 1
  without Windows GPU (ANGLE/Direct3D11) NaN/Bloom artifacts, star shimmer, UV seams, or Z-order
  popping. Activate whenever creating or debugging a Three.js 3D scene, custom GLSL shaders,
  post-processing (UnrealBloomPass, ACESFilmic), or WebGL particle systems.
---

# WebGL / Three.js / GLSL — Production Guardrails

A field-tested checklist derived from real Windows GPU (Chrome ANGLE / Direct3D11) bugs and visual QA loops. Apply these rules **from v1** on every Three.js / GLSL scene.

## 1. Zero `NaN` on Windows ANGLE / Direct3D11 (Anti-Bloom Squares)

On Chrome Windows (ANGLE/HLSL), `pow(0.0, y)` or `normalize(vec3(0.0))` evaluates to **`NaN`**, whereas headless software renderers return `0.0`. If even a single pixel outputs `NaN`, **`UnrealBloomPass` spreads it into a giant flashing square tile** jumping across the screen.

- **Never call `pow(0.0, y)` or `pow(negative, y)`:**
  - Always guard with `x > 0.0001 ? pow(x, y) : 0.0` or `pow(max(x, 0.0001), y)` (especially on Fresnel `1.0 - dot(N, V)`, `diffuse`, `specular`, clouds, and limb darkening).
  - Prefer `float d = ...; exp(-(d * d))` over `exp(-pow(d, 2.0))`.
- **Pole-safe tangent frames:**
  - Never write `normalize(cross(vec3(0.0, 1.0, 0.0), N))` (degenerate at poles).
  - Always use: `vec3 upRef = abs(N.y) < 0.99 ? vec3(0.0, 1.0, 0.0) : vec3(1.0, 0.0, 0.0);`
- **Clean fragment output:** clamp `max(vec3(0.0), finalColor)` before `EffectComposer` / `UnrealBloomPass`.

## 2. Depth Sorting, Transparency & `renderOrder` (Zero Z-Order Popping)

- **Solid meshes must be strictly opaque:** never set `transparent: true` on solid spheres or opaque volumes (Three.js sorts transparent objects by origin distance, causing Z-order popping whenever two meshes share an origin, e.g. planet + rings/clouds). Always use `transparent: false, depthWrite: true`.
- **Ordered transparent layers:** set `transparent: true, depthWrite: false` with explicit ascending `renderOrder` (e.g. clouds `2`, rings/arches `3`, atmosphere `4`, corona/billboards `5`).
- **Additive tubes / volumetric ribbons:** use `side: THREE.FrontSide` (not `DoubleSide`) with steep Fresnel edge fade `pow(clamp(dot(N, V), 0.0, 1.0), 3.0+)` to avoid front/back overlap folds.

## 3. UVs, Textures & Mipmaps (Zero Vertical Seams)

- **Never call `fract(vUv.x + offset)` inside a fragment shader** on a `THREE.RepeatWrapping` texture: the `0.999 -> 0.001` jump breaks GPU mipmap derivatives (`dFdx`/`dFdy`) and produces a moving 1x1-mipmap seam line. Pass `vUv.x + offset` directly and let hardware wrapping handle it.
- **UV-gradient micro-bump:** clamp `vUv.x` within `[0.001, 0.999]` (or use a dedicated `normalMap`) to prevent a vertical seam across the front face.

## 4. Shimmer-Free Particles & Starfields

- **Sub-pixel anti-aliasing:** rotating point clouds with `gl_PointSize < 2.0 * pixelRatio` beat against the pixel grid and cause eye-straining shimmer.
  - Enforce `minStableSize = 2.4 * uPixelRatio` and conserve energy in alpha (`energyRatio * energyRatio`).
  - Use a smooth Gaussian falloff (`exp(-r * r * 7.5)`) + strict radial window `smoothstep(1.0, 0.15, r)` for **zero square sprite edges**.
- **No artificial sinusoidal `twinkle`** on space starfields.
- **Near-field particles (asteroids, dust):** never use raw `THREE.PointsMaterial` (renders flat grey squares); always use a circular `ShaderMaterial` with `nearFade = smoothstep(dMin, dMax, dist)`.

## 5. Linear Color Space, ACES Filmic & Selective Bloom

- **True blacks in linear space:** under `ACESFilmicToneMapping` + `OutputPass` (sRGB), GLSL outputs are linear. A `#020308` space floor is `vec3(0.0005, 0.0009, 0.0024)` (not `0.008`, which lifts to navy blue).
- **Avoid cream washout under ACES Filmic:** RGB values > `1.0` desaturate toward white/cream. For saturated fire/lava/plasma, keep the body in `[0.05..0.95]` and reserve > `1.0` peaks strictly for thin incandescent filaments.
- **Luminous highlights = additive, never `mix` toward white:** `mix(darkRed, white, k)` turns smoky grey; use `col += glowColor * k`.

## 6. `BackSide` Atmospheres & Billboards (Zero Bubble Edge / Zero Square Quads)

- **`THREE.BackSide` atmospheric shells:** `dot(-N, V)` equals `0.0` at the outer silhouette. Use a steep falloff that reaches `0.0` well before the edge (`smoothstep(0.20, 0.70, viewDot)` + `pow(..., 3.4..4.4)`) so no circular bubble cutoff ever appears.
- **Billboards (`PlaneGeometry`):** multiply **all** terms (core, halo, rays) by `smoothstep(0.95, 0.20, r)` and size the quad so it never clips nearby geometry.

## 7. Camera, Lighting & Modularity

- **Light-to-camera angle:** verify via dot product that key lighting arrives at ~75-110 deg from the default arrival camera (never behind the camera) so relief and terminators read dramatically from v1.
- **`OrbitControls` handoff:** flush damping inertia at the end of programmatic flights (`controls.enableDamping = false; controls.update(); controls.enableDamping = true;`) so arrivals never snap.
- **Continuous orbital updates:** never early-return from position updates while an object is fading in if a camera flight targets it.
- **Modular file split:** split scenes into small focused files (`galaxy.ts`, `sun.ts`, `earth.ts`, `planets.ts`, `main.ts`) instead of a single monolith.
