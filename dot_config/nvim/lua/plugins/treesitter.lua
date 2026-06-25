return {
  "nvim-treesitter/nvim-treesitter",
  commit = "4916d6",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
      ensure_installed = { "lua", "python", "c", "cpp", "bash", "toml", "markdown", "cmake"
      },
      auto_install = true,
      indent = {
        enable = true,
      }
    })
  end,
}
