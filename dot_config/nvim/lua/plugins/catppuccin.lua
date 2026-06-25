return {
  "catppuccin/nvim",
  name = "catppuccin",
  version = "^2.0.0",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
