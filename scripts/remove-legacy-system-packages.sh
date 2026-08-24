#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# Remove SYSTEM-WIDE software now managed by Nix / Home Manager / Flatpak.
# Run this AFTER a successful `chezmoi apply` on the nixpkgs branch.
#
# WARNING: This script uses sudo and removes apt packages, PPAs, and shared
# binaries. Do NOT run on multi-user machines unless you are certain no other
# user depends on these packages.
# ---------------------------------------------------------------------------

set -eu

echo "WARNING: This will remove system-wide apt packages and shared binaries."
echo "         Do NOT run this on a shared machine unless you are the only user."
echo ""
read -rp "Continue? [y/N] " confirm
if [[ "${confirm,,}" != "y" ]]; then
    echo "Aborted."
    exit 0
fi

echo ""
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

# Desktop components now managed by Home Manager
sudo apt-get remove -y \
    dunst \
    wofi \
    rofi \
    picom \
    2>/dev/null || true

# NOTE: kitty stays on apt — GPU-accelerated apps cannot run from Nix
# on non-NixOS (missing system OpenGL/Nvidia drivers).

echo ""
echo "=== Removing desktop apps now on Flatpak ==="

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
echo "=== Removing manually installed binaries from /usr/local/bin ==="

sudo rm -f /usr/local/bin/resvg
sudo rm -f /usr/local/bin/yazi
sudo rm -f /usr/local/bin/lazygit

echo ""
echo "=== Cleaning up ==="
sudo apt-get autoremove -y
sudo apt-get autoclean

echo ""
echo "Done. Verify everything works via Nix, then enjoy the cleaner system."
