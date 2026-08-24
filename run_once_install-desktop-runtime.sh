#!/usr/bin/env bash
# Install shared desktop runtime packages needed by any window manager.

set -eu

missing=0
for cmd in kitty brightnessctl playerctl pavucontrol; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing=1
        break
    fi
done

if [ "$missing" -eq 0 ]; then
    echo "Desktop runtime packages already installed."
    exit 0
fi

echo "Updating package lists for apt"
sudo apt-get update

echo "Installing shared desktop runtime packages..."
sudo apt-get install -y \
    pipewire \
    wireplumber \
    brightnessctl \
    playerctl \
    pavucontrol \
    network-manager-gnome \
    policykit-1-gnome

# NOTE: brightnessctl may need setuid (chmod +s) on laptops with physical
# backlights. Skipped here to avoid machine-wide security changes on shared
# systems. Run `sudo chmod +s "$(which brightnessctl)"` manually if needed.

echo "Desktop runtime installation complete."
