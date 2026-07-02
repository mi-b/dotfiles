-- wildfire.nvim: Incremental treesitter node selection
-- https://github.com/SUSTech-data/wildfire.nvim
-- Keys: <CR> = start/expand selection | <BS> = shrink selection
return {
	"sustech-data/wildfire.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("wildfire").setup({
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				node_decremental = "<BS>",
			},
		})
	end,
}
