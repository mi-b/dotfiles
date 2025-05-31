#!/bin/env bash

set -e

FONT_DIR="$HOME/.fonts"
FIRA_URL="https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"

# Create font directory
mkdir -p "$FONT_DIR"

# Temp directory for download and unzip
TMP_DIR=$(mktemp -d)

# Download and unzip Fira Code
curl -L "$FIRA_URL" -o "$TMP_DIR/fira.zip"
unzip -q "$TMP_DIR/fira.zip" -d "$TMP_DIR"

# Copy TTF fonts
cp "$TMP_DIR/ttf/"*.ttf "$FONT_DIR/"

# Clean up temp files
rm -rf "$TMP_DIR"

# Refresh font cache
fc-cache -fv "$FONT_DIR"

echo "✅ Fira Code fonts installed to $FONT_DIR"
