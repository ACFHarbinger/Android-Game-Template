# 2. SurfaceView + Canvas for the game surface, Compose for chrome

Date: 2026-08-02

## Status

Accepted

## Context

This template needs a default rendering approach for the game surface itself. Three realistic options exist for a Kotlin Android game template:

1. **`SurfaceView` + `Canvas`, dedicated render thread** — the traditional, idiomatic Android 2D game approach; zero extra dependencies beyond the framework.
2. **Jetpack Compose Canvas** (`Modifier.drawWithCache`/`Canvas` composable) — modern, unifies UI and game rendering in one toolkit, but recomposition-driven rendering is a poorer fit for a tight, deterministic frame loop, and per-frame invalidation semantics are less predictable than an owned thread.
3. **A full game engine (LibGDX, Godot Android export, Unity)** — the right call for 3D, physics-heavy, or cross-platform games, but a heavy, opinionated dependency that's wrong for a lightweight, dependency-light 2D template.

## Decision

Use `SurfaceView` + `Canvas` with a dedicated fixed-timestep `GameLoop` thread (see `.agent/rules/game_loop_performance.md`) as the default for the game surface. Use Jetpack Compose for everything *around* the game surface — main menu, pause screen, settings, HUD chrome that isn't frame-locked to gameplay.

## Consequences

- The render loop is fully decoupled from the UI thread and from Compose's recomposition model, giving predictable frame timing independent of what else is happening in the Activity.
- `engine/` stays framework-light and independently unit-testable, since it only needs a `Canvas` reference, not a full Compose/View hierarchy.
- Teams needing 3D, physics, or cross-platform (iOS) support should swap `GameView`/`GameLoop` for LibGDX's or Godot's own surface/loop, keeping the rest of this template (`.agent/`, CI, docs, infra) — see `.agent/AGENTS.md` §1.1.
- A future ADR should record the decision if/when this template's default is revisited (e.g. Compose's `Canvas` performance improves enough to reconsider for simple cases).
