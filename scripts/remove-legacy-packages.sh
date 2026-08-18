#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# Remove user-local software remnants now managed by Nix / Home Manager.
# Run this AFTER a successful `chezmoi apply` on the nixpkgs branch.
#
# This script is safe to run on shared machines — it only touches files
# inside $HOME.
# ---------------------------------------------------------------------------

set -eu

echo "=== Removing manually installed binaries from ~/.local/bin ==="

rm -f "$HOME/.local/bin/tree-sitter"
rm -f "$HOME/.local/bin/ya"
rm -f "$HOME/.local/bin/starship"

# uv installer remnants
rm -f "$HOME/.local/bin/uv"
rm -f "$HOME/.local/bin/uvx"
rm -f "$HOME/.local/bin/env"

# Old Neovim install
rm -rf "$HOME/.local/opt/neovim"
rm -f "$HOME/.local/bin/nvim"

echo ""
echo "=== Removing FiraCode Nerd Font (now via Nix) ==="
rm -f "$HOME/.local/share/fonts/"*FiraCode*Nerd*

echo ""
echo "=== Removing Mason data (LSPs now via Nix) ==="
rm -rf "$HOME/.local/share/nvim/mason"

echo ""
echo "Done. User-local cleanup complete."
