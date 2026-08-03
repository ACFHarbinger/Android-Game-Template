# Glossary

| Term | Meaning |
| --- | --- |
| ADR | Architecture Decision Record — a short document capturing a significant, hard-to-reverse technical decision and its rationale. |
| AGP | Android Gradle Plugin — the Gradle plugin (`com.android.application`) that builds Android app modules. |
| AAB | Android App Bundle — the publishing format (`.aab`) uploaded to the Play Store, superseding raw APK uploads. |
| Fixed timestep | A game loop pattern where the simulation (`update()`) always advances by the same fixed time increment regardless of actual frame rate, keeping physics/logic deterministic. |
| `GameLoop` | This template's dedicated thread running the fixed-timestep update/render cycle for the `SurfaceView` game surface. |
| Interpolation (rendering) | Blending between the previous and current simulation state when rendering happens more often than fixed updates, for smoother visuals. |
| `SurfaceView` | An Android View subclass that provides a dedicated drawing surface on a separate thread from the UI thread — the rendering approach this template uses for the game surface. |
| R8 | Android's code shrinker/obfuscator/optimizer, applied to `release` builds. |
| Play Store track | A release channel in Google Play Console (internal, closed, open, production) that a signed AAB is promoted through. |

> **TODO:** Add project-specific domain terms once this template is used to seed a real game.
