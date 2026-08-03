# Workflow: Game Loop / Performance Change

Applies to `GameLoop.kt`, `GameEngine.kt`, and `engine/entities/`.

## When to use this workflow

- Changing the fixed-timestep accumulator, update rate, or catch-up cap.
- Adding a new entity type that participates in the per-frame update/render path.
- Investigating a reported frame-drop/jank issue.

## Steps

1. Read [`.agent/rules/game_loop_performance.md`](../rules/game_loop_performance.md) before touching `GameLoop.kt` — this is the most failure-sensitive file in the template; a subtle regression here degrades every frame of every session.
2. Reproduce/baseline first: run `just install` on a real mid-range device if available (the emulator's GPU/CPU profile is not representative), profile with Perfetto or the CPU Profiler to confirm the actual bottleneck before changing code.
3. If adding a new entity type, verify its `update()`/`render()` methods allocate nothing per call — pool any objects it needs (e.g. `Rect`, `Paint`) at construction time.
4. If touching the accumulator loop, keep the catch-up step cap intact and add/update a unit test asserting the loop doesn't spiral under a simulated long frame (see [`.agent/rules/testing_qa.md`](../rules/testing_qa.md)).
5. Re-profile after the change; confirm the fix addresses the measured bottleneck, not a guessed one.
6. Run `just unit-test` and, if the change is render-visible, `just install` for a manual sanity pass.

## Anti-patterns

- "Optimizing" based on a hunch instead of a profile.
- Fixing jank by skipping `update()` calls instead of fixing the actual allocation/blocking-call source.
