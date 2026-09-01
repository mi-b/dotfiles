# Polybar — Catppuccin Mocha
#
# Status bar for i3, matching the waybar layout:
#   left:   workspaces | cpu | memory
#   centre: clock
#   right:  pulseaudio | network | battery | tray
{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Catppuccin Mocha palette
  colors = {
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
    surface0 = "#313244";
    surface1 = "#45475a";
    surface2 = "#585b70";
    overlay0 = "#6c7086";
    overlay1 = "#7f849c";
    overlay2 = "#9399b2";
    subtext0 = "#a6adc8";
    subtext1 = "#bac2de";
    text = "#cdd6f4";
    lavender = "#b4befe";
    blue = "#89b4fa";
    sapphire = "#74c7ec";
    sky = "#89dceb";
    teal = "#94e2d5";
    green = "#a6e3a1";
    yellow = "#f9e2af";
    peach = "#fab387";
    maroon = "#eba0ac";
    red = "#f38ba8";
    mauve = "#cba6f7";
    pink = "#f5c2e7";
    flamingo = "#f2cdcd";
    rosewater = "#f5e0dc";
  };
in
{
  services.polybar = lib.mkIf (config.host.wm == "i3") {
    enable = true;
    package = pkgs.polybar.override { i3Support = true; };

    settings = {
      "bar/main" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = "28pt";
        offset-x = 0;
        offset-y = 0;
        fixed-center = true;

        background = colors.base;
        foreground = colors.text;

        line-size = "2pt";

        padding-left = 1;
        padding-right = 1;
        module-margin = 1;

        font-0 = "FiraCode Nerd Font:size=10;3";
        font-1 = "FiraCode Nerd Font:size=12;3";

        modules-left = "i3 cpu memory";
        modules-center = "date";
        modules-right = "pulseaudio network network-wired battery tray";

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        pseudo-transparency = true;
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        show-urgent = true;
        strip-wsnumbers = false;
        index-sort = true;

        label-focused = "%index%";
        label-focused-foreground = colors.base;
        label-focused-background = colors.lavender;
        label-focused-underline = colors.lavender;
        label-focused-padding = 2;

        label-unfocused = "%index%";
        label-unfocused-foreground = colors.text;
        label-unfocused-background = colors.surface0;
        label-unfocused-padding = 2;

        label-visible = "%index%";
        label-visible-foreground = colors.text;
        label-visible-background = colors.surface1;
        label-visible-padding = 2;

        label-urgent = "%index%";
        label-urgent-foreground = colors.base;
        label-urgent-background = colors.red;
        label-urgent-padding = 2;
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 5;
        format-prefix = " ";
        format-prefix-foreground = colors.blue;
        label = "%percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 10;
        format-prefix = " ";
        format-prefix-foreground = colors.blue;
        label = "%percentage_used:2%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 60;
        date = "%a %d %b %H:%M";
        label = "%date%";
        label-foreground = colors.text;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        use-ui-max = false;

        format-volume-prefix = "󰕾 ";
        format-volume-prefix-foreground = colors.blue;
        format-volume = "<label-volume>";
        label-volume = "%percentage%%";

        format-muted-prefix = "󰖁 ";
        format-muted-prefix-foreground = colors.overlay0;
        label-muted = "muted";
        label-muted-foreground = colors.overlay0;

        click-right = "pavucontrol";
      };

      "module/network" = {
        type = "internal/network";
        interface-type = "wireless";
        interval = 5;

        format-connected-prefix = "󰤨 ";
        format-connected-prefix-foreground = colors.blue;
        label-connected = "%essid%";

        format-disconnected-prefix = "󰤭 ";
        format-disconnected-prefix-foreground = colors.overlay0;
        label-disconnected = "disconnected";
        label-disconnected-foreground = colors.overlay0;
      };

      "module/network-wired" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 5;

        format-connected-prefix = "󰈀 ";
        format-connected-prefix-foreground = colors.blue;
        label-connected = "%local_ip%";

        format-disconnected = "";
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 99;
        low-at = 10;
        battery = "BAT0";
        adapter = "ADP1";

        format-charging-prefix = "󰂄 ";
        format-charging-prefix-foreground = colors.green;
        label-charging = "%percentage%%";

        format-discharging-prefix = "󰁿 ";
        format-discharging-prefix-foreground = colors.blue;
        label-discharging = "%percentage%%";

        format-full-prefix = "󱟢 ";
        format-full-prefix-foreground = colors.green;
        label-full = "%percentage%%";

        format-low-prefix = "󰂃 ";
        format-low-prefix-foreground = colors.red;
        label-low = "%percentage%%";
      };

      "module/tray" = {
        type = "internal/tray";
        tray-spacing = "8pt";
        tray-size = "16px";
      };

      settings = {
        screenchange-reload = true;
      };
    };

    script = ''
      ${pkgs.procps}/bin/pkill -x polybar || true
      ${pkgs.coreutils}/bin/sleep 0.5
      for m in $(${lib.getExe config.services.polybar.package} --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m ${lib.getExe config.services.polybar.package} main &
      done
    '';
  };

  systemd.user.services.polybar.Service = lib.mkIf (config.host.wm == "i3") {
    Type = lib.mkForce "oneshot";
    RemainAfterExit = true;
  };
}
