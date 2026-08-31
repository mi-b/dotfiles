{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Core CLI tools ---

    curl
    comma
    copyq
    fd # programs.fd
    file
    htop # programs.htop
    jq # programs.jq
    opencode
    imagemagick
    just
    neovim # programs.neovim
    pandoc # programs.pandoc
    ripgrep # programs.ripgrep
    texliveSmall
    nodejs
    podman
    poppler-utils
    python3
    resvg
    shfmt
    tree-sitter
    typst
    unzip
    uv
    woff2
    p7zip

    # --- versioning ---
    git-filter-repo

    # --- ide ---
    vscode

    # --- X11 clipboard (needed for i3/X11 setups) ---
    xclip

    # --- media ---
    ffmpeg
    eog
    # nixGL wrapper required for GPU-accelerated apps on non-NixOS — without
    # it, Nix binaries cannot find the host system's GL/EGL drivers.
    (config.lib.nixGL.wrap gimp)
    (config.lib.nixGL.wrap inkscape)
    (config.lib.nixGL.wrap vlc)
    (config.lib.nixGL.wrap spotify)

    # --- desktop utilities ---
    brightnessctl
    playerctl
    pavucontrol

    # --- LSP servers ---
    lua-language-server
    typescript-language-server
    ruff
    ty
    clang-tools
    taplo
    tinymist
    yaml-language-server
    bash-language-server
    nixd

    # --- Formatters ---
    nixfmt
    stylua
    prettier

    # --- Linters ---
    shellcheck
    hadolint
    markdownlint-cli2
    yamllint

    # --- Fonts ---
    nerd-fonts.fira-code
    noto-fonts
    fira-code
  ];
}
