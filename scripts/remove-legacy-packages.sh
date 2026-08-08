#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# Remove software that is now managed by Nix / Home Manager / Flatpak.
# Run this AFTER a successful `chezmoi apply` on the nixpkgs branch.
#
# This script is intentionally not a chezmoi run_once script — you should
# run it manually once you have verified everything works via Nix.
# ---------------------------------------------------------------------------

set -eu

echo "=== Removing apt packages now provided by Nix ==="

# CLI tools (from run_onchange_install-devtools.sh)
sudo apt-get remove -y \
    bat \
    direnv \
    fd-find \
    fzf \
    git-delta \
    golang-go \
    htop \
    imagemagick \
    jq \
    just \
    latexmk \
    nodejs \
    pandoc \
    podman \
    poppler-utils \
    python3-pip \
    python3-venv \
    ripgrep \
    shfmt \
    tmux \
    unzip \
    woff2 \
    zoxide \
    2>/dev/null || true

# Fonts (from run_onchange_install-fonts.sh)
sudo apt-get remove -y \
    fonts-noto \
    fonts-firacode \
    fonts-powerline \
    2>/dev/null || true

# Packages now provided by Nix that the first pass missed
sudo apt-get remove -y \
    7zip \
    texlive-xetex \
    2>/dev/null || true

# NOTE: kitty stays on apt — GPU-accelerated apps cannot run from Nix
# on non-NixOS (missing system OpenGL/Nvidia drivers).

# Desktop apps now on Flatpak (from run_once_install-desktop-apps.sh)
sudo apt-get remove -y \
    gimp \
    inkscape \
    vlc \
    code \
    firefox \
    2>/dev/null || true

# Remove Google Chrome .deb package
if dpkg -l google-chrome-stable >/dev/null 2>&1; then
    sudo apt-get remove -y google-chrome-stable
fi

# Remove VS Code apt source
sudo rm -f /etc/apt/sources.list.d/vscode.list
sudo rm -f /etc/apt/keyrings/packages.microsoft.gpg

# Remove Firefox PPA
if command -v add-apt-repository >/dev/null 2>&1; then
    sudo add-apt-repository --remove -y ppa:mozillateam/ppa 2>/dev/null || true
fi

echo ""
echo "=== Removing manually installed binaries ==="

# Binaries installed to /usr/local/bin by old scripts
sudo rm -f /usr/local/bin/resvg
sudo rm -f /usr/local/bin/yazi
sudo rm -f /usr/local/bin/lazygit

# Binaries installed to ~/.local/bin by old scripts
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

# FiraCode Nerd Font (now via Nix)
rm -f "$HOME/.local/share/fonts/"*FiraCode*Nerd*

echo ""
echo "=== Removing Mason data (LSPs now via Nix) ==="
rm -rf "$HOME/.local/share/nvim/mason"

echo ""
echo "=== Cleaning up ==="
sudo apt-get autoremove -y
sudo apt-get autoclean

echo ""
echo "Done. Verify everything works via Nix, then enjoy the cleaner system."
