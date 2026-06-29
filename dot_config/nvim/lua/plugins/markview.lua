-- if require("utils").skip_if_windows("markview") then
-- 	return {}
-- end

return {
	"OXY2DEV/markview.nvim",
	ft = { "markdown", "typst", "latex", "html", "yaml" },

	config = function()
		require("markview").setup({
			preview = { enable = false },
		})

		vim.api.nvim_set_keymap("n", "<leader>MM", "<CMD>Markview toggle<CR>", { desc = "markview: Toggle preview (buffer)" })
		vim.api.nvim_set_keymap("n", "<leader>MS", "<CMD>Markview splitToggle<CR>", { desc = "markview: Toggle splitview" })
	end,
}
