{ nixgl, ... }:

{
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Also expose the config to standalone nix commands (nix run, nix shell, etc.)
  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }\n";

  # Enable generic Linux desktop integration: appends ~/.nix-profile/share to
  # XDG_DATA_DIRS so the desktop environment discovers .desktop files, icons,
  # and MIME types from Nix-installed GUI applications.
  targets.genericLinux = {
    enable = true;

    nixGL.packages = nixgl.packages;
    nixGL.defaultWrapper = "nvidia";
    nixGL.offloadWrapper = "nvidiaPrime";
    nixGL.installScripts = [ "nvidia" ];
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_GB.UTF-8";
  };

  fonts.fontconfig.enable = true;

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "blue";
    nvim.enable = false;
  };
}
