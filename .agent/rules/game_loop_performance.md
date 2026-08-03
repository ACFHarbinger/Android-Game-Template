# Game Loop & Performance Rules

Applies to `GameLoop.kt`, `GameEngine.kt`, and `engine/entities/`.

- Use a **fixed-timestep update, variable-rate render** loop: accumulate elapsed time, run `update(fixedDeltaMs)` zero or more times per frame to catch up, then `render(interpolation)` once. This decouples simulation correctness from device refresh rate (60Hz/90Hz/120Hz panels all behave identically).
- **Never allocate inside the per-frame update/render path.** No `new`/object-literal allocation, no boxing of primitives, no `ArrayList` resize inside the hot loop — pre-allocate entity pools and scratch buffers in `GameEngine` init. Allocation churn here is the single most common cause of GC-pause frame drops on mid-range Android hardware.
- `SurfaceHolder.lockCanvas()` can return `null` (surface torn down mid-frame) — always null-check before drawing, and always release in a `finally` block via `unlockCanvasAndPost()` to avoid deadlocking the surface.
- Cap the accumulator's catch-up iterations (e.g. max 5 update steps per frame) so a debugger breakpoint or a long GC pause doesn't cause a "spiral of death" where the loop tries to simulate minutes of missed time in one frame.
- Keep `update()` and `render()` logically separate even though they run on the same thread — `update()` must never touch the `Canvas`, and `render()` must never mutate game state. This keeps both independently unit-testable.
- Profile with Android Studio's CPU Profiler / Perfetto before "optimizing" — most naive frame-drop reports trace back to allocation or an accidental main-thread blocking call, not raw compute cost.

## Anti-patterns

```kotlin
// WRONG: allocates a new Paint and a new Rect every frame
override fun render(canvas: Canvas, interpolation: Float) {
    val paint = Paint()          // ❌ allocation in hot path
    val rect = Rect(x, y, x + w, y + h)  // ❌ allocation in hot path
    canvas.drawRect(rect, paint)
}

// CORRECT: allocate once, reuse every frame
private val paint = Paint()
private val scratchRect = Rect()
override fun render(canvas: Canvas, interpolation: Float) {
    scratchRect.set(x, y, x + w, y + h)
    canvas.drawRect(scratchRect, paint)
}
```

```kotlin
// WRONG: unbounded catch-up can spiral if a frame takes too long
while (accumulator >= fixedDeltaMs) {
    update(fixedDeltaMs)
    accumulator -= fixedDeltaMs
}

// CORRECT: cap iterations, drop the remainder rather than death-spiraling
var steps = 0
while (accumulator >= fixedDeltaMs && steps < MAX_CATCHUP_STEPS) {
    update(fixedDeltaMs)
    accumulator -= fixedDeltaMs
    steps++
}
if (steps == MAX_CATCHUP_STEPS) accumulator = 0f
```
