# Hyprland window manager — Catppuccin Mocha
#
# Full Wayland desktop: waybar, wofi, dunst, swaybg, hypridle, hyprlock.
# Vim-style navigation, Swiss German keyboard layout.
#
# Uses configType = "lua" — HM generates hyprland.lua from the settings
# attrset.  The PPA Hyprland binary auto-detects Lua from the file extension.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  mod = "SUPER";

  wallpaper = "${config.home.homeDirectory}/.config/wallpaper/background.png";

  # Helper: create a bind attrset from key combo and dispatcher expression.
  mkBind = keys: dispatcher: {
    _args = [
      (lib.generators.mkLuaInline keys)
      (lib.generators.mkLuaInline dispatcher)
    ];
  };

  # Helper: bind with options (locked, repeating, mouse).
  mkBindOpts = keys: dispatcher: opts: {
    _args = [
      (lib.generators.mkLuaInline keys)
      (lib.generators.mkLuaInline dispatcher)
      opts
    ];
  };

  terminal = lib.getExe config.programs.kitty.package;
  menuCmd = "pkill wofi || wofi --show drun";

  # Workspace keybindings (1–10)
  workspaceBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        key = toString (lib.mod (i + 1) 10);
        ws = toString (i + 1);
      in
      [
        (mkBind ''"${mod} + ${key}"'' "hl.dsp.focus({ workspace = ${ws} })")
        (mkBind ''"${mod} + SHIFT + ${key}"'' "hl.dsp.window.move({ workspace = ${ws}, follow = true })")
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
      configType = "lua";
      package = null; # PPA provides the Hyprland binary
      portalPackage = null; # PPA provides xdg-desktop-portal-hyprland

      settings = {
        # --- Configuration ---
        config = {
          general = {
            gaps_in = 3;
            gaps_out = 5;
            border_size = 2;
            "col.active_border" = "rgba(b4befeff)";
            "col.inactive_border" = "rgba(1e1e2eff)";
            resize_on_border = true;
            layout = "dwindle";
          };

          input = {
            kb_layout = "ch";
            kb_variant = "de";
            kb_options = "ctrl:nocaps";
            numlock_by_default = true;

            touchpad = {
              natural_scroll = true;
            };
          };

          decoration = {
            rounding = 8;
            inactive_opacity = 0.85;

            shadow = {
              range = 6;
              render_power = 3;
              color = "rgba(1e1e2eee)";
            };

            blur = {
              size = 4;
              passes = 2;
              vibrancy = 0.17;
            };
          };

          dwindle = {
            preserve_split = true;
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
        };

        # --- Environment variables ---
        env = [
          # Prepend Nix profile paths so Nix-managed programs are available
          # to all child processes (wofi, waybar, etc.).  Display managers
          # like GDM do not source ~/.profile, so the Nix PATH is missing.
          {
            _args = [
              "PATH"
              (lib.generators.mkLuaInline ''os.getenv("HOME") .. "/.nix-profile/bin:/nix/var/nix/profiles/default/bin:" .. (os.getenv("PATH") or "/usr/local/bin:/usr/bin:/bin")'')
            ];
          }
          {
            _args = [
              "XDG_CURRENT_DESKTOP"
              "Hyprland"
            ];
          }
          {
            _args = [
              "XDG_SESSION_TYPE"
              "wayland"
            ];
          }
          {
            _args = [
              "XDG_SESSION_DESKTOP"
              "Hyprland"
            ];
          }
          {
            _args = [
              "GDK_BACKEND"
              "wayland,x11"
            ];
          }
          {
            _args = [
              "QT_QPA_PLATFORM"
              "wayland;xcb"
            ];
          }
          {
            _args = [
              "ELECTRON_OZONE_PLATFORM_HINT"
              "wayland"
            ];
          }
          {
            _args = [
              "XCURSOR_SIZE"
              "24"
            ];
          }
          {
            _args = [
              "HYPRCURSOR_SIZE"
              "24"
            ];
          }
        ];

        # --- Monitors ---
        monitor = {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        };

        # --- Gesture ---
        gesture = {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        };

        # --- Curves ---
        curve = [
          {
            _args = [
              "easeOutQuint"
              {
                type = "bezier";
                points = [
                  [
                    0.23
                    1
                  ]
                  [
                    0.32
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "almostLinear"
              {
                type = "bezier";
                points = [
                  [
                    0.5
                    0.5
                  ]
                  [
                    0.75
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "quick"
              {
                type = "bezier";
                points = [
                  [
                    0.15
                    0
                  ]
                  [
                    0.1
                    1
                  ]
                ];
              }
            ];
          }
        ];

        # --- Animations ---
        animation = [
          {
            leaf = "global";
            enabled = true;
            speed = 8;
            bezier = "default";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 5;
            bezier = "easeOutQuint";
          }
          {
            leaf = "windows";
            enabled = true;
            speed = 4.5;
            bezier = "easeOutQuint";
          }
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 4;
            bezier = "easeOutQuint";
            style = "popin 80%";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 1.5;
            bezier = "almostLinear";
            style = "popin 80%";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 3;
            bezier = "quick";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 2;
            bezier = "almostLinear";
            style = "fade";
          }
        ];

        # --- Autostart ---
        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                            -- Propagate session environment to D-Bus and systemd
                            hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE PATH XDG_DATA_DIRS")
                            hl.exec_cmd("systemctl --user import-environment PATH XDG_DATA_DIRS")
                            -- Polkit
                            hl.exec_cmd("systemctl --user start hyprpolkitagent")
                            -- Status bar
                            hl.exec_cmd("${lib.getExe config.programs.waybar.package}")
                            -- Notification daemon
                            hl.exec_cmd("${lib.getExe pkgs.dunst}")
                            -- Wallpaper (swaybg — hyprpaper from PPA has broken config parsing)
                            hl.exec_cmd("${lib.getExe pkgs.swaybg} -i ${wallpaper} -m fill")
                            -- Idle timer and screen lock
                            hl.exec_cmd("${lib.getExe pkgs.hypridle}")
                            -- Network manager applet
                            hl.exec_cmd("nm-applet")
                          end'')
          ];
        };

        # --- Window rules ---
        window_rule = [
          # Suppress maximize events from all applications
          {
            name = "suppress-maximize";
            match = {
              class = ".*";
            };
            suppress_event = "maximize";
          }
          # Float settings applications
          {
            match = {
              class = "^(nm-applet|nm-connection-editor|bluetuith)$";
            };
            float = true;
          }
          {
            match = {
              class = "^(pavucontrol|org.pulseaudio.pavucontrol)$";
            };
            float = true;
          }
        ];

        # --- Keybindings ---
        bind = [
          # Applications
          (mkBind ''"${mod} + Return"'' ''hl.dsp.exec_cmd("${terminal}")'')
          (mkBind ''"${mod} + Space"'' ''hl.dsp.exec_cmd("${menuCmd}")'')

          # Window management
          (mkBind ''"${mod} + Q"'' "hl.dsp.window.close()")
          (mkBind ''"${mod} + SHIFT + E"'' "hl.dsp.exit()")
          (mkBind ''"${mod} + F"'' "hl.dsp.window.fullscreen()")
          (mkBind ''"${mod} + V"'' ''hl.dsp.window.float({ action = "toggle" })'')
          (mkBind ''"${mod} + P"'' "hl.dsp.window.pseudo()")
          (mkBind ''"${mod} + S"'' ''hl.dsp.layout("togglesplit")'')

          # Bluetooth manager (TUI)
          (mkBind ''"${mod} + B"'' ''hl.dsp.exec_cmd("${lib.getExe config.programs.kitty.package} --class bluetuith ${lib.getExe pkgs.bluetuith}")'')

          # Lock screen
          (mkBind ''"${mod} + Escape"'' ''hl.dsp.exec_cmd("loginctl lock-session")'')

          # Focus — vim keys
          (mkBind ''"${mod} + H"'' ''hl.dsp.focus({ direction = "l" })'')
          (mkBind ''"${mod} + L"'' ''hl.dsp.focus({ direction = "r" })'')
          (mkBind ''"${mod} + K"'' ''hl.dsp.focus({ direction = "u" })'')
          (mkBind ''"${mod} + J"'' ''hl.dsp.focus({ direction = "d" })'')

          # Focus — arrow keys
          (mkBind ''"${mod} + left"'' ''hl.dsp.focus({ direction = "l" })'')
          (mkBind ''"${mod} + right"'' ''hl.dsp.focus({ direction = "r" })'')
          (mkBind ''"${mod} + up"'' ''hl.dsp.focus({ direction = "u" })'')
          (mkBind ''"${mod} + down"'' ''hl.dsp.focus({ direction = "d" })'')

          # Move windows — vim keys
          (mkBind ''"${mod} + SHIFT + H"'' ''hl.dsp.window.move({ direction = "l" })'')
          (mkBind ''"${mod} + SHIFT + L"'' ''hl.dsp.window.move({ direction = "r" })'')
          (mkBind ''"${mod} + SHIFT + K"'' ''hl.dsp.window.move({ direction = "u" })'')
          (mkBind ''"${mod} + SHIFT + J"'' ''hl.dsp.window.move({ direction = "d" })'')

          # Move windows — arrow keys
          (mkBind ''"${mod} + SHIFT + left"'' ''hl.dsp.window.move({ direction = "l" })'')
          (mkBind ''"${mod} + SHIFT + right"'' ''hl.dsp.window.move({ direction = "r" })'')
          (mkBind ''"${mod} + SHIFT + up"'' ''hl.dsp.window.move({ direction = "u" })'')
          (mkBind ''"${mod} + SHIFT + down"'' ''hl.dsp.window.move({ direction = "d" })'')

          # Move workspace to monitor — vim keys
          (mkBind ''"${mod} + CTRL + H"'' ''hl.dsp.workspace.move({ monitor = "l" })'')
          (mkBind ''"${mod} + CTRL + L"'' ''hl.dsp.workspace.move({ monitor = "r" })'')

          # Move workspace to monitor — arrow keys
          (mkBind ''"${mod} + CTRL + left"'' ''hl.dsp.workspace.move({ monitor = "l" })'')
          (mkBind ''"${mod} + CTRL + right"'' ''hl.dsp.workspace.move({ monitor = "r" })'')

          # Special workspace (scratchpad)
          (mkBind ''"${mod} + Tab"'' ''hl.dsp.workspace.toggle_special("scratchpad")'')
          (mkBind ''"${mod} + SHIFT + Tab"'' ''hl.dsp.window.move({ workspace = "special:scratchpad" })'')

          # Scroll through workspaces
          (mkBind ''"${mod} + mouse_down"'' ''hl.dsp.focus({ workspace = "e+1" })'')
          (mkBind ''"${mod} + mouse_up"'' ''hl.dsp.focus({ workspace = "e-1" })'')

          # Mouse bindings
          (mkBindOpts ''"${mod} + mouse:272"'' "hl.dsp.window.drag()" { mouse = true; })
          (mkBindOpts ''"${mod} + mouse:273"'' "hl.dsp.window.resize()" { mouse = true; })

          # Volume (repeat + locked)
          (mkBindOpts ''"XF86AudioRaiseVolume"''
            ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")''
            {
              repeating = true;
              locked = true;
            }
          )
          (mkBindOpts ''"XF86AudioLowerVolume"''
            ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")''
            {
              repeating = true;
              locked = true;
            }
          )

          # Brightness (repeat + locked)
          (mkBindOpts ''"XF86MonBrightnessUp"''
            ''hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+")''
            {
              repeating = true;
              locked = true;
            }
          )
          (mkBindOpts ''"XF86MonBrightnessDown"''
            ''hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-")''
            {
              repeating = true;
              locked = true;
            }
          )

          # Mute (locked)
          (mkBindOpts ''"XF86AudioMute"''
            ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")''
            { locked = true; }
          )
          (mkBindOpts ''"XF86AudioMicMute"''
            ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")''
            { locked = true; }
          )

          # Playback (locked)
          (mkBindOpts ''"XF86AudioPlay"'' ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause")'' {
            locked = true;
          })
          (mkBindOpts ''"XF86AudioPause"'' ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause")'' {
            locked = true;
          })
          (mkBindOpts ''"XF86AudioNext"'' ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl next")'' {
            locked = true;
          })
          (mkBindOpts ''"XF86AudioPrev"'' ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl previous")'' {
            locked = true;
          })
        ]
        ++ workspaceBinds;
      };
    };
  };
}
