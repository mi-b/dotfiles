-- Hyprland Lua Configuration
--
-- Modular config loading separate files from configs/ directory.
-- Catppuccin Mocha theme, FiraCode Nerd Font, kitty-first workflow.
-- See: https://wiki.hypr.land/Configuring/Start/

require("configs.programs")
require("configs.environment-variables")
require("configs.monitors")
require("configs.input")
require("configs.appearance")
require("configs.autostart")
require("configs.window-rules")
require("configs.keybindings")
