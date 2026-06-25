return {
"mbbill/undotree",
  commit = "6fa6b57",
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
		  vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Undo Tree" })
  end
}
