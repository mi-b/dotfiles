#!/usr/bin/env bash
set -euo pipefail
root="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
uv run --project "$root" --locked ruff format --check "$root/scripts" "$root/tests"
uv run --project "$root" --locked ruff check "$root/scripts" "$root/tests"
if [[ "${1:-}" == "--format-only" ]]; then
    exit 0
fi
uv run --project "$root" --locked ty check "$root/scripts" "$root/tests"
uv run --project "$root" --locked python -m unittest discover -s "$root/tests" -v
