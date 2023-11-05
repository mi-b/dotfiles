#!/usr/bin/env bash
# shellcheck disable=SC1091
# Some minimal tools to get you started in the VM

set -e
set -u

DIR=$(cd "$(dirname "$0")" && pwd)/..
. "$DIR/.env"

export NIXPKGS_ALLOW_UNFREE=1

nix-env -iA \
    nixos.gitFull \
    nixos.lazygit \
    nixos.curl \
    nixos.neovim \
    nixos.wezterm \
    nixos.tmux \
    nixos.clang \
    nixos.google-chrome \
    nixos.chezmoi \
    nixos.zsh

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global credential.helper "cache --timeout 72000"

"$DIR/install-home.sh"
