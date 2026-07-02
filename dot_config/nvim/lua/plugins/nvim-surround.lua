-- nvim-surround: Add, change, and delete surrounding pairs (brackets, quotes, tags)
-- https://github.com/kylechui/nvim-surround
-- Keys: ys{motion}{char} = add surround | ds{char}       = delete surround
--        cs{old}{new}     = change surround
return {
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end,
}
