# Android-Game-Template - Root Justfile
# https://github.com/casey/just
# Entry point. All recipes delegate to sub-modules via `mod`.
# Invoke sub-module recipes directly with dot notation: just build::debug
# Or use the root shorthands defined below.
#
# Thin wrapper around the Gradle wrapper — always invoke Gradle via ./gradlew,
# never a bare `gradle`, so the pinned wrapper version (see
# gradle/wrapper/gradle-wrapper.properties) is what actually runs.

set shell := ["bash", "-c"]

red := '\033[0;31m'
green := '\033[0;32m'
yellow := '\033[0;33m'
blue := '\033[0;34m'
purple := '\033[0;35m'
cyan := '\033[0;36m'
bold := '\033[1m'
reset := '\033[0m'

# --- Submodules ---

mod build 'tools/build'
mod ci 'tools/ci'
mod docs 'tools/docs'
mod helper 'tools/helper'
mod infra 'tools/infra'
mod reducer 'tools/reducer'
mod test 'tools/test'
mod validation 'tools/validation'

# --- Default target ---

default: help

# --- Help ---

# Print available commands
help: helper::_print_header
    @echo -e "{{bold}}Build{{reset}}"
    @echo "  just apk                    Assemble the debug APK (see tools/build/justfile)"
    @echo "  just assemble-release       Assemble a signed release App Bundle (.aab)"
    @echo "  just install                Install the debug build on a connected device/emulator"
    @echo ""
    @echo -e "{{bold}}Test{{reset}}"
    @echo "  just unit-test               Run unit tests (JVM, fast)"
    @echo "  just test-instrumented       Run instrumented tests on a connected device/emulator"
    @echo ""
    @echo -e "{{bold}}Lint / Format{{reset}}"
    @echo "  just lint-check              ktlint + Android Lint (see tools/validation/justfile)"
    @echo "  just format                 Auto-fix ktlint formatting issues"
    @echo ""
    @echo -e "{{bold}}CI / Maintenance{{reset}}"
    @echo "  just check                  Full local pre-PR gate: lint -> unit tests -> debug build"
    @echo "  just pre-commit              Run pre-commit hooks against all files"
    @echo "  just clean                   Remove all Gradle build outputs"
    @echo ""
    @echo -e "{{bold}}Docs{{reset}}"
    @echo "  just build-docs              Build the MkDocs documentation site"
    @echo ""
    @echo -e "{{bold}}Optional backend (infra/){{reset}}"
    @echo "  just docker-up               Start the optional backend stack locally"
    @echo "  just docker-down             Stop the optional backend stack"
    @echo ""
    @echo "Run 'just <module>::' with no recipe to list that module's recipes, e.g. 'just build::'"

# --- Shorthands ---
# Note: none of these share a name with a `mod` above (just forbids that);
# use the module directly (e.g. `just build::debug`) for anything not listed here.

# Assemble the debug APK
apk: helper::_print_header
    just build::debug

# Assemble a signed release App Bundle (.aab) for the Play Store
assemble-release: helper::_print_header
    just build::release

# Install the debug build on a connected device/emulator
install: helper::_print_header
    just build::install

# Run unit tests (JVM, fast)
unit-test: helper::_print_header
    just test::unit

# Run instrumented tests on a connected device/emulator
test-instrumented: helper::_print_header
    just test::instrumented

# Run ktlint + Android Lint
lint-check: helper::_print_header
    just validation::check

# Auto-fix ktlint formatting issues
format: helper::_print_header
    just validation::fix

# Full local pre-PR gate: lint, unit tests, debug build
check: helper::_print_header
    just ci::pr-gate

# Run pre-commit hooks against all files
pre-commit: helper::_print_header
    just ci::pre-commit

# Clean all Gradle build outputs
clean: helper::_print_header
    just reducer::clean

# Build the MkDocs documentation site
build-docs: helper::_print_header
    just docs::build

# Start the optional backend stack locally
docker-up: helper::_print_header
    just infra::docker-up

# Stop the optional backend stack
docker-down: helper::_print_header
    just infra::docker-down
