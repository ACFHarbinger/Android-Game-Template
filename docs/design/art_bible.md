# Art Bible: [Project Name]
*[Visual Style & Art Direction, Native UI Wireframes, and Animation Guidelines]*

---

## 1. Visual Style & Art Direction

[Project Name] uses a distinct visual aesthetic inspired by [Art Style / Visual References]. The visual identity incorporates [Key Materials, Shading Techniques, Lighting Direction, and Color Palette Rules].

```
+--------------------------------------------------------------+
|                    VISUAL TRANSITION STATE                   |
+--------------------------------------------------------------+
|                                                              |
|   [State / Environment A]   ===>    [State / Environment B]  |
|   - [Visual Trait 1]                - [Visual Trait 1]       |
|   - [Visual Trait 2]                - [Visual Trait 2]       |
|   - [Visual Trait 3]                - [Visual Trait 3]       |
|                                                              |
+--------------------------------------------------------------+
```

### 1.1 Color Palette Guidelines
*   **Contour & Line Art**: [Color Token / Description] (`[#HEX]`).
*   **Background & Terrain**: [Color Token / Description] (`[#HEX]`).
*   **Primary Faction Accents**: [Color Token / Description] (`[#HEX]`).
*   **Secondary Faction Accents**: [Color Token / Description] (`[#HEX]`).
*   **Enemy / Neutral Accents**: [Color Token / Description] (`[#HEX]`).

---

## 2. UI/UX Wireframe Guidelines

The user interface wraps around the native game rendering canvas or view.

### 2.1 Native HUD Layers
*   **Primary Resource / Health Indicator**: Top-left corner displaying [Primary Status / HP / Crest].
*   **Status & Economy Strip**: Top-center bar displaying [Resource Generators / Currency Rates / Active Buffs].
*   **Action & Unit Panel**: Bottom bar/deck containing [Selectable Cards / Action Buttons / Ability Cooldowns].
*   **Tactical Map / Radar**: Top-right corner displaying [Map Overview / Vector Pathways / Threat Gates].

```
+-------------------------------------------------------------+
| [Health: 100%]       [Resources: 0/0]         [Radar Map]   |
|                                                             |
|                                                             |
|                   (Native Canvas Area)                      |
|                                                             |
|                                                             |
|                                                             |
|                                                             |
| [Action 1 Card]      [Action 2 Card]     [Action 3 Card]    |
| (Cost: X)            (Cost: Y)           (Cost: Z)          |
+-------------------------------------------------------------+
```

---

## 3. Sprite / Model Animation Requirements

All entities, characters, and hazards use optimized animation pipelines to ensure high performance during intensive scenes.

### 3.1 Spritesheet / Mesh Animation States
Every character or entity type requires the following baseline animation states:
1.  **Idle**: Frame loop representing baseline stance, posture, or idle state.
2.  **Locomotion (Walk / Run)**: Looping locomotion cycles incorporating movement particle effects or trails.
3.  **Action / Attack Execution**: High-intensity action pose accompanied by effect overlays or particle spawns.
4.  **Defeat / Destruction**: Collapse, fade, or destruction sequence marking entity removal.

---
*Document Version: 1.0*  
*Authoritative Reference: docs/design/game_design_document.md*
