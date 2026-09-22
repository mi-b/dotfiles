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
        # Keep inhibitor handling explicit so browser/video behaviour does not
        # depend on upstream defaults.
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;
      };

      listener = [
        # Dim screen after 30 minutes
        {
          timeout = 1800;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        # Lock screen after 100 minutes
        {
          timeout = 6000;
          on-timeout = "loginctl lock-session";
        }
        # Turn off display after 150 minutes
        {
          timeout = 9000;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
