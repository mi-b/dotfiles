-- lualine.nvim: Configurable statusline with mode, branch, and diagnostics info
-- https://github.com/nvim-lualine/lualine.nvim
return {
  "nvim-lualine/lualine.nvim",
  commit = "221ce6b",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
      },
    })
  end,
}
