#!/usr/bin/env bash
#
# close-window.sh — safe close for Hyprland
#
# Refuses to close a kitty window if it contains a neovim process.
# For all other windows, dispatches kill as normal.

set -euo pipefail

active_window=$(hyprctl activewindow -j)
window_class=$(echo "$active_window" | jq -r '.class')
window_pid=$(echo "$active_window" | jq -r '.pid')

# Only guard kitty windows; everything else closes immediately.
if [[ "$window_class" != "kitty" ]]; then
    hyprctl eval "hl.dispatch(hl.dsp.window.kill())"
    exit 0
fi

# Check if neovim is anywhere in the process subtree.
if pstree -p "$window_pid" 2>/dev/null | grep -qP 'nvim\(\d+\)'; then
    notify-send -u critical "Neovim" "This window contains a neovim process. Close neovim first."
    exit 1
fi

# No neovim — safe to close.
hyprctl eval "hl.dispatch(hl.dsp.window.kill())"
