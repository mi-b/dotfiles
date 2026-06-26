-- neo-tree.nvim: File explorer sidebar with git status and diagnostics
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- Keys: <leader>e = toggle file explorer
return {
	"nvim-neo-tree/neo-tree.nvim",
	commit = "ebd6676",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						".venv",
						"__pycache__",
						"node_modules",
					},
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						-- auto close Neo-tree
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
	end,
}
