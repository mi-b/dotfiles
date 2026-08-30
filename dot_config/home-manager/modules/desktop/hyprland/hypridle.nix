# Hypridle — conservative idle timers
{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.hypridle = lib.mkIf (config.host.wm == "hyprland") {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "sleep 1 && hyprctl dispatch dpms on";
      };

      listener = [
        # Dim screen after 3 minutes
        {
          timeout = 180;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        # Lock screen after 10 minutes
        {
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        # Turn off display after 15 minutes
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
