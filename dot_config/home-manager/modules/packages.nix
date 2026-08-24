{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Core CLI tools ---
    curl
    comma
    fd
    file
    opencode
    ripgrep
    htop
    imagemagick
    jq
    just
    texliveSmall
    neovim
    nodejs
    pandoc
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

    # --- X11 clipboard (needed for i3/X11 setups) ---
    xclip

    # --- media ---
    ffmpeg
    eog

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

    # --- Formatters ---
    stylua
    prettier

    # --- Fonts ---
    nerd-fonts.fira-code
    noto-fonts
    fira-code
  ];
}
