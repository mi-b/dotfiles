{ config, lib, ... }:

{
  programs.wofi = lib.mkIf (config.host.wm == "hyprland") {
    enable = true;
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
    style = ''
      /* Wofi style — Catppuccin Mocha */

      * {
          font-family: FiraCode Nerd Font, Noto Sans, sans-serif;
          color: #cdd6f4;
          background: transparent;
      }

      #window {
          background: rgba(30, 30, 46, 0.92);
          margin: auto;
          padding: 5px;
          border-radius: 12px;
          border: 2px solid #b4befe;
      }

      #input {
          padding: 8px;
          margin-bottom: 10px;
          border-radius: 8px;
          background-color: #313244;
          color: #cdd6f4;
      }

      #outer-box {
          padding: 15px;
      }

      #img {
          margin-right: 10px;
      }

      #entry {
          padding: 6px;
          border-radius: 8px;
      }

      #entry:selected {
          background-color: #45475a;
      }

      #text {
          margin: 2px;
      }
    '';
  };
}
