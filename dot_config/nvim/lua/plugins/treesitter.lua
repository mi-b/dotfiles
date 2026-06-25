return {
	"nvim-treesitter/nvim-treesitter",
	version = "^0.9.0",
	lazy = false,
	build = ":TSUpdate",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
			ensure_installed = { "lua", "python", "c", "cpp", "bash", "toml", "markdown", "cmake" },
			auto_install = true,
			indent = {
				enable = true,
			},
		})
	end,
}
