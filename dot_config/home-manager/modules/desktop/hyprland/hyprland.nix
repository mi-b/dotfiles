# Hyprland window manager — Catppuccin Mocha
#
# Full Wayland desktop: waybar, wofi, dunst, swaybg, hypridle, hyprlock.
# Vim-style navigation, Swiss German keyboard layout.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  mod = "SUPER";

  wallpaper = "${config.home.homeDirectory}/.config/wallpaper/background.png";

  # Safe close: refuse to kill kitty windows containing neovim.
  closeWindow = lib.getExe (
    pkgs.writeShellScriptBin "hypr-close-window" ''
      set -euo pipefail

      active_window=$(hyprctl activewindow -j)
      window_class=$(echo "$active_window" | ${lib.getExe pkgs.jq} -r '.class')
      window_pid=$(echo "$active_window" | ${lib.getExe pkgs.jq} -r '.pid')

      # Only guard kitty windows; everything else closes immediately.
      if [[ "$window_class" != "kitty" ]]; then
          hyprctl dispatch killactive
          exit 0
      fi

      # Check if neovim is anywhere in the process subtree.
      if ${pkgs.psmisc}/bin/pstree -p "$window_pid" 2>/dev/null | grep -qP 'nvim\(\d+\)'; then
          ${lib.getExe pkgs.libnotify} -u critical "Neovim" "This window contains a neovim process. Close neovim first."
          exit 1
      fi

      # No neovim — safe to close.
      hyprctl dispatch killactive
    ''
  );

  # Workspace keybindings (1–10)
  workspaceBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        key = toString (lib.mod (i + 1) 10);
        ws = toString (i + 1);
      in
      [
        "${mod}, ${key}, workspace, ${ws}"
        "${mod} SHIFT, ${key}, movetoworkspace, ${ws}"
      ]
    ) 10
  );
