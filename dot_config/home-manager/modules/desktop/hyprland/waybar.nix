# Waybar — Catppuccin Mocha status bar for Hyprland
{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Catppuccin Mocha palette (CSS @define-color values)
  colorsCss = ''
    @define-color background #1e1e2e;
    @define-color mantle     #181825;
    @define-color surface0   #313244;
    @define-color surface1   #45475a;
    @define-color overlay0   #6c7086;
    @define-color text       #cdd6f4;
    @define-color subtext0   #a6adc8;
    @define-color blue       #89b4fa;
    @define-color lavender   #b4befe;
    @define-color red        #f38ba8;
    @define-color yellow     #f9e2af;
    @define-color green      #a6e3a1;
    @define-color peach      #fab387;
    @define-color mauve      #cba6f7;
  '';
in
{
  programs.waybar = lib.mkIf (config.host.wm == "hyprland") {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 4;

        modules-left = [ "hyprland/workspaces" "cpu" "memory" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
        };

        cpu = {
          format = "  {usage}%";
          interval = 5;
          tooltip = true;
        };

        memory = {
          format = "  {}%";
          interval = 10;
          tooltip-format = "{used:0.1f} GiB / {total:0.1f} GiB";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁  muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "${lib.getExe pkgs.pavucontrol}";
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  {ipaddr}";
          format-disconnected = "󰖪  disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          states = {
            warning = 20;
            critical = 10;
          };
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };

    style = ''
      ${colorsCss}

      * {
        font-family:
          FiraCode Nerd Font,
          Noto Sans,
          sans-serif;
        font-size: 13px;
        font-weight: bold;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.85);
        color: @text;
      }

      tooltip {
        background-color: @background;
        border: 2px solid @lavender;
        border-radius: 8px;
      }

      tooltip label {
        color: @text;
      }

      #workspaces,
      #clock,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #battery,
      #tray {
        background-color: @surface0;
        border-radius: 16px;
        padding: 0 10px;
        margin: 4px 3px;
        color: @text;
      }

      #workspaces button {
        padding: 0 5px;
        margin: 2px;
        color: @subtext0;
      }

      #workspaces button:hover,
      #workspaces button.active {
        background-color: @surface1;
        color: @text;
        border-radius: 16px;
      }

      #workspaces button.urgent {
        background-color: @red;
        color: @background;
      }

      #battery.warning {
        color: @yellow;
      }

      #battery.critical {
        color: @red;
      }
    '';
  };
}
