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
		})

		-- Enable treesitter-based indentation for all filetypes with a parser
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				if vim.treesitter.get_parser(0, vim.bo.filetype, { error = false }) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
