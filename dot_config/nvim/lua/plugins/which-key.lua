-- which-key.nvim: Popup showing available keybindings as you type
-- https://github.com/folke/which-key.nvim
-- Keys: <leader>?  = show buffer-local keymaps
--        <leader>/  = toggle comment        | <leader>q  = quit window
--        <leader>w  = save file             | <leader>i  = re-indent file
--        <leader>b* = buffer management     | <leader>x* = quickfix / location list
--        <leader>t* = tab management        | <leader>T* = terminal
--        <leader>o* = option toggles (snacks.toggle)
--        C-h/j/k/l  = move focus between splits
--        |/\         = create vertical/horizontal split
--        ]b/[b       = next/prev buffer     | >b/<b      = move buffer right/left
--        ]t/[t       = next/prev tab
return {
	{ "nvim-tree/nvim-web-devicons", version = "^0.100", opts = {} },
	{
		"folke/which-key.nvim",
		version = "^3.0.0",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Show buffer-local keymaps",
			},
		},
		config = function()
			local wk = require("which-key")
			wk.setup({
				icons = {
					rules = {
						-- File / tree
						{ pattern = "file explorer", cat = "filetype", name = "neo-tree" },
						{ pattern = "symbol outline", icon = "󰊕", color = "cyan" },
						-- Flash / jump
						{ pattern = "jump to any", icon = "󰉁", color = "yellow" },
						{ pattern = "treesitter", icon = "󱏒", color = "green" },
						-- Edit actions
						{ pattern = "replace", icon = "󰉈", color = "red" },
						{ pattern = "select every", icon = "󰒆", color = "cyan" },
						{ pattern = "clipboard", icon = "󰅇", color = "yellow" },
						{ pattern = "yank", icon = "󰅇", color = "yellow" },
						{ pattern = "undo", icon = "󰕌", color = "orange" },
						{ pattern = "indent entire", icon = "󰉵", color = "cyan" },
						{ pattern = "comment", icon = "󰆈", color = "grey" },
						-- Help / meta
						{ pattern = "buffer%-local keymaps", icon = "󰌌", color = "purple" },
						-- Git
						{ pattern = "hunk", icon = "󰈈", color = "green" },
						{ pattern = "blame", icon = "󰅈", color = "orange" },
						{ pattern = "lazygit", cat = "filetype", name = "git" },
						-- Terminal
						{ pattern = "new terminal", icon = "󰐕", color = "green" },
						-- Debug
						{ pattern = "breakpoint", icon = "󰺕", color = "red" },
						{ pattern = "continue", icon = "󰐊", color = "green" },
						{ pattern = "run to cursor", icon = "󰳽", color = "azure" },
						{ pattern = "terminate", icon = "󰓛", color = "red" },
						-- Save / quit
						{ pattern = "save file", icon = "󰆓", color = "green" },
						{ pattern = "save all", icon = "󰆔", color = "green" },
						{ pattern = "quit", icon = "󰅖", color = "red" },
					},
				},
			})
			wk.add({
				-- Groups using nvim-web-devicons (coloured automatically)
				{ "<leader>g", group = "Git", icon = { cat = "filetype", name = "git" } },
				{ "<leader>t", group = "Tabs", icon = { icon = "󰓩", color = "cyan" } },
				{ "<leader>T", group = "Terminal", icon = { cat = "filetype", name = "terminal" } },
				{ "<leader>M", group = "Markdown", icon = { cat = "filetype", name = "markdown" } },

				-- Groups with coloured Nerd Font icons
				{ "<leader>b", group = "Buffers", icon = { icon = "󰈢", color = "blue" } },
				{ "<leader>d", group = "Debug", icon = { icon = "󰠭", color = "red" } },
				{ "<leader>f", group = "Find", icon = { icon = "󰍉", color = "green" } },
				{ "<leader>j", group = "Harpoon", icon = { icon = "󰛢", color = "azure" } },
				{ "<leader>l", group = "Language Tools", icon = { icon = "󰅴", color = "orange" } },
				{ "<leader>m", group = "Marks", icon = { icon = "󰃀", color = "yellow" } },
				{ "<leader>o", group = "Options", icon = { icon = "󰒓", color = "cyan" } },
				{ "<leader>x", group = "Lists", icon = { icon = "󰉹", color = "purple" } },

				{
					"<leader>b",
					group = "Buffers",
					expand = function()
						local ret = {}
						local elements = require("bufferline").get_elements().elements
						for i, el in ipairs(elements) do
							if i <= 9 then
								local num = i
								table.insert(ret, {
									tostring(i),
									function()
										require("bufferline").go_to(num, true)
									end,
									desc = el.name,
								})
							end
						end
						if #elements > 0 then
							table.insert(ret, {
								"$",
								function()
									require("bufferline").go_to(-1, true)
								end,
								desc = "Go to last buffer",
							})
						end
						return ret
					end,
				},

				{
					mode = "n",
					{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to previous buffer" },
					{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Go to next buffer" },
					{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
					{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
					{ ">b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
					{ "<b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
					{ "<leader>bl", "<cmd>buffers<cr>", desc = "List all buffers" },
					{ "<leader>bb", "<C-^>", desc = "Switch to last used buffer" },
					{ "<leader>bc", "<cmd>bd<cr>", desc = "Close current buffer" },
					{ "<leader>br", "<cmd>e!<cr>", desc = "Revert buffer to saved" },
					{ "<leader>bR", "<cmd>bufdo e!<cr>", desc = "Revert all buffers to saved" },
					{ "<leader>bo", "<cmd>:%bd|e#|bd#<cr>", desc = "Close all other buffers" },
					{ "<leader>bC", "<cmd>:bufdo bd<cr>", desc = "Close all buffers" },
				},

				{
					mode = "n",
					{ "<C-h>", "<C-w>h", desc = "Move focus to left split" },
					{ "<C-j>", "<C-w>j", desc = "Move focus to below split" },
					{ "<C-k>", "<C-w>k", desc = "Move focus to above split" },
					{ "<C-l>", "<C-w>l", desc = "Move focus to right split" },
				},

				{
					mode = "n",
					{ "<C-Up>", "<cmd>resize -2<cr>", desc = "Shrink split vertically" },
					{ "<C-Down>", "<cmd>resize +2<cr>", desc = "Grow split vertically" },
					{ "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Shrink split horizontally" },
					{ "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Grow split horizontally" },
				},

				{
					mode = "n",
					{ "|", "<cmd>vsplit<cr>", desc = "Create vertical split" },
					{ "\\", "<cmd>split<cr>", desc = "Create horizontal split" },
				},

				{
					mode = "n",
					{ "<leader>tn", "<cmd>tabnew<cr>", desc = "New tab" },
					{ "<leader>tc", "<cmd>tabclose<cr>", desc = "Close tab" },
					{ "<leader>to", "<cmd>tabonly<cr>", desc = "Close other tabs" },
					{ "]t", "<cmd>tabnext<cr>", desc = "Next tab" },
					{ "[t", "<cmd>tabprev<cr>", desc = "Previous tab" },
				},

				{
					mode = "n",
					{
						"[d",
						function()
							vim.diagnostic.jump({ count = -1 })
						end,
						desc = "Jump to previous diagnostic",
					},
					{
						"]d",
						function()
							vim.diagnostic.jump({ count = 1 })
						end,
						desc = "Jump to next diagnostic",
					},
					{
						"[e",
						function()
							vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
						end,
						desc = "Jump to previous error",
					},
					{
						"]e",
						function()
							vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
						end,
						desc = "Jump to next error",
					},
					{
						"[w",
						function()
							vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
						end,
						desc = "Jump to previous warning",
					},
					{
						"]w",
						function()
							vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
						end,
						desc = "Jump to next warning",
					},
				},

				{
					mode = "n",
					{ "<leader>xq", "<cmd>copen<cr>", desc = "Open quickfix list" },
					{ "<leader>xl", "<cmd>lopen<cr>", desc = "Open location list" },
				},

				{ "<leader>/", "gcc", remap = true, desc = "Toggle comment on line", mode = "n" },
				{ "<leader>/", "gc", remap = true, desc = "Toggle comment on selection", mode = "x" },

				{
					mode = "v",
					{ "<Tab>", ">gv", desc = "Indent and stay in visual mode" },
					{ "<S-Tab>", "<gv", desc = "Unindent and stay in visual mode" },
				},

				{
					mode = { "n", "v" },
					{ "<leader>q", "<cmd>q<cr>", desc = "Quit window" },
					{ "<leader>Q", "<cmd>qall<cr>", desc = "Quit all windows" },
					{ "<leader>w", "<cmd>w<cr>", desc = "Save file" },
					{ "<leader>W", "<cmd>wall<cr>", desc = "Save all files" },
					{ "<leader>i", "gg=G", desc = "Re-indent entire file" },
				},
			})
		end,
	},
}
