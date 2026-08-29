{ config, lib, ... }:

{
  # Clear wofi's drun cache on every HM activation.  Home Manager rebuilds
  # ~/.nix-profile on switch, which changes nix store paths.  Wofi caches
  # .desktop file paths and silently drops entries whose paths went stale.
  home.activation.clearWofiCache = lib.mkIf (config.host.wm == "hyprland") (
    lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      rm -f ~/.cache/wofi-drun
    ''
  );

  programs.wofi = lib.mkIf (config.host.wm == "hyprland") {
    enable = true;
    style = ''
      * {
        font-family: "FiraCode Nerd Font", monospace;
        font-size: 13px;
      }

      window {
        background-color: #1e1e2e;
        color: #cdd6f4;
        border: 2px solid #89b4fa;
        border-radius: 12px;
      }

      #input {
        background-color: #313244;
        color: #cdd6f4;
        border: none;
        border-radius: 8px;
        padding: 8px 12px;
        margin: 8px;
      }

      #input:focus {
        border: 2px solid #89b4fa;
      }

      #outer-box {
        margin: 4px;
      }

      #scroll {
        margin: 0 4px;
      }

      #entry {
        padding: 6px 12px;
        border-radius: 8px;
      }

      #entry:selected {
        background-color: #89b4fa;
        color: #1e1e2e;
      }

      #entry image {
        margin-right: 8px;
      }

      #text {
        color: #cdd6f4;
      }

      #text:selected {
        color: #1e1e2e;
      }
    '';
    settings = {
      hide_scroll = true;
      show = "drun";
      width = "30%";
      lines = 8;
      line_wrap = "word";
      term = "kitty";
      allow_markup = true;
      layer = "overlay";
      allow_images = true;
      sort_order = "alphabetical";
      gtk_dark = true;
      image_size = 24;
      display_generic = false;
      location = "center";
      key_expand = "Tab";
      insensitive = true;
    };
  };
}
