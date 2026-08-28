-- vim-floaterm: Floating terminal overlay
-- https://github.com/voldikss/vim-floaterm
-- Keys: <leader>Tt = toggle terminal | <leader>Tl = open lazygit
--        <leader>Tn = new terminal
return {
    "voldikss/vim-floaterm",
    config = function()
        vim.g.floaterm_width = 0.95
        vim.g.floaterm_height = 0.95
        vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

        vim.keymap.set("n", "<leader>Tt", "<cmd>FloatermToggle<cr>", { desc = "Toggle terminal" })
        vim.keymap.set("t", "<leader>Tt", "<C-\\><C-n><cmd>FloatermToggle<cr>", { desc = "Toggle terminal" })
        vim.keymap.set("n", "<leader>Tl", "<cmd>FloatermNew lazygit<cr>", { desc = "Open lazygit" })
        vim.keymap.set("n", "<leader>Tn", "<cmd>FloatermNew<cr>", { desc = "New terminal" })
    end,
}
