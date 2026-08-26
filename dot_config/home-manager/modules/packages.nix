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
    fd
    file
    opencode
    ripgrep
    htop
    imagemagick
    jq
    just
    texliveSmall
    nodejs
    neovim
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
    (symlinkJoin {
      name = "signal-desktop-wrapped";
      paths = [ signal-desktop ];
      nativeBuildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/signal-desktop \
          --add-flags "--no-sandbox"
      '';
    })

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
