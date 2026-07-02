-- Git integration: fugitive (commands) and gitsigns (inline blame, hunk preview)
-- https://github.com/tpope/vim-fugitive
-- https://github.com/lewis6991/gitsigns.nvim
-- Keys: <leader>gp = preview git hunk | <leader>gt = toggle line blame
return {
  { "tpope/vim-fugitive", version = "^3.0.0" },
  {
    "lewis6991/gitsigns.nvim",
    version = "^2.0.0",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk inline" })
      vim.keymap.set(
        "n",
        "<leader>gt",
        ":Gitsigns toggle_current_line_blame<CR>",
        { desc = "Toggle git blame on current line" }
      )
    end,
  },
}
