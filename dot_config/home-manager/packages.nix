{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Core CLI tools ---
    # (bat, fzf, zoxide, direnv are installed by HM program modules in programs.nix)
    curl
    comma
    fd
    file
    go
    ripgrep
    htop
    imagemagick
    jq
    just
    texliveSmall # provides latexmk and basic LaTeX
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
    yazi
    p7zip

    # --- versioning ---
    git-filter-repo

    # --- X11 clipboard (needed for i3/X11 setups) ---
    xclip

    # --- media ---
    ffmpeg
    eog

    # --- LSP servers ---
    lua-language-server
    typescript-language-server
    ruff
    ty
    clang-tools # provides clangd + clang-format
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
