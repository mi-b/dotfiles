return {
  "rmagatti/auto-session",
  config = function()
    local opts = {
      auto_restore = false,
    }
    require("auto-session").setup(opts)
  end,
}
