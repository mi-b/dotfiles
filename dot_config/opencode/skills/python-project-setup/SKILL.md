---
name: python-project-setup
description: >
  Use when creating, initialising, scaffolding, or modernising a Python project,
  or configuring development tooling in an existing Python package, including
  pyproject.toml, uv, ruff, ty, pytest, package layout, hooks, and CI.
  Produces a minimal verified project suited to an application or library. Do
  not use for routine Python implementation, dependency updates, debugging, or
  changes that do not affect project tooling or structure.
compatibility: Requires file editing and command execution; new projects require uv.
---

# Python Project Setup

Create the smallest complete Python project for the stated purpose.
Preserve established repository conventions when modernising an existing project.

## 1. Establish The Project Contract

Determine from the request and repository:

1. Whether this is an application, command-line tool, distributable library, or internal package.
2. The project and import names; do not assume they are identical.
3. The supported Python versions and operating systems.
4. Whether packaging, publishing, containers, CI, or a particular licence is required.
5. Whether existing users, lock files, build metadata, or release processes constrain migration.

Infer conventional choices when evidence is sufficient.
Ask only about decisions that materially affect the result, such as an unknown licence or incompatible migration paths.
Do not add publishing, containers, documentation sites, or release automation merely because they might be useful later.

## 2. Inspect Before Changing

- Read project instructions, documentation, `pyproject.toml`, lock files, CI configuration, and existing source and test layouts.
- Check the installed Python and `uv` versions before relying on version-specific behaviour.
- For migrations, identify every existing package, environment, lint, format, type, test, build, and automation entry point.
- Preserve supported behaviour and dependency constraints; do not silently replace working tools outside the requested scope.
- Never overwrite unrelated files or discard hand-written configuration generated tools do not understand.

If the selected workflow requires `uv` and it is unavailable, report the dependency and obtain approval before installing the executable.
Keep project dependencies and development tools in the managed environment, not global installations.
If installation is declined, do not silently substitute another manager; report blocked setup and verification steps.

## 3. Create The Minimum Structure

For a new importable project, normally create:

```text
project/
├── src/<import_name>/
├── tests/
├── pyproject.toml
├── README.md
├── LICENSE.md
├── .gitignore
└── .gitattributes
```

Add `docs/`, `scripts/`, `docker/`, `.githooks/`, or `.env.example` only when the project uses them.
Create `LICENSE.md` only after the licence is established; never invent licence terms or a copyright holder.
Use a `src/` layout for importable packages unless the repository has a deliberate alternative.
Keep package initialisation minimal and add a console entry point only for an actual command-line interface.

Use `uv` to initialise new projects and manage their environments and dependencies.
For existing projects, adopt it only when migration is requested or already established.
Treat `pyproject.toml` as the authoritative configuration; do not create `requirements.txt`, `setup.py`, or `setup.cfg` for a new project.
Use the current `uv`-generated build configuration rather than copying stale backend metadata.

## 4. Configure Development Tools

- Put runtime requirements in `[project.dependencies]`, published optional features in `[project.optional-dependencies]`, and development tooling in `[dependency-groups]` when supported by the selected manager.
- Configure `ruff` as formatter and linter, with its target version matching the supported Python floor.
- Configure `ty` for static type checking without weakening diagnostics merely to obtain a clean first run.
- Use `pytest` and keep tests outside the installed package.
- Add only tool settings that differ from sensible defaults or make the project contract explicit.
- Keep one documented, cross-platform format-check entry point and reuse it in hooks and CI.

Commit `uv.lock` for applications and tools.
For libraries, follow repository policy and distinguish the development lock from published dependency constraints.

## 5. Add Supporting Automation When Required

- Make local commands and CI run the same checks in the same order: formatting or linting, type checking, then tests.
- Store repository hooks in `.githooks/`; do not alter a user's global Git configuration.
- Prefer the repository's existing CI platform. Pin third-party CI actions to an immutable revision when practical.
- Keep credentials out of configuration and examples. Use placeholders and ensure local secret files are ignored.
- Add Docker only for a concrete deployment or reproducibility requirement; use a pinned base, multi-stage build, non-root runtime user, and `.dockerignore`.
- Add build and publish jobs only for a project that will distribute artefacts.

## 6. Document The Working Path

The README should state:

- What the project is and which Python versions it supports.
- The shortest setup and execution path using the selected manager (`uv` for new projects).
- The canonical format, lint, type-check, and test commands.
- Build, configuration, or environment steps users genuinely need.

Do not document hypothetical workflows or repeat metadata already obvious from `pyproject.toml`.

## 7. Verify The Result

Use commands supported by the resulting configuration, normally including:

```console
uv sync --locked
uv run ruff format --check .
uv run ruff check .
uv run ty check
uv run pytest
```

Select any non-default development groups explicitly; do not install mutually exclusive groups together.
For an existing project using another manager, use its equivalent commands instead.
For a distributable project, also run `uv build` or the established build command and inspect the source and wheel contents.
Install the wheel into a separate temporary environment and check imports and any CLI entry point, including help output and exit status.
For migrations, compare package metadata, entry points, package data, and supported-version markers with the previous configuration.
Test the documented setup in a fresh environment when feasible; distinguish this from checks run in the current environment.
Run hooks or CI validation locally when the repository provides a supported route.

Report the selected project shape, files and tooling added or migrated, verification results, and anything not verified.
Do not claim the setup is complete when dependency resolution, tests, type checks, or builds failed.
