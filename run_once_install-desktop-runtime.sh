#!/usr/bin/env bash
# Install shared desktop runtime packages (system-level only).

set -eu

sudo apt-get update
sudo apt-get install -y \
    pipewire \
    wireplumber \
    network-manager-gnome \
    policykit-1-gnome \
    uidmap
