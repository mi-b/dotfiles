return {
  "rmagatti/auto-session",
  version = "^2.0.0",
  config = function()
    local opts = {
      auto_restore = false,
    }
    require("auto-session").setup(opts)
  end,
}
