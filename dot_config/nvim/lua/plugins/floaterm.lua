return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_width = 0.95
    vim.g.floaterm_height = 0.95
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

    vim.keymap.set("n", "<leader>tt", ":FloatermToggle<CR>", { desc = "Toggle terminal" })
    vim.keymap.set("t", "<leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", { desc = "Toggle terminal" })
    vim.keymap.set("n", "<leader>tl", ":FloatermNew lazygit<CR>", { desc = "Open lazygit" })
    vim.keymap.set("n", "<leader>tn", ":FloatermNew<CR>", { desc = "New terminal" })
  end,
}
