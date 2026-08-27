{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Core CLI tools ---
    coreutils
    findutils
    binutils

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

    # --- X11 clipboard (needed for i3/X11 setups) ---
    xclip

    # --- media ---
    ffmpeg
    eog
    gimp
    inkscape

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
    nixfmt-rfc-style
    stylua
    prettier

    # --- Fonts ---
    nerd-fonts.fira-code
    noto-fonts
    fira-code
  ];
}