in
{
  config = lib.mkIf (config.host.wm == "hyprland") {
    home.packages = with pkgs; [
      swaybg
      grim
      slurp
      wl-clipboard
      bluetuith
    ];

    # Portal backend configuration — required since xdg-desktop-portal 1.17.
    # Hyprland portal declares which interfaces it supports in its .portal
    # file; anything it doesn't handle falls through to GTK via the wildcard.
    xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
      [preferred]
      default=hyprland;gtk
    '';

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";
      package = null; # PPA provides the Hyprland binary
      portalPackage = null; # PPA provides xdg-desktop-portal-hyprland

      settings = {
        # --- Programs ---
        "$terminal" = lib.getExe config.programs.kitty.package;
        "$menu" = "pkill wofi || ${lib.getExe config.programs.wofi.package} --show drun";

        # --- Environment variables ---
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "GDK_BACKEND,wayland,x11"
          "QT_QPA_PLATFORM,wayland;xcb"
          "ELECTRON_OZONE_PLATFORM_HINT,wayland"
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        # --- Monitors ---
        monitor = ", preferred, auto, 1";

        # --- Input ---
        input = {
          kb_layout = "ch";
          kb_variant = "de";
          kb_model = "";
          kb_options = "ctrl:nocaps";
          kb_rules = "";
          numlock_by_default = true;
          follow_mouse = 1;
          sensitivity = 0;

          touchpad = {
            natural_scroll = true;
          };
        };

        # NOTE: gestures:workspace_swipe was removed in Hyprland 0.55.
        # Three-finger workspace swipe requires the Lua config format
        # (hl.gesture()), which is not yet supported by HM's hyprlang output.
        # TODO: migrate to configType = "lua" before Hyprland 0.57 drops
        # .conf support entirely.

        # --- Appearance ---
        general = {
          gaps_in = 3;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "rgba(b4befeff)";
          "col.inactive_border" = "rgba(6c7086aa)";
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 8;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 0.85;

          shadow = {
            enabled = true;
            range = 6;
            render_power = 3;
            color = "rgba(1e1e2eee)";
          };

          blur = {
            enabled = true;
            size = 4;
            passes = 2;
            vibrancy = 0.17;
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "easeOutQuint, 0.23, 1, 0.32, 1"
            "almostLinear, 0.5, 0.5, 0.75, 1"
            "quick, 0.15, 0, 0.1, 1"
          ];

          animation = [
            "global, 1, 8, default"
            "border, 1, 5, easeOutQuint"
            "windows, 1, 4.5, easeOutQuint"
            "windowsIn, 1, 4, easeOutQuint, popin 80%"
            "windowsOut, 1, 1.5, almostLinear, popin 80%"
            "fade, 1, 3, quick"
            "workspaces, 1, 2, almostLinear, fade"
          ];
        };

        dwindle = {
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        # --- Autostart ---
        exec-once = [
          # Propagate session environment to D-Bus and systemd
          "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE PATH XDG_DATA_DIRS"
          "systemctl --user import-environment PATH XDG_DATA_DIRS"
          # Polkit
          "systemctl --user start hyprpolkitagent"
          # Status bar
          "${lib.getExe config.programs.waybar.package}"
          # Notification daemon
          "${lib.getExe pkgs.dunst}"
          # Wallpaper (swaybg — hyprpaper from PPA has broken config parsing)
          "${lib.getExe pkgs.swaybg} -i ${wallpaper} -m fill"
          # Idle timer and screen lock
          "${lib.getExe pkgs.hypridle}"
          # Network manager applet
          "nm-applet"
        ];

        # --- Window rules ---
        windowrule = [
          # Suppress maximize events from all applications
          "suppress_event maximize, match:class .*"
          # Float settings applications
          "float on, match:class ^(nm-applet|nm-connection-editor|bluetuith)$"
          "float on, match:class ^(pavucontrol|org.pulseaudio.pavucontrol)$"
        ];

        # --- Keybindings ---
        bind =
          [
            # Applications
            "${mod}, Return, exec, $terminal"
            "${mod}, Space, exec, $menu"

            # Window management
            "${mod}, Q, exec, ${closeWindow}"
            "${mod} SHIFT, E, exit,"
            "${mod}, F, fullscreen,"
            "${mod}, V, togglefloating,"
            "${mod}, P, pseudo,"
            "${mod}, S, layoutmsg, togglesplit"

            # Bluetooth manager (TUI)
            "${mod}, B, exec, ${lib.getExe config.programs.kitty.package} --class bluetuith ${lib.getExe pkgs.bluetuith}"

            # Lock screen
            "${mod}, Escape, exec, loginctl lock-session"

            # Focus — vim keys
            "${mod}, H, movefocus, l"
            "${mod}, L, movefocus, r"
            "${mod}, K, movefocus, u"
            "${mod}, J, movefocus, d"

            # Focus — arrow keys
            "${mod}, left, movefocus, l"
            "${mod}, right, movefocus, r"
            "${mod}, up, movefocus, u"
            "${mod}, down, movefocus, d"

            # Move windows — vim keys
            "${mod} SHIFT, H, movewindow, l"
            "${mod} SHIFT, L, movewindow, r"
            "${mod} SHIFT, K, movewindow, u"
            "${mod} SHIFT, J, movewindow, d"

            # Move windows — arrow keys
            "${mod} SHIFT, left, movewindow, l"
            "${mod} SHIFT, right, movewindow, r"
            "${mod} SHIFT, up, movewindow, u"
            "${mod} SHIFT, down, movewindow, d"

            # Move workspace to monitor — vim keys
            "${mod} CTRL, H, movecurrentworkspacetomonitor, l"
            "${mod} CTRL, L, movecurrentworkspacetomonitor, r"

            # Move workspace to monitor — arrow keys
            "${mod} CTRL, left, movecurrentworkspacetomonitor, l"
            "${mod} CTRL, right, movecurrentworkspacetomonitor, r"

            # Special workspace (scratchpad)
            "${mod}, Tab, togglespecialworkspace, scratchpad"
            "${mod} SHIFT, Tab, movetoworkspace, special:scratchpad"

            # Scroll through workspaces
            "${mod}, mouse_down, workspace, e+1"
            "${mod}, mouse_up, workspace, e-1"
          ]
          ++ workspaceBinds;

        # Mouse bindings
        bindm = [
          "${mod}, mouse:272, movewindow"
          "${mod}, mouse:273, resizewindow"
        ];

        # Repeat when held, also work when locked
        bindel = [
          # Volume
          ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          # Brightness
          ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+"
          ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-"
        ];

        # Work when locked
        bindl = [
          ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ];
      };
    };
  };
}
