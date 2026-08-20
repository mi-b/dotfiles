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
    starship
    tmux
    tree-sitter
    typst
    unzip
    uv
    woff2
    yazi
    p7zip

    # --- versioning ---
    delta
    git
    git-filter-repo
    git-lfs
    lazygit

    # --- X11 clipboard (needed for i3/X11 setups) ---
    xclip

    # --- media ---
    ffmpeg
    eog

    # --- LSP servers ---
    lua-language-server
    typescript-language-server
    ruff
    # ty  # Astral's type checker — uncomment when available in nixpkgs
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
