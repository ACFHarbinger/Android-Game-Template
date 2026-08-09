# Architecture

> **TODO:** Replace with the real game's architecture once product code exists beyond the template skeleton. This page should stay in sync with the actual `app/` module.

## Overview

Android-Game-Template ships a single Android application module (`app/`) built on the standard `com.android.application` + `kotlin-android` Gradle setup. The game surface renders via `SurfaceView` on a dedicated fixed-timestep loop thread, decoupled from the UI thread; menus/HUD/settings chrome around that surface use Jetpack Compose. An **optional** lightweight backend (`infra/`) can be added later for leaderboards or cloud save — the app runs fully offline without it.

## Module Boundaries

| Module | Responsibility |
| --- | --- |
| `MainActivity.kt` | Hosts `GameView`, wires Android lifecycle callbacks to the game loop, handles save/restore. |
| `GameView.kt` | `SurfaceView` + `SurfaceHolder.Callback`; owns the `GameLoop` thread's lifecycle. |
| `GameLoop.kt` | Fixed-timestep update/render thread, independent of Activity/View lifecycle beyond the `SurfaceHolder` reference it's given. |
| `engine/GameEngine.kt` | Orchestrates entity update/render each tick; owns the entity collection. |
| `engine/GameState.kt` | Serializable snapshot of game progress; save/restore boundary. |
| `engine/entities/` | Individual game objects (e.g. `Ball.kt`), each implementing `update()`/`render()`. |
| `ui/` | Jetpack Compose screens (main menu, pause, settings) — never part of the render loop. |
| `infra/` (optional) | Leaderboards/cloud-save backend scaffolding — not implemented, see `infra/*/README.md`. |

## Data Flow

```
Activity lifecycle ──▶ GameView (SurfaceView) ──▶ GameLoop thread
                                                        │
                                          ┌─────────────┴─────────────┐
                                          ▼                           ▼
                                   GameEngine.update()         GameEngine.render()
                                          │                           │
                                   engine/entities/*            Canvas draw calls
                                          │
                                   GameState (save/restore, on pause)
```

## Rendering Approach

See [ADR 0002](adr/0002-rendering-approach.md) for the full rationale on choosing `SurfaceView` + `Canvas` over Jetpack Compose Canvas or a full game engine (LibGDX/Godot), and [`.agent/AGENTS.md`](../.agent/AGENTS.md) §1.1 for when to swap it out.

## Optional Backend

If leaderboards or cloud save are added, the app talks to the backend only through a documented REST API (add the schema here once it exists) — never by reaching into backend internals. See `infra/global/docker/README.md`, `infra/global/k8s/README.md` for the optional deployment scaffolding.

## Architecture Decision Records

Significant, hard-to-reverse decisions are recorded under [`docs/adr/`](adr/) using the [Michael Nygard ADR format](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions).
