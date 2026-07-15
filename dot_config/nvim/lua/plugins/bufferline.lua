-- bufferline.nvim: Tab-style buffer bar with LSP diagnostics indicators
-- https://github.com/akinsho/bufferline.nvim
return {
	"akinsho/bufferline.nvim",
	version = "^4.0.0",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		})
	end,
}
