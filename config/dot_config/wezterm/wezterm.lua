-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window({})
    window:gui_window():maximize()
end)

-- This is where you actually apply your config choices
config.color_scheme = "Cobalt2"
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = "Bold" },
})
config.font_size = 12
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.debug_key_events = false
config.disable_default_key_bindings = true

config.leader = { key = "n", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    -- Copy
    { key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
    { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },

    -- Paste
    { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
    { key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },

    -- Leader stuff
    { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
    { key = "n", mods = "LEADER", action = act.SpawnWindow },
}

-- and finally, return the configuration to wezterm
return config