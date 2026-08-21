#!/usr/bin/env bash

set -eu

# ---------------------------------------------------------------------------
# Register git-lfs smudge/clean hooks in the global git config.
# Runs once per machine via chezmoi.  git-lfs is installed by Home Manager;
# this script is safe to run before or after — it will simply no-op if the
# binary is not yet available (chezmoi apply can be re-run later).
# ---------------------------------------------------------------------------

if command -v git-lfs >/dev/null 2>&1; then
    echo "Registering git-lfs hooks..."
    git lfs install
else
    echo "git-lfs not found — skipping hook registration."
fi
