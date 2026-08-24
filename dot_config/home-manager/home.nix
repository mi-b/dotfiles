{ pkgs, ... }@args:

{
  home.username = args.username;
  home.homeDirectory = args.homeDirectory;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  # Let Home Manager manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages (e.g. google-chrome if ever needed via Nix).
  nixpkgs.config.allowUnfree = true;

  # Directories prepended to $PATH via HM session vars.
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.opencode/bin"
    "$HOME/go/bin"
  ];

  # Session-level environment variables, inherited by all applications.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_GB.UTF-8";
  };

  # Ensure font cache is rebuilt when fonts change.
  fonts.fontconfig.enable = true;

  # Default applications for common file types.
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
  xdg.configFile."mimeapps.list".force = true;
}
