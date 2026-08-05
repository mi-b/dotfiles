-- Autostart
--
-- Programs launched once when Hyprland starts.
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("configs.programs")

hl.on("hyprland.start", function()
    -- Polkit authentication agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Status bar
    hl.exec_cmd("waybar")

    -- Notification daemon
    hl.exec_cmd("dunst")

    -- Wallpaper
    hl.exec_cmd("hyprpaper")

    -- Idle timer and screen lock
    hl.exec_cmd("hypridle")

    -- Network manager applet
    hl.exec_cmd("nm-applet")
end)
