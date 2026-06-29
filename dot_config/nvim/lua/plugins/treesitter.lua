-- nvim-treesitter: Syntax-aware highlighting, indentation, and code parsing
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	version = false,
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install parsers (async, no-op if already installed)
		require("nvim-treesitter").install({
			"lua",
			"python",
			"c",
			"cpp",
			"bash",
			"toml",
			"markdown",
			"markdown_inline",
			"cmake",
			"html",
			"latex",
			"typst",
			"yaml",
			"comment",
		})

		-- Enable treesitter-based indentation for all filetypes with a parser
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local ok, parser = pcall(vim.treesitter.get_parser, 0, vim.bo.filetype, { error = false })
				if ok and parser then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
