-- undotree: Visualise and navigate the undo history tree
-- https://github.com/mbbill/undotree
-- Keys: <leader>u = toggle undo tree
return {
    "mbbill/undotree",
    config = function()
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undo history tree" })
    end,
}
