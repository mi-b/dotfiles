-- NOTE: Treesitter crashes with Windows for pretty much all plugins! Maybe it is an issue with the compiler: https://github.com/nvim-treesitter/nvim-treesitter/issues/5264

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {},
      auto_install = not require("utils").is_windows(),
      highlight = {
        enable = true,
    },
      indent = { enable = true },
    })
  end,
}
