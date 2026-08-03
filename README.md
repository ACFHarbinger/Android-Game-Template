<div align="center">

# Android-Game-Template

**A batteries-included GitHub template for a Kotlin Android mobile game — a real, idiomatic Android Studio app module plus CI/CD, docs, containerization, and LLM agent scaffolding.**

<a href="https://github.com/ACFHarbinger/Android-Game-Template/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/ACFHarbinger/Android-Game-Template/actions/workflows/ci.yml/badge.svg"></a>
<a href="https://github.com/ACFHarbinger/Android-Game-Template/actions/workflows/docs.yml"><img alt="Docs" src="https://github.com/ACFHarbinger/Android-Game-Template/actions/workflows/docs.yml/badge.svg"></a>
<img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg">

</br>

<a href="https://github.com/ACFHarbinger/Android-Game-Template/releases"><img alt="Release" src="https://img.shields.io/github/v/release/ACFHarbinger/Android-Game-Template?include_prereleases&logo=github&color=blue"></a>
<a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/License-MIT-blue.svg"></a>
<a href="https://github.com/ACFHarbinger/Android-Game-Template/issues"><img alt="Open Issues" src="https://img.shields.io/github/issues/ACFHarbinger/Android-Game-Template?color=yellow"></a>

</br>

<a href="https://kotlinlang.org/"><img alt="Kotlin" src="https://img.shields.io/badge/Kotlin-2.0-7F52FF?logo=kotlin&logoColor=white"></a>
<a href="https://developer.android.com/"><img alt="Android" src="https://img.shields.io/badge/Android-API_24%2B-3DDC84?logo=android&logoColor=white"></a>
<a href="https://developer.android.com/build/releases/gradle-plugin"><img alt="AGP" src="https://img.shields.io/badge/AGP-8.5-02303A?logo=gradle&logoColor=white"></a>
<a href="https://gradle.org/"><img alt="Gradle" src="https://img.shields.io/badge/Gradle-Kotlin_DSL-02303A?logo=gradle&logoColor=white"></a>
<a href="https://github.com/casey/just"><img alt="Just" src="https://img.shields.io/badge/Just-Task_Runner-black"></a>

</br>

<a href="https://www.docker.com/"><img alt="Docker" src="https://img.shields.io/badge/Docker-Optional_Backend-2496ED?logo=docker&logoColor=white"></a>
<a href="https://containers.dev/"><img alt="Dev Containers" src="https://img.shields.io/badge/Dev_Containers-Ready-2496ED?logo=docker&logoColor=white"></a>
<a href="https://github.com/features/actions"><img alt="GitHub Actions" src="https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?logo=githubactions&logoColor=white"></a>
<a href="https://squidfunk.github.io/mkdocs-material/"><img alt="MkDocs Material" src="https://img.shields.io/badge/MkDocs-Material-526CFE?logo=materialformkdocs&logoColor=white"></a>

</div>

## About

`Android-Game-Template` is a GitHub template repository for a **Kotlin Android mobile game**. Unlike a generic app scaffold, it ships a real, working (if minimal) game skeleton: a `SurfaceView`-based render surface driven by a fixed-timestep game loop thread, following official Android Studio / Gradle Kotlin DSL conventions exactly — nothing about the `app/` module layout is bespoke. Around that core, it carries the same cross-cutting agentic/DevOps/docs framework (`.agent/`, `docs/`, `moon/`, `.github/`, `infra/`) used across this org's other project templates.

Use **"Use this template"** on GitHub to create a new repository, rename the package from `com.example.gametemplate`, and start building.

## Why SurfaceView + Canvas?

This template targets simple, dependency-light 2D games (arcade, puzzle, roguelike-lite) and uses `SurfaceView` + a dedicated fixed-timestep loop thread — the idiomatic, zero-extra-dependency Android approach for that category. Jetpack Compose is used for chrome around the game surface (menus, HUD, settings). For 3D, physics-heavy, or cross-platform games, swap in LibGDX or Godot's Android export instead — see [`.agent/AGENTS.md`](.agent/AGENTS.md) §1.1 and [`docs/adr/0002-rendering-approach.md`](docs/adr/0002-rendering-approach.md) for the full rationale and tradeoffs.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `app/` | The single product module — standard `com.android.application` + `kotlin-android` Gradle module. `MainActivity`, `GameView` (SurfaceView), `GameLoop` (fixed-timestep thread), `engine/` (GameEngine, GameState, entities), `ui/` (Compose chrome). |
| `.agent/` | LLM coding-agent prompts, rules, skills, and workflows (source of truth for `AGENTS.md`) |
| `.devcontainer/` | VS Code Dev Container definition with Android SDK cmdline-tools, JDK 17, emulator deps |
| `.github/` | Issue/PR templates, Dependabot config, GitHub Actions workflows (CI, release, docs) |
| `infra/` | **Optional** lightweight backend scaffolding for leaderboards/cloud save: `docker/`, `k8s/`, `helm/`, `terraform/`, `ansible/` — not needed for an offline game |
| `docs/` | MkDocs site, architecture notes, ADRs |
| `git/` | `CONTRIBUTING.md` and `codecov.yaml` |
| `moon/` | `ROADMAP.md`, `CHANGELOG.md`, and per-topic roadmaps |
| `gradle/`, `gradlew`, `gradlew.bat`, `build.gradle.kts`, `gradle.properties`, `settings.gradle.kts` | Root Gradle wrapper + build files including `:app` |

## Quick Start

```bash
# Clone from the template
git clone https://github.com/<org>/<your-new-repo>.git
cd <your-new-repo>

# Install pre-commit hooks
pip install pre-commit && pre-commit install

# Explore the available command-runner recipes
just --list

# Build and install the debug APK on a connected device/emulator
just install
```

Or open the repo root in Android Studio and let it sync Gradle.

## Development

See [`git/CONTRIBUTING.md`](git/CONTRIBUTING.md) for the contribution workflow, [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md) for local setup, and [`.devcontainer/`](.devcontainer/devcontainer.json) for a one-click containerized dev environment.

## Releasing to the Play Store

See [`.agent/skills/release-to-play-store.md`](.agent/skills/release-to-play-store.md) and [`.github/workflows/release.yml`](.github/workflows/release.yml) — tagging `vX.Y.Z` builds a signed AAB/APK and (optionally, once fastlane credentials are configured) uploads to the Play Console's internal testing track.

## License

This project is dual-licensed under an open-core model:

- **Open source (free) — GNU AGPL-3.0.** Free to use, modify, and
  distribute for hobbyists, students, researchers, non-profits, and any
  other use that complies with the [AGPL-3.0](LICENSE.md)'s copyleft and
  network source-disclosure terms.
- **Commercial (paid).** For proprietary, closed-source, or SaaS use that
  can't comply with the AGPL's obligations, a paid
  [commercial license](LICENSE.txt) is available — contact ACFHarbinger
  <afonso.fernandes100@gmail.com> for pricing and terms.
