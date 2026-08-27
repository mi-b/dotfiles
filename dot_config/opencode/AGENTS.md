# Coding Preferences

These are my global coding preferences. They apply to all projects unless
overridden by a project-level `.opencode/AGENTS.md`.

## Tone and Language

- Write in **British English** (organise, colour, behaviour, centre, defence, serialise, etc.)
- Be concise and direct. No unnecessary praise or filler
- Humour and wit are welcome — dry, dark, and self-deprecating preferred
- Prioritise technical accuracy over diplomacy. Disagree when warranted
- Don't pad messages with pleasantries. Get to the point

## Git Workflow

### Commits

- Follow **conventional commits**: `type(scope): description`
  - Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `perf`, `build`, `revert`
- Keep commits **atomic**: one logical change per commit. Each commit should
  compile, pass tests, and represent a single coherent change
- If a commit message needs "and", it should probably be two commits
- Write commit messages in imperative mood ("add feature" not "added feature")

### Branching and Merging

- Use **stable mainline branching**: short-lived feature/fix branches off `main`
- Branch naming: `type/short-description` (e.g., `fix/broken-link`, `feat/auth-module`)
- Prefer **semi-linear merge** (rebase + merge commit): rebase onto `main`
  first, then merge with `--no-ff` to preserve branch context
- Use `git push --force-with-lease`, never bare `--force`

### Non-interactive Git

When running `git rebase` or any git command that may open an editor, always
set `GIT_SEQUENCE_EDITOR=true` and `GIT_EDITOR=true` as environment variables
to prevent editors from launching in the non-interactive agent context. For
example: `GIT_SEQUENCE_EDITOR=true GIT_EDITOR=true git rebase --onto ...`

### Hooks

- Use `.githooks/` directory with `git config core.hooksPath .githooks`
- Pre-commit: run format check scripts
- Commit-msg: enforce conventional commit format

## Python

- **Package manager**: `uv` (always, no exceptions for new projects)
- **Linter/formatter**: `ruff` (replaces flake8, isort, black)
- **Type checker**: `ty` (from Astral)
- **Config**: everything in `pyproject.toml` — no `requirements.txt`,
  `setup.py`, or `setup.cfg` for new projects
- **Virtual environments**: managed by `uv`, never install globally
- **Style**: PEP 8 via `ruff`, Google-style docstrings
- Run tools via `uv run` (e.g., `uv run pytest`, `uv run ruff check .`)

## Containers

- Use Docker for non-trivial dependency management
- **Multi-stage builds**: separate build from runtime
- **Non-root users**: always create and switch to a dedicated user
- **`.dockerignore`**: always include one
- **Pin base images**: use specific versions (e.g., `python:3.13-slim`), not `latest`
- **Layer ordering**: rarely-changing instructions first, application code last
- Use `docker compose` (v2 plugin, no hyphen), not `docker-compose`
- Prefer slim or distroless base images

## Code Quality

- **KISS**: favour clarity over cleverness. Complexity is a cost
- **DRY**: extract shared logic, but don't over-abstract prematurely
- **YAGNI**: don't write code for features you might need later
- **Naming**: descriptive, pronounceable, consistent. Follow language conventions
  (Python: `snake_case` functions, `PascalCase` classes, `UPPER_CASE` constants)
- **Format checking**: use a single `scripts/format_check.sh` that covers all
  file types and runs both locally and in CI
- Integrate linters and formatters in the IDE and enforce them in CI

## Documentation

- Every project needs a `README.md` at minimum
- For larger projects, follow the **Diataxis** model: tutorials, how-to guides,
  reference, explanation
- Code should be self-documenting first. Use docstrings sparingly — not for
  obvious functions
- Use Markdown with GitLab-flavoured extensions (alerts, mermaid diagrams,
  collapsible sections)
- Use `mkdocs` for web rendering when needed
- **Equations in Markdown**: display equations (`$$`) are part of the
  surrounding sentence. Do not use a colon before an equation. End the
  equation with a period if it ends the sentence, or a comma if the sentence
  continues (e.g. "where …")

## Security

- **Never commit secrets** (API keys, passwords, tokens). Use `.env` files
  (gitignored) and `.env.example` with placeholders
- Use `gitleaks` or `git-secrets` to prevent accidental commits
- Sign commits with GPG or SSH keys
- Scan dependencies for vulnerabilities (Dependabot, Renovate, Trivy, pip-audit)
- Rotate any secret that was ever committed — assume it's compromised

## CI/CD

- Pipelines should lint, type-check, and test (in that order)
- Use a dedicated CI container image for reproducible runs
- Fail fast — don't wait 10 minutes to find a broken import
- Use caching for dependencies
- Prefer GitLab CI/CD or GitHub Actions

## Project Structure

Consistent structure across projects:

```
/project
├── src/           # Source code
├── tests/         # Tests
├── docs/          # Documentation
├── scripts/       # Utility scripts (format_check.sh, etc.)
├── docker/        # Docker configuration (if containerised)
├── .githooks/     # Git hooks
├── .gitignore
├── .gitattributes
├── pyproject.toml # Python config (if applicable)
├── README.md
└── LICENSE.md
```

## Versioning

- Use **semantic versioning** (MAJOR.MINOR.PATCH)
- Tag releases with `git tag -a v1.2.0 -m "Release v1.2.0"`
- Automate changelogs with `git-cliff` or `release-please` where feasible

## Per-Project Overrides

To override these preferences for a specific project, create
`.opencode/opencode.json` in the project root:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["AGENTS.md"]
}
```

Then create `.opencode/AGENTS.md` with project-specific adjustments.
Project instructions are merged on top of these global defaults.
