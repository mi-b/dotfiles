{ config, lib, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in

{
  programs.rofi = lib.mkIf (config.host.wm == "i3") {
    enable = true;
    font = "FiraCode Nerd Font 11";
    terminal = "kitty";
    modes = [
      "drun"
      "run"
    ];

    extraConfig = {
      show-icons = true;
      drun-display-format = "{name}";
      case-sensitive = false;
      display-drun = "Applications";
      hover-select = false;
      me-select-entry = "";
    };

    theme = {
      "*" = {
        bg = mkLiteral "#1e1e2e";
        bg-alt = mkLiteral "#181825";
        fg = mkLiteral "#cdd6f4";
        muted = mkLiteral "#6c7086";
        border = mkLiteral "#89b4fa";
        selected = mkLiteral "#89b4fa";
        selected-fg = mkLiteral "#1e1e2e";
        urgent = mkLiteral "#f38ba8";
      };

      window = {
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        width = mkLiteral "34%";
        border = mkLiteral "2px";
        border-radius = mkLiteral "14px";
        border-color = mkLiteral "@border";
        background-color = mkLiteral "@bg";
        padding = mkLiteral "16px";
      };

      mainbox = {
        background-color = mkLiteral "transparent";
        spacing = mkLiteral "12px";
        children = map mkLiteral [ "inputbar" "message" "listview" ];
      };

      inputbar = {
        background-color = mkLiteral "@bg-alt";
        border = mkLiteral "0px";
        border-radius = mkLiteral "10px";
        padding = mkLiteral "10px 14px";
        spacing = mkLiteral "10px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      prompt = {
        enabled = true;
        text-color = mkLiteral "@border";
        background-color = mkLiteral "transparent";
      };

      entry = {
        text-color = mkLiteral "@fg";
        background-color = mkLiteral "transparent";
        placeholder = "Search applications";
        placeholder-color = mkLiteral "@muted";
      };

      message = {
        enabled = false;
      };

      listview = {
        background-color = mkLiteral "transparent";
        columns = 1;
        lines = 8;
        cycle = true;
        dynamic = true;
        fixed-height = false;
        scrollbar = false;
        spacing = mkLiteral "8px";
      };

      element = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        orientation = mkLiteral "horizontal";
        border-radius = mkLiteral "10px";
        padding = mkLiteral "8px 10px";
        spacing = mkLiteral "10px";
      };

      "element selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@selected-fg";
      };

      "element urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@selected-fg";
      };

      element-icon = {
        background-color = mkLiteral "transparent";
        size = mkLiteral "1.4em";
      };

      element-text = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
