return {
	{
		"nvim-telescope/telescope.nvim",
		commit = "427b576",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files by name" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recently opened files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find text in project (grep)" })
			vim.keymap.set("n", "<leader>lD", builtin.diagnostics, { desc = "List all diagnostics" })
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		version = "^1.0.0",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		commit = "6e51d7d",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
