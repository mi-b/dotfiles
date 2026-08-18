#!/usr/bin/env bash

set -eu

# ---------------------------------------------------------------------------
# Bootstrap script: installs Nix (Determinate Systems) and Flatpak.
# Runs once per machine via chezmoi.
# ---------------------------------------------------------------------------

# --- Nix -------------------------------------------------------------------

if ! command -v nix >/dev/null 2>&1; then
    echo "Installing Nix (Determinate Systems installer)..."
    curl --proto '=https' --tlsv1.2 -sSf -L \
        https://install.determinate.systems/nix | sh -s -- install --no-confirm --no-modify-profile
    echo "Nix installed. You may need to restart your shell or source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
else
    echo "Nix is already installed."
fi

# --- Flatpak ---------------------------------------------------------------

if ! command -v flatpak >/dev/null 2>&1; then
    echo "Installing Flatpak..."
    sudo apt-get update
    sudo apt-get install -y flatpak
fi

# Add Flathub remote (idempotent)
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Bootstrap complete."
