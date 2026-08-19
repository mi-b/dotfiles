-- Autostart
--
-- Programs launched once when Hyprland starts.
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("configs.programs")

hl.on("hyprland.start", function()
    -- Propagate session environment to D-Bus and systemd so portals,
    -- GTK apps, and app launchers (wofi) can find Nix-installed programs.
    hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE PATH XDG_DATA_DIRS")
    hl.exec_cmd("systemctl --user import-environment PATH XDG_DATA_DIRS")

    -- Polkit authentication agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Status bar
    hl.exec_cmd("waybar")

    -- Notification daemon
    hl.exec_cmd("dunst")

    -- Wallpaper (swaybg — hyprpaper 0.8.4 from PPA has broken config parsing)
    hl.exec_cmd("swaybg -i " .. os.getenv("HOME") .. "/.config/wallpaper/background.png -m fill")

    -- Idle timer and screen lock
    hl.exec_cmd("hypridle")

    -- Network manager applet
    hl.exec_cmd("nm-applet")

end)
