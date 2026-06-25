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
