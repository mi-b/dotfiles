-- marks.nvim: Enhanced mark management with signs and keymaps
-- https://github.com/chentoast/marks.nvim
-- Keys: <leader>ms = set mark       | <leader>mm = preview mark
--        <leader>mp = prev mark      | <leader>mn = next mark
--        <leader>md = delete buffer marks
return {
	"chentoast/marks.nvim",
	commit = "f353e8c",
	event = "VeryLazy",
	config = function()
		require("marks").setup({
			mappings = {
				set_next = "<leader>ms",
				prev = "<leader>mp",
				next = "<leader>mn",
				preview = "<leader>mm",
				delete_buf = "<leader>md",
			},
		})
	end,
}
