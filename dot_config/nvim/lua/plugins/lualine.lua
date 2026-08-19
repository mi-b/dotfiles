-- lualine.nvim: Configurable statusline with mode, branch, and diagnostics info
-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	commit = "221ce6b",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					"filename",
					"searchcount",
					"selectioncount",
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_x = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return "󰅴 " .. table.concat(names, ", ")
						end,
						cond = function()
							return #vim.lsp.get_clients({ bufnr = 0 }) > 0
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = {
					"location",
					"hostname",
					{
						function()
							local total = vim.fn.tabpagenr("$")
							if total > 1 then
								return "󰓩 " .. vim.fn.tabpagenr() .. "/" .. total
							end
							return ""
						end,
						cond = function()
							return vim.fn.tabpagenr("$") > 1
						end,
					},
				},
			},
		})
	end,
}
