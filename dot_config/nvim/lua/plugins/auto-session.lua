-- auto-session: Automatically save and restore editor sessions per directory
-- https://github.com/rmagatti/auto-session
return {
  "rmagatti/auto-session",
  version = "^2.0.0",
  config = function()
    local opts = {
      auto_restore = true,
      auto_save = true,
    }
    require("auto-session").setup(opts)
  end,
}
