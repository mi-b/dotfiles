return {
  "smoka7/hop.nvim",
  version = "^2.0.0",
  lazy = false,
  config = function()
    local opts = {
      keys = "etovxqpdygfblzhckisuran",
    }
    require("hop").setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>jk", ":HopWord<CR>", { desc = "Jump to any word on screen" })
    vim.keymap.set({ "n", "v" }, "<leader>jh", ":HopLine<CR>", { desc = "Jump to any line on screen" })
  end,
}
