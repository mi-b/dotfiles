# Hyprlock — Catppuccin Mocha lock screen
{ config, lib, ... }:

{
  programs.hyprlock = lib.mkIf (config.host.wm == "hyprland") {
    enable = true;

    settings = {
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 6;
          brightness = 0.7;
        }
      ];

      input-field = [
        {
          size = "280, 50";
          dots_size = 0.3;
          dots_spacing = 0.2;
          outer_color = "rgba(b4befeff)";
          inner_color = "rgba(313244ff)";
          font_color = "rgba(cdd6f4ff)";
          check_color = "rgba(a6e3a1ff)";
          fail_color = "rgba(f38ba8ff)";
          fade_on_empty = false;
          rounding = 10;
          placeholder_text = "";
          position = "0, -20";
        }
      ];

      label = [
        # Time
        {
          text = "$TIME";
          font_size = 72;
          font_family = "FiraCode Nerd Font";
          color = "rgba(cdd6f4ff)";
          position = "0, 120";
        }
        # Date
        {
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          font_size = 20;
          font_family = "FiraCode Nerd Font";
          color = "rgba(a6adc8ff)";
          position = "0, 50";
        }
      ];
    };
  };
}
