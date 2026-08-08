# AGENTS.md - Instructions for Coding Assistant LLMs

[![Kotlin](https://img.shields.io/badge/Kotlin-2.0-7F52FF?logo=kotlin&logoColor=white)](https://kotlinlang.org/)
[![Android](https://img.shields.io/badge/Android-API_24%2B-3DDC84?logo=android&logoColor=white)](https://developer.android.com/)
[![AGP](https://img.shields.io/badge/AGP-8.5-02303A?logo=gradle&logoColor=white)](https://developer.android.com/build/releases/gradle-plugin)
[![Gradle](https://img.shields.io/badge/Gradle-Kotlin_DSL-02303A?logo=gradle&logoColor=white)](https://gradle.org/)
[![Just](https://img.shields.io/badge/Just-Task_Runner-000000?logoColor=white)](https://github.com/casey/just)
[![CI](https://github.com/ACFHarbinger/Android-Game-Template/actions/workflows/ci.yml/badge.svg)](https://github.com/ACFHarbinger/Android-Game-Template/actions/workflows/ci.yml)

> **Version**: 1.0
> **Last Updated**: 2026-08-02
> **Purpose**: Authoritative reference for AI assistants (Claude, GPT, Gemini, Copilot, etc.) working in repositories generated from this template.

## Table of Contents

1. [Project Overview & Mission](#1-project-overview--mission)
2. [Technical Stack & Governance](#2-technical-stack--governance)
3. [Module Boundaries](#3-module-boundaries)
4. [Key CLI Entry Points](#4-key-cli-entry-points)
5. [Coding Standards](#5-coding-standards)
6. [AI Review & Severity Protocol](#6-ai-review--severity-protocol)
7. [Known Constraints](#7-known-constraints)

## 1. Project Overview & Mission

> **TODO:** Replace with a one-paragraph description of the actual game once this template seeds a real project.

This repository is a scaffold for a **Kotlin Android mobile game**, not a product. It ships a single, real `app/` module — a minimal but functional 2D game skeleton built on `SurfaceView` + a fixed-timestep game loop thread — plus the cross-cutting agentic/DevOps/docs framework shared across this org's other templates (`.agent/`, `docs/`, `docs/moon/`, `.github/`, `infra/`). When used via "Use this template", update this section first.

### 1.1 Why SurfaceView + Canvas, not Compose or a game engine

This template targets **simple, dependency-light 2D games** (arcade, puzzle, roguelike-lite). `SurfaceView` rendering on a dedicated thread with a fixed-timestep loop is the idiomatic, zero-extra-dependency Android approach for that category, and it keeps the render loop fully decoupled from the UI thread — important for consistent frame pacing. It is **not** the right choice for every game:

| If your game needs... | Consider instead |
| --- | --- |
| Menus, HUD, settings screens, leaderboards UI | Keep those in Jetpack Compose (see [`.agent/rules/ui_compose.md`](rules/ui_compose.md)) layered *around* the `SurfaceView` game surface — this template already does this for the main menu. |
| 3D rendering, physics engine, cross-platform (iOS) export | [LibGDX](https://libgdx.com/) or [Godot](https://godotengine.org/) (Android export) — swap `GameView`/`GameLoop` for the engine's own surface/loop and keep everything else in this template (`.agent/`, CI, docs, infra). |
| Compose-only rendering (shaders via `Canvas` in Compose, `Modifier.drawWithCache`) | Jetpack Compose Canvas — viable for lower-frequency/simpler games; see the ADR at [`docs/adr/0002-rendering-approach.md`](../docs/adr/0002-rendering-approach.md) for the tradeoffs we weighed. |

## 2. Technical Stack & Governance

| Component | Specification | Notes |
| --- | --- | --- |
| Kotlin | 2.0.20 | `kotlin-android` plugin, JVM target 17 |
| Android Gradle Plugin (AGP) | 8.5.2 | `com.android.application` |
| Gradle | 8.7 (wrapper-pinned) | Always invoke via `./gradlew`, never a bare `gradle` |
| compileSdk / targetSdk | 35 (Android 15) | |
| minSdk | 24 (Android 7.0) | ~97% device coverage as of 2026 |
| UI toolkit | Views (`SurfaceView`) for the game surface, Jetpack Compose for menus/HUD chrome | See §1.1 |
| Build variants | `debug`, `release` (minified + resource-shrunk, R8) | |
| Config | `local.properties` (git-ignored, SDK path + signing refs), `.env.example` for optional backend | |

## 3. Module Boundaries

- `app/src/main/java/com/example/gametemplate/` — the only product module. Structured as:
  - `MainActivity.kt` — hosts the `GameView`, wires lifecycle to the game loop.
  - `GameView.kt` — `SurfaceView` + `SurfaceHolder.Callback`, owns the `GameLoop` thread.
  - `GameLoop.kt` — fixed-timestep loop thread (update/render separation), independent of any Android UI class beyond the `SurfaceHolder` it's given.
  - `engine/` — `GameEngine.kt` (update/draw orchestration), `GameState.kt` (save/restore state), `entities/` (game objects). No `android.app.Activity`/`Context` UI calls inside `engine/` beyond what's needed for asset/resource loading — keep it testable in a plain JVM unit test where possible.
  - `ui/` — optional Compose screens (main menu, pause, settings) that sit *outside* the `SurfaceView`, never mixed into the render loop.
- Cross-module contracts (an optional backend's REST/WebSocket API) live under `docs/` — see [`docs/ARCHITECTURE.md`](../docs/ARCHITECTURE.md) — not duplicated in code comments.
- `infra/` describes an **optional** lightweight backend (leaderboards/cloud save) — a purely offline game needs none of it. See `infra/*/README.md`.

## 4. Key CLI Entry Points

| Command | Purpose |
| --- | --- |
| `just --list` | List all available command-runner recipes |
| `just apk` | `./gradlew assembleDebug` |
| `just unit-test` | Unit tests (`./gradlew testDebugUnitTest`) |
| `just test-instrumented` | Instrumented tests on a connected device/emulator (`./gradlew connectedDebugAndroidTest`) |
| `just lint-check` | `./gradlew lint ktlintCheck` |
| `just assemble-release` | `./gradlew bundleRelease` (signed App Bundle for Play Store) |
| `just install` | `./gradlew installDebug` onto a connected device/emulator |

## 5. Coding Standards

- Follow the per-topic rules in [`.agent/rules/`](rules/): `kotlin.md`, `android_lifecycle.md`, `game_loop_performance.md`, `ui_compose.md`, `testing_qa.md`, `code_review.md`, `error_debug.md`, `documentation.md`, `reasoning_planning.md`.
- Prefer small, reviewable diffs. Do not reformat files unrelated to the change.
- Every new public function/class needs a KDoc comment; every new `engine/` class needs at least one unit test.
- Never commit secrets, keystores, or signing passwords. Use `local.properties`/`.env` (git-ignored) and document new variables in `.env.example`.

## 6. AI Review & Severity Protocol

### 6.1 CRITICAL (must fix before merge)

- Blocking work (I/O, bitmap decode, network) on the render/update thread or the UI thread.
- `SurfaceView` callbacks (`surfaceCreated`/`surfaceDestroyed`) not correctly starting/stopping the `GameLoop` thread — leaked threads crash on rotation/backgrounding.
- Signing credentials or a keystore file committed to the repo.
- Game state not persisted in `onPause`/`onSaveInstanceState` — Android can kill a backgrounded process at any time.

### 6.2 HIGH (fix before merge)

- Per-frame allocations in the update/render hot path (new objects inside `GameLoop`'s loop body) — triggers GC pauses and frame drops.
- Missing null-safety handling around `SurfaceHolder.lockCanvas()` (can return `null`).
- Unhandled configuration changes (rotation) that don't resize/reset the game surface.

### 6.3 MEDIUM (fix soon)

- Missing KDoc on public `engine/` classes.
- Magic numbers for tuning values (speed, spawn rate) not hoisted to named constants.

### 6.4 LOW (nice to have)

- Minor Compose UI polish, string resource organization.

## 7. Known Constraints

> **TODO:** Document real device/performance constraints once the project has them.

- This template repository does not ship a complete game — `engine/` contains an illustrative skeleton (a bouncing-entity demo), not final gameplay.
- The optional backend under `infra/` is unimplemented scaffolding — see each `infra/*/README.md` before assuming any service exists.
