#!/usr/bin/env bash
# Allow Nix store binaries to create user namespaces (required for Electron apps).
# Creates a targeted AppArmor profile that permits only /nix/store/** to use
# unprivileged user namespaces, without weakening system-wide security.

set -eu

PROFILE="/etc/apparmor.d/nix-packages"

if [ ! -f "$PROFILE" ]; then
    echo "Creating AppArmor profile for Nix store binaries..."
    sudo tee "$PROFILE" >/dev/null <<'EOF'
abi <abi/4.0>,
include <tunables/global>

profile nix-store-binaries /nix/store/** flags=(unconfined) {
    userns,
}
EOF
    sudo service apparmor reload
    echo "AppArmor profile installed and loaded."
else
    echo "AppArmor profile already exists, skipping."
fi
