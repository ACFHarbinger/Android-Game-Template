# Testing Guide

| Layer | Location | Framework | Command |
| --- | --- | --- | --- |
| Unit tests (JVM) | `app/src/test/` | JUnit 4 + `kotlin.test` | `./gradlew testDebugUnitTest` (`just unit-test`) |
| Instrumented tests (on-device) | `app/src/androidTest/` | JUnit 4 + Espresso + Compose UI test | `./gradlew connectedDebugAndroidTest` (`just test-instrumented`) |

## What goes where

- **Unit tests**: pure `engine/` logic — entity update math, collision detection, `GameState` serialization round-trips, the fixed-timestep accumulator's catch-up cap. No Android framework classes.
- **Instrumented tests**: anything touching real framework behavior — `Activity`/`SurfaceView` lifecycle transitions, Compose screen rendering and interaction, permission flows.

## CI

`.github/workflows/ci.yml` runs unit tests, `ktlintCheck`, and Android Lint on every push/PR. Instrumented tests run via `reactivecircus/android-emulator-runner` on a headless emulator — the slowest CI job, kept intentionally small.

## Coverage

Coverage is uploaded to [Codecov](https://codecov.io/); thresholds are configured in [`git/codecov.yaml`](../git/codecov.yaml).

## Writing Tests

See [`.agent/rules/testing_qa.md`](../.agent/rules/testing_qa.md) and [`.agent/workflows/testing_qa.md`](../.agent/workflows/testing_qa.md) for edge cases that need explicit coverage (surface teardown mid-frame, process-death-and-restore, rotation while paused vs. running).
