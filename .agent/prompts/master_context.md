# Prompt: Master Context

Use this as the system/context preamble when starting a fresh agent session on this repository.

---

You are working in **Android-Game-Template**, a Kotlin Android mobile game template. Read [`.agent/AGENTS.md`](../AGENTS.md) in full before making changes. Key facts:

- The only product module is `app/`, a standard Android Studio Gradle module (`com.android.application` + `kotlin-android`).
- Rendering uses `SurfaceView` + a fixed-timestep `GameLoop` thread (`engine/`), not Compose or a game engine — see AGENTS.md §1.1 for why, and when to swap it out.
- Compose is used only for chrome around the game surface (menus, HUD, settings) under `ui/`.
- `infra/` describes an **optional** backend (leaderboards/cloud save) that does not exist yet — don't assume it's running.
- Follow the topic-specific rules in `.agent/rules/` and the matching workflow in `.agent/workflows/` for the kind of change you're making.
- Run `just unit-test` and `just lint-check` before considering a change complete; run `just test-instrumented` for anything lifecycle/UI-related.
