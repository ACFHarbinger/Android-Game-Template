# Skill: Build and Test

```bash
just build              # ./gradlew assembleDebug
just test               # ./gradlew testDebugUnitTest
just test-instrumented  # ./gradlew connectedDebugAndroidTest (needs a device/emulator)
just lint                # ./gradlew lint ktlintCheck
just install             # ./gradlew installDebug onto a connected device/emulator
```

Run `just unit-test` + `just lint-check` before every commit. Run `just test-instrumented` before opening a PR that touches lifecycle, `SurfaceView`, or Compose UI code — CI runs it too, but it's the slowest job and failures are cheaper to catch locally.
