-- aerial.nvim: Code outline sidebar and symbol navigation
-- https://github.com/stevearc/aerial.nvim
return {
	"stevearc/aerial.nvim",
	version = "^4.0.0",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local aerial = require("aerial")
		aerial.setup({
			on_attach = function(bufnr)
				vim.keymap.set("n", "[s", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Jump to previous symbol" })
				vim.keymap.set("n", "]s", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Jump to next symbol" })
			end,
		})

		vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle symbol outline" })
	end,
}
