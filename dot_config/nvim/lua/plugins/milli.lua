-- milli.nvim: Animated splash screen for the alpha dashboard
-- https://github.com/amansingh-afk/milli.nvim
return {
	"amansingh-afk/milli.nvim",
	lazy = false,
	cond = not vim.env.SSH_TTY,
	config = function()
		require("milli").alpha({ splash = "flyingdragon", loop = true })
	end,
}
