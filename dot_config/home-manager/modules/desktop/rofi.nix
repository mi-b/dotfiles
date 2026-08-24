{ config, lib, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = lib.mkIf (config.host.wm == "i3") {
    enable = true;
    font = "FiraCode Nerd Font 11";
    terminal = "kitty";
    modes = [ "drun" "run" ];

    extraConfig = {
      show-icons = true;
      drun-display-format = "{name}";
      case-sensitive = false;
    };

    theme = {
      "@theme" = "/dev/null";

      "*" = {
        base = mkLiteral "#1e1e2e";
        mantle = mkLiteral "#181825";
        surface0 = mkLiteral "#313244";
        surface1 = mkLiteral "#45475a";
        overlay0 = mkLiteral "#6c7086";
        text = mkLiteral "#cdd6f4";
        lavender = mkLiteral "#b4befe";
        red = mkLiteral "#f38ba8";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@text";
      };

      window = {
        width = mkLiteral "30%";
        background-color = mkLiteral "@base";
        border = mkLiteral "2px";
        border-color = mkLiteral "@lavender";
        border-radius = mkLiteral "8px";
        padding = 0;
      };

      mainbox = {
        background-color = mkLiteral "@base";
        children = map mkLiteral [ "inputbar" "listview" ];
      };

      inputbar = {
        background-color = mkLiteral "@surface0";
        padding = mkLiteral "12px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      prompt = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "@lavender";
        padding = mkLiteral "0 8px 0 0";
      };

      entry = {
        background-color = mkLiteral "inherit";
        placeholder = "Search...";
        placeholder-color = mkLiteral "@overlay0";
      };

      listview = {
        background-color = mkLiteral "@base";
        lines = 8;
        padding = mkLiteral "8px";
        spacing = mkLiteral "4px";
      };

      "element" = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "4px";
      };

      "element normal.normal" = {
        background-color = mkLiteral "@base";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@surface1";
        text-color = mkLiteral "@lavender";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "@base";
      };

      element-icon = {
        size = mkLiteral "20px";
        padding = mkLiteral "0 8px 0 0";
      };

      element-text = {
        highlight = mkLiteral "bold";
      };
    };
  };
}
