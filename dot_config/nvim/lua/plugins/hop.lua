return {
  "smoka7/hop.nvim",
  version = "*",
  lazy = false,
  config = function()
    local opts = {
      keys = "etovxqpdygfblzhckisuran",
    }
    require("hop").setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>jk", ":HopWord<CR>", { desc = "Hop Word" })
    vim.keymap.set({ "n", "v" }, "<leader>jh", ":HopLine<CR>", { desc = "Hop Line" })
  end,
}
