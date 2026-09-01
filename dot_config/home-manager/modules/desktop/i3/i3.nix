# i3 window manager — Catppuccin Mocha
#
# Full desktop setup with polybar, rofi, picom, and dunst.
# Vim-style navigation (h/j/k/l), Swiss German keyboard layout.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  mod = "Mod4";

  # Catppuccin Mocha palette
  base = "#1e1e2e";
  surface0 = "#313244";
  surface1 = "#45475a";
  text = "#cdd6f4";
  lavender = "#b4befe";
  red = "#f38ba8";

  wallpaper = "${config.home.homeDirectory}/.config/wallpaper/background.png";
  refreshDesktop = pkgs.writeShellScript "refresh-desktop" ''
    ${lib.getExe pkgs.feh} --bg-fill ${wallpaper}
    ${pkgs.systemd}/bin/systemctl --user restart polybar.service
  '';
in
{
  config = lib.mkIf (config.host.wm == "i3") {
    home.packages = with pkgs; [
      i3status
      feh
      xautolock
      maim
    ];

    xsession = {
      enable = true;
      profileExtra = ''. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"'';

      windowManager.i3 = {
        enable = true;

        config = {
          modifier = mod;

          fonts = {
            names = [ "FiraCode Nerd Font" ];
            size = 10.0;
          };

          gaps = {
            inner = 0;
            outer = 0;
          };

          window = {
            border = 2;
            titlebar = false;
          };

          floating = {
            border = 2;
            titlebar = false;
            modifier = mod;
          };

          colors = {
            focused = {
              border = lavender;
              background = lavender;
              text = base;
              indicator = lavender;
              childBorder = lavender;
            };
            focusedInactive = {
              border = base;
              background = base;
              text = text;
              indicator = base;
              childBorder = base;
            };
            unfocused = {
              border = base;
              background = base;
              text = text;
              indicator = base;
              childBorder = base;
            };
            urgent = {
              border = red;
              background = red;
              text = base;
              indicator = red;
              childBorder = red;
            };
            placeholder = {
              border = base;
              background = base;
              text = text;
              indicator = base;
              childBorder = base;
            };
            background = base;
          };

          keybindings = {
            # Applications
            "${mod}+Return" = "exec --no-startup-id ${lib.getExe pkgs.kitty}";
            "--release ${mod}+space" =
              "exec --no-startup-id ${lib.getExe config.programs.rofi.package} -show drun";

            # Window management
            "${mod}+q" = "kill";
            "${mod}+f" = "fullscreen toggle";
            "${mod}+Shift+f" = "floating toggle";
            "${mod}+b" = "split horizontal";
            "${mod}+v" = "split vertical";
            "${mod}+Shift+r" = "reload; exec --no-startup-id ${refreshDesktop}";
            "${mod}+Shift+e" =
              ''exec --no-startup-id "echo -e 'Yes\nNo' | ${lib.getExe config.programs.rofi.package} -dmenu -p 'Exit i3?' -theme-str 'listview { lines: 2; }' | grep -qx Yes && i3-msg exit"'';

            # Lock screen
            "${mod}+Escape" = "exec --no-startup-id ${pkgs.i3lock}/bin/i3lock -c 1e1e2e";

            # Toggle between tiling and floating focus
            "${mod}+d" = "focus mode_toggle";

            # Focus — vim keys
            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            # Focus — arrow keys
            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";

            # Move windows — vim keys
            "${mod}+Shift+h" = "move left";
            "${mod}+Shift+j" = "move down";
            "${mod}+Shift+k" = "move up";
            "${mod}+Shift+l" = "move right";

            # Move windows — arrow keys
            "${mod}+Shift+Left" = "move left";
            "${mod}+Shift+Down" = "move down";
            "${mod}+Shift+Up" = "move up";
            "${mod}+Shift+Right" = "move right";

            # Move workspace to output — vim keys
            "${mod}+Ctrl+h" = "move workspace to output left";
            "${mod}+Ctrl+l" = "move workspace to output right";

            # Move workspace to output — arrow keys
            "${mod}+Ctrl+Left" = "move workspace to output left";
            "${mod}+Ctrl+Right" = "move workspace to output right";

            # Resize mode
            "${mod}+r" = ''mode "resize"'';

            # Workspaces
            "${mod}+1" = ''workspace number "1"'';
            "${mod}+2" = ''workspace number "2"'';
            "${mod}+3" = ''workspace number "3"'';
            "${mod}+4" = ''workspace number "4"'';
            "${mod}+5" = ''workspace number "5"'';
            "${mod}+6" = ''workspace number "6"'';
            "${mod}+7" = ''workspace number "7"'';
            "${mod}+8" = ''workspace number "8"'';
            "${mod}+9" = ''workspace number "9"'';
            "${mod}+0" = ''workspace number "10"'';

            "${mod}+Shift+1" = ''move container to workspace number "1"; workspace number "1"'';
            "${mod}+Shift+2" = ''move container to workspace number "2"; workspace number "2"'';
            "${mod}+Shift+3" = ''move container to workspace number "3"; workspace number "3"'';
            "${mod}+Shift+4" = ''move container to workspace number "4"; workspace number "4"'';
            "${mod}+Shift+5" = ''move container to workspace number "5"; workspace number "5"'';
            "${mod}+Shift+6" = ''move container to workspace number "6"; workspace number "6"'';
            "${mod}+Shift+7" = ''move container to workspace number "7"; workspace number "7"'';
            "${mod}+Shift+8" = ''move container to workspace number "8"; workspace number "8"'';
            "${mod}+Shift+9" = ''move container to workspace number "9"; workspace number "9"'';
            "${mod}+Shift+0" = ''move container to workspace number "10"; workspace number "10"'';

            # Scratchpad
            "${mod}+section" = "scratchpad show";
            "${mod}+Shift+section" = "move scratchpad";

            # Volume
            "XF86AudioRaiseVolume" =
              "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume" =
              "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute" =
              "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute" =
              "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

            # Brightness
            "XF86MonBrightnessUp" =
              "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+";
            "XF86MonBrightnessDown" =
              "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-";

            # Playback
            "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
            "XF86AudioPause" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
            "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
            "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";

            # Screenshots — flameshot
            "Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
            "${mod}+Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot full --clipboard";
            "${mod}+Shift+Print" =
              "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot full --path ~/Pictures/Screenshots";
          };

          modes = {
            resize = {
              "h" = "resize shrink width 10 px or 10 ppt";
              "j" = "resize grow height 10 px or 10 ppt";
              "k" = "resize shrink height 10 px or 10 ppt";
              "l" = "resize grow width 10 px or 10 ppt";

              "Left" = "resize shrink width 10 px or 10 ppt";
              "Down" = "resize grow height 10 px or 10 ppt";
              "Up" = "resize shrink height 10 px or 10 ppt";
              "Right" = "resize grow width 10 px or 10 ppt";

              "Return" = ''mode "default"'';
              "Escape" = ''mode "default"'';
              "${mod}+r" = ''mode "default"'';
            };
          };

          window.commands = [
            {
              command = "border pixel 2";
              criteria = {
                class = ".*";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^nm-applet$";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^nm-connection-editor$";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^Nm-connection-editor$";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^blueman-manager$";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^Blueman-manager$";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^pavucontrol$";
              };
            }
            {
              command = "floating enable";
              criteria = {
                class = "^Pavucontrol$";
              };
            }
            {
              command = "floating enable, border none";
              criteria = {
                class = "^flameshot$";
              };
            }
          ];

          bars = [ ]; # Using polybar, not i3bar

          startup = [
            # Compositor
            {
              command = "${pkgs.systemd}/bin/systemctl --user restart picom.service";
              always = true;
              notification = false;
            }
            # Notification daemon
            {
              command = "${lib.getExe pkgs.dunst}";
              notification = false;
            }
            # Wallpaper and monitor-aware status bars
            {
              command = "${refreshDesktop}";
              notification = false;
            }
            # Idle timer and screen lock (disabled for xrdp sessions)
            {
              command = "sh -c 'pgrep -a Xorg | grep -q xrdp || ${lib.getExe pkgs.xautolock} -time 10 -locker \"${pkgs.i3lock}/bin/i3lock -c 1e1e2e\"'";
              notification = false;
            }
            # Network manager applet
            {
              command = "nm-applet";
              notification = false;
            }
            # Polkit authentication agent
            {
              command = "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1";
              notification = false;
            }
            # Keyboard layout — Swiss German, Caps Lock as Ctrl
            {
              command = "${pkgs.setxkbmap}/bin/setxkbmap -option '' -layout ch -variant de -option ctrl:nocaps";
              notification = false;
            }
          ];
        };

        extraConfig = ''
          # RDP fallback — Win+L is intercepted by Windows (keycode 47 = ö)
          bindcode ${mod}+47 focus right
          bindcode ${mod}+Shift+47 move right

        '';
      };
    };
  };
}
