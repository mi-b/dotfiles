# Coding Preferences

These defaults apply across projects unless project instructions or established
repository conventions override them.

## Tone and Language

- Write in **British English**.
- Be concise and direct; avoid praise, filler, and repeated conclusions.
- Prioritise technical accuracy over diplomacy.
- Dry, dark, and self-deprecating humour is welcome when it does not obscure the point.

## Changes and Verification

- Examine relevant code and project instructions before changing anything.
- Prefer the smallest correct change; apply KISS, DRY, and YAGNI without premature abstraction.
- Do not modify unrelated files or add compatibility code without a concrete requirement.
- Follow existing naming, architecture, formatting, and toolchain conventions.
- Use the repository's documented checks, starting narrow and expanding when warranted.
- Provide one documented format-check entry point suitable for the project's platforms and toolchain.
- Never claim success without fresh verification; report checks that were not run.

## Git Workflow

- Only commit, amend, rebase, merge, push, or create PRs when explicitly requested.
- Follow **conventional commits** using `type(scope): description`; use imperative mood and keep commits atomic.
- Use short-lived `type/short-description` branches from `main` and prefer semi-linear merges: rebase, then merge with `--no-ff`.
- Use `git push --force-with-lease`, never bare `--force`, and never skip hooks unless explicitly instructed.
- Store hooks in `.githooks/`; use pre-commit for format checks and commit-msg for conventional commit validation.
- For commands that may open an editor, set `GIT_SEQUENCE_EDITOR=true` and `GIT_EDITOR=true`.

## Python

- For new projects, use `uv` for packages and environments, `ruff` for linting and formatting, and `ty` for type checking.
- Run project tools through `uv run`; never install project dependencies globally.
- Keep configuration in `pyproject.toml`; do not create `requirements.txt`, `setup.py`, or `setup.cfg` for new projects.
- Follow PEP 8 and use Google-style docstrings where docstrings add value.

## Containers

- When containerising, use pinned slim or distroless bases, multi-stage builds, a non-root user, and a `.dockerignore`.
- Put stable layers before application code and use `docker compose`, not `docker-compose`.

## Documentation

- Every project needs a useful `README.md`; keep documentation consistent with actual behaviour.
- Follow the repository's existing format, renderer, and tooling.
- Keep code self-documenting; use comments and docstrings for non-obvious intent, not narration.
- For larger documentation sets, use Diataxis to separate tutorials, how-to guides, reference, and explanation.
- Use alerts, Mermaid, and collapsible sections only when the target Markdown renderer supports them.
- Treat display equations as sentence elements: no introductory colon, and include sentence punctuation.

## Security

- Never commit secrets; use ignored local files and placeholder examples such as `.env.example`.
- Use secret scanning, signed commits, and dependency vulnerability scanning where the repository supports them.
- Treat every committed secret as compromised and require rotation.

## CI/CD and Releases

- Pipelines should fail fast and run formatting or linting, type checks, and tests in that order, with appropriate caching.
- Prefer reproducible CI environments and GitLab CI/CD or GitHub Actions.
- Use semantic versioning, annotated `vX.Y.Z` tags, and automated changelogs where feasible.

## Project Layout

- For new projects, prefer clear top-level `src/`, `tests/`, `docs/`, and `scripts/` directories, adding `docker/` and `.githooks/` only when used.
- Include appropriate `.gitignore`, `.gitattributes`, `README.md`, and `LICENSE.md` files.

## Project Overrides

Put project-specific instructions in `.opencode/AGENTS.md` and reference them
from the project's `.opencode/opencode.json`. Project rules take precedence.
