# Skill: Add a New Game Entity

1. Create the entity class under `app/src/main/java/com/example/gametemplate/engine/entities/`, implementing the same `update(deltaMs: Float)` / `render(canvas: Canvas, paint: Paint)` contract as `Ball.kt`.
2. Pre-allocate any `Rect`/`Paint`/scratch objects the entity needs as constructor-time `private val` fields — never inside `update()`/`render()` (see [`.agent/rules/game_loop_performance.md`](../rules/game_loop_performance.md)).
3. Register the entity with `GameEngine` (add to its entity collection, wire spawn/despawn logic).
4. Add a unit test under `app/src/test/java/com/example/gametemplate/` asserting the entity's update math (e.g. position after N steps, collision response).
5. Run `just unit-test`; if the entity is visually verified, `just install` and eyeball it in the running app.
