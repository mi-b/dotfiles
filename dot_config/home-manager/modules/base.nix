{ lib, nixgl, ... }:

{
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

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

    # GPU driver integration via /run/opengl-driver (system-wide, affects all
    # users). Replaced by nixGL which wraps individual apps instead.
    # gpu = {
    #   enable = true;
    #   nvidia = {
    #     enable = true;
    #     version = "580.173.02";
    #     sha256 = "sha256-jY65AB4FqaimY9PV0wT+tk7yhE7hhczf2VJ4aCD0bhs=";
    #   };
    # };
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.opencode/bin"
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

  # Explicitly export XDG base directory variables (XDG_CONFIG_HOME,
  # XDG_DATA_HOME, XDG_STATE_HOME, XDG_CACHE_HOME) in the session environment,
  # ensuring Home Manager and all XDG-aware tools agree on paths.
  xdg.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "image/bmp" = "org.gnome.eog.desktop";
      "image/webp" = "org.gnome.eog.desktop";
      "image/tiff" = "org.gnome.eog.desktop";
      "image/svg+xml" = "org.gnome.eog.desktop";
      "x-scheme-handler/http" = "org.mozilla.firefox.desktop";
      "x-scheme-handler/https" = "org.mozilla.firefox.desktop";
      "text/html" = "org.mozilla.firefox.desktop";
      "application/xhtml+xml" = "org.mozilla.firefox.desktop";
    };
  };

  # Force-overwrite mimeapps.list — GNOME rewrites this file when you change
  # default applications via the GUI, which conflicts with HM's symlink.
  xdg.configFile."mimeapps.list".force = true;
}
