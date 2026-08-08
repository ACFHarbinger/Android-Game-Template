# Pull Request

## Summary

<!-- What does this PR change and why? Link the roadmap item (docs/moon/ROADMAP.md or a module roadmap in moon/roadmaps/). -->

## Affected Area(s)

- [ ] Game loop / rendering (`GameLoop`, `GameView`, `engine/`)
- [ ] Lifecycle (Activity, SurfaceView, save/restore)
- [ ] UI (Compose menus/HUD)
- [ ] Optional backend (`infra/`)
- [ ] Tooling / docs / CI

## Type of Change

- [ ] 🐛 Bug fix
- [ ] ✨ New feature
- [ ] ♻️ Refactor
- [ ] ⚡ Performance
- [ ] 📚 Documentation
- [ ] 🔧 Tooling / CI

## Verification

- [ ] `just lint-check` and `just unit-test` pass.
- [ ] `just test-instrumented` run for lifecycle/UI-affecting changes.
- [ ] No allocations introduced in the `GameLoop` update/render hot path (see `.agent/rules/game_loop_performance.md`).
- [ ] Docs / roadmap / `docs/moon/CHANGELOG.md` updated where the public surface changed.
