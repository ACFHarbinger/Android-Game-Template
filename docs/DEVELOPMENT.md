# Development Guide

## Prerequisites

- Android Studio (Ladybug or newer) or a standalone JDK 17 + Android SDK cmdline-tools install.
- Android SDK Platform 35, Build-Tools 35.0.0.
- [`just`](https://github.com/casey/just) as the command runner.
- `pre-commit` (`pip install pre-commit && pre-commit install`).

## Local Setup

```bash
git clone https://github.com/<org>/<repo>.git
cd <repo>
cp .env.example .env       # only needed if you use the optional backend
pip install pre-commit && pre-commit install
just --list
```

Open the project root in Android Studio ("Open" → select the repo root, which contains `settings.gradle.kts`) and let it sync Gradle. Or from the CLI:

```bash
./gradlew tasks
```

## Running the App

```bash
just install     # ./gradlew installDebug onto a connected device/emulator
```

Or run/debug directly from Android Studio's device toolbar.

## Emulator Setup

```bash
sdkmanager "system-images;android-35;google_apis;x86_64"
avdmanager create avd -n game-template -k "system-images;android-35;google_apis;x86_64"
emulator -avd game-template
```

## Containerized Dev Environment

Open the repo in VS Code and choose "Reopen in Container" — see [`.devcontainer/devcontainer.json`](../.devcontainer/devcontainer.json). Note: the emulator itself needs `/dev/kvm` passed through and is best run on the host, not inside the container, for acceptable performance.

## Common Tasks

| Task | Command |
| --- | --- |
| Build debug APK | `just apk` |
| Run unit tests | `just unit-test` |
| Run instrumented tests | `just test-instrumented` |
| Lint (ktlint + Android Lint) | `just lint-check` |
| Build a signed release bundle | `just assemble-release` |
| Install debug build on a device | `just install` |
| Start the optional backend stack | `just docker-up` |
