-- Appearance — Catppuccin Mocha
--
-- Borders, gaps, decorations, animations, and layouts.
-- See https://wiki.hypr.land/Configuring/Variables/
--
-- Catppuccin Mocha palette reference:
--   Base:     #1e1e2e    Mantle:   #181825    Crust:    #11111b
--   Surface0: #313244    Surface1: #45475a    Surface2: #585b70
--   Overlay0: #6c7086    Overlay1: #7f849c    Overlay2: #9399b2
--   Subtext0: #a6adc8    Subtext1: #bac2de    Text:     #cdd6f4
--   Lavender: #b4befe    Blue:     #89b4fa    Sapphire: #74c7ec
--   Sky:      #89dceb    Teal:     #94e2d5    Green:    #a6e3a1
--   Yellow:   #f9e2af    Peach:    #fab387    Maroon:   #eba0ac
--   Red:      #f38ba8    Mauve:    #cba6f7    Pink:     #f5c2e7
--   Flamingo: #f2cdcd    Rosewater:#f5e0dc

-- --- General ---
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 5,
        border_size = 2,
        ["col.active_border"] = "rgba(b4befeff)",
        ["col.inactive_border"] = "rgba(6c7086aa)",
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle"
    }
})

-- --- Decoration ---
hl.config({
    decoration = {
        rounding = 8,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 6,
            render_power = 3,
            color = "rgba(1e1e2eee)"
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 2,
            vibrancy = 0.17
        }
    }
})

-- --- Animations ---
hl.config({
    animations = {
        enabled = true
    }
})

-- Curves
hl.curve("easeOutQuint", { type = "bezier", points = {{0.23, 1}, {0.32, 1}} })
hl.curve("almostLinear", { type = "bezier", points = {{0.5, 0.5}, {0.75, 1}} })
hl.curve("quick",        { type = "bezier", points = {{0.15, 0}, {0.1, 1}} })

-- Animations — kept simple and quick
hl.animation({ leaf = "global",       enabled = true, speed = 8,    bezier = "default" })
hl.animation({ leaf = "border",       enabled = true, speed = 5,    bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",      enabled = true, speed = 4.5,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",    enabled = true, speed = 4,    bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",   enabled = true, speed = 1.5,  bezier = "almostLinear", style = "popin 80%" })
hl.animation({ leaf = "fade",         enabled = true, speed = 3,    bezier = "quick" })
hl.animation({ leaf = "workspaces",   enabled = true, speed = 2,    bezier = "almostLinear", style = "fade" })

-- --- Layouts ---
hl.config({
    dwindle = {
        preserve_split = true
    }
})

hl.config({
    master = {
        new_status = "master"
    }
})

-- --- Misc ---
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true
    }
})
