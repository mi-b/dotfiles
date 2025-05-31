#!/usr/bin/env sh

set -e

sudo apt update && sudo apt install -y \
    batcat \
    curl \
    ffmpeg \
    firefox \
    fzf \
    git \
    git-lfs \
    gnome-tweaks \
    fonts-powerline \
    grep \
    inkscape \
    python3-pip \
    python3-venv \
    ripgrep \
    tmux \
    vlc \
    woff2 \
    zoxide

git lfs install

# === Visual Studio Code ===
if ! command -v code >/dev/null 2>&1; then
    echo "Installing VS Code..."
    sudo apt-get -y install wget gpg apt-transport-https
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
    rm -f packages.microsoft.gpg

    sudo apt update
    sudo apt install -y code
else
    echo "VS Code already installed."
fi

# === Google Chrome ===
if ! command -v google-chrome >/dev/null 2>&1; then
    echo "Installing Google Chrome..."
    curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm -f google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome already installed."
fi

# === Kitty Terminal ===
if ! command -v kitty >/dev/null 2>&1; then
    echo "Installing Kitty..."
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    mkdir -p ~/.local/bin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
else
    echo "Kitty already installed."
fi

# === uv (Rust Python package manager) ===
if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -Ls https://astral.sh/uv/install.sh | sh
else
    echo "uv already installed."
fi

# === Node.js & npm via NodeSource (for latest version) ===
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
    echo "Installing Node.js & npm from NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "Node.js and npm already installed."
fi

# currently unused
# ================
# build-essential
# fd-find
# golang-go
# gparted
# imagemagick
# signal-desktop
# steam:i386

# link bat to batcat
SYMLINK="$HOME/.local/bin/bat"
TARGET="$(command -v batcat || true)"

# 1. Symlink bat → batcat if needed
if [ -n "$TARGET" ] && [ ! -e "$SYMLINK" ]; then
    echo "🔗 Linking batcat → bat at $SYMLINK"
    mkdir -p "$HOME/.local/bin"
    ln -s "$TARGET" "$SYMLINK"
else
    echo "✅ bat symlink already exists or batcat not found"
fi

# 2. Ensure ~/.local/bin is in PATH (idempotent)
LINE='export PATH="$HOME/.local/bin:$PATH"'
ZSHRC="$HOME/.zshrc"

if [ -f "$ZSHRC" ] && ! grep -qxF "$LINE" "$ZSHRC"; then
    echo "🔧 Adding ~/.local/bin to PATH in .zshrc"
    echo "$LINE" >>"$ZSHRC"
else
    echo "✅ PATH already includes ~/.local/bin in .zshrc"
fi
