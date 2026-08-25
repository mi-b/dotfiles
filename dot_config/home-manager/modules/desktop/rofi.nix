{ config, lib, ... }:

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
    };
  };
}
