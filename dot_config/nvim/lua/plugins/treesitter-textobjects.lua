-- nvim-treesitter-textobjects: DISABLED — causes crash on Neovim 0.12.3
-- (attempt to call method 'range' on nil in languagetree.lua)
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- Keys: if/af = inner/outer function, ic/ac = inner/outer class (visual + operator)
--[[
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	version = false,
	init = function()
		vim.g.no_plugin_maps = true
	end,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")

		vim.keymap.set({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end, { desc = "Select inside function body" })

		vim.keymap.set({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end, { desc = "Select entire function (including signature)" })

		vim.keymap.set({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end, { desc = "Select inside class body" })

		vim.keymap.set({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end, { desc = "Select entire class (including definition)" })
	end,
}
--]]
return {}
