set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

# Format the repo with the configured toolchain.
fmt:
    prettier --write --ignore-unknown README.md docs dot_config
    stylua .
    shfmt -w -i 4 .
    taplo format "**/*.toml"
    (cd dot_config/home-manager && nix fmt)

# Check formatting without modifying files.
fmt-check:
    prettier --check --ignore-unknown README.md docs dot_config
    stylua --check .
    shfmt -d -i 4 .
    taplo format --check "**/*.toml"
    (cd dot_config/home-manager && nix fmt -- --fail-on-change

# Lint Markdown files.
lint-md:
    markdownlint-cli2
