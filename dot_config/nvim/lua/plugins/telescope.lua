return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.diagnostic.config({
				virtual_text = true, -- Enable virtual text
				signs = true, -- Show signs in the sign column
				underline = true, -- Underline problematic code
				update_in_insert = false, -- Don't update diagnostics while typing
				severity_sort = false, -- Sort diagnostics by severity
			})
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>ld", ":Telescope diagnostics<CR>", { desc = "Telescope Diagnostics" })
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
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
