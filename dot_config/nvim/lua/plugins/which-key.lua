return {
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    -- keys = {
    -- 	{
    -- 		"<leader>?",
    -- 		function()
    -- 			require("which-key").show({ global = false })
    -- 		end,
    -- 		desc = "Buffer Local Keymaps (which-key)",
    -- 	},
    -- },
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>d", group = "Debug", icon = "🐞" },
        { "<leader>f", group = "Find", icon = "🔍" },
        -- p : icon("Package") "Packages"
        -- p = { name = "📦 Packages" },
        { "<leader>l", group = "Language Tools", icon = "🌐" },
        -- u : icon("Window") "UI/UX"
        -- b : icon("Tab") "Buffers"
        -- bs:_icon("Sort") "Sort Buffers"
        -- d : icon("Debugger") "Debugger"
        -- g : icon("Git") "Git"
        -- g = { name = "🌱 Git" },
        -- S : icon("Session") "Session"
        -- S = { name = "💾 Session" },
        -- t : icon("Terminal") "Terminal"
        -- t = { name = "🖥️ Terminal" },
        -- x : icon("List") "Quickfix/Lists"
        -- x = { name = "📋 Quickfix/Lists" },
        -- b = {   name = "📑 Buffers",
        {
          "<leader>b",
          group = "buffers",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          mode = "n",
          { "<leader>bp", "<cmd>bprevious<cr>",   desc = "Previous buffer" },
          { "<leader>bn", "<cmd>bnext<cr>",       desc = "Next buffer" },
          { "<leader>bl", "<cmd>buffers<cr>",     desc = "List buffer" },
          { "<leader>bb", "<C-^><cr>",            desc = "Last used buffer" },
          { "<leader>bc", "<cmd>:%bd|e#|bd#<cr>", desc = "Close all other buffers" },
          { "<leader>bC", "<cmd>:bufdo bd<cr>",   desc = "Close all buffers" },
        },
        {
          mode = { "n", "v" },
          { "<leader>q", "<cmd>q<cr>",    desc = "Quit" },
          { "<leader>Q", "<cmd>qall<cr>", desc = "Quit all" },
          { "<leader>w", "<cmd>w<cr>",    desc = "Write" },
          { "<leader>W", "<cmd>wall<cr>", desc = "Write all" },
          { "<leader>i", "gg=G",          desc = "Indent file" },
          { "<leader>c", "<cmd>bd<cr>",   desc = "Close current buffer" },
        },
      })
    end,
  }
}

-- maps.n["<Leader>n"] = { "<Cmd>enew<CR>", desc = "New File" }
-- maps.n["<C-S>"] = { "<Cmd>silent! update! | redraw<CR>", desc = "Force write" }
-- maps.x["<C-S>"] = maps.i["<C-s>"]
-- maps.n["<C-Q>"] = { "<Cmd>q!<CR>", desc = "Force quit" }
-- maps.n["|"] = { "<Cmd>vsplit<CR>", desc = "Vertical Split" }
-- maps.n["\\"] = { "<Cmd>split<CR>", desc = "Horizontal Split" }
-- maps.n["<Leader>/"] = { "gcc", remap = true, desc = "Toggle comment line" }
-- maps.x["<Leader>/"] = { "gc", remap = true, desc = "Toggle comment" }
--
-- -- Neovim Default LSP Mappings
-- if vim.fn.has "nvim-0.11" ~= 1 then
--   maps.n["gra"] = { function() vim.lsp.buf.code_action() end, desc = "vim.lsp.buf.code_action()" }
--   maps.x["gra"] = { function() vim.lsp.buf.code_action() end, desc = "vim.lsp.buf.code_action()" }
--   maps.n["grn"] = { function() vim.lsp.buf.rename() end, desc = "vim.lsp.buf.rename()" }
--   maps.n["grr"] = { function() vim.lsp.buf.references() end, desc = "vim.lsp.buf.references()" }
--   maps.n["gri"] = { function() vim.lsp.buf.implementation() end, desc = "vim.lsp.buf.implementation()" }
--   maps.n["gO"] = { function() vim.lsp.buf.document_symbol() end, desc = "vim.lsp.buf.document_symbol()" }
--   maps.i["<C-S>"] = { function() vim.lsp.buf.signature_help() end, desc = "vim.lsp.buf.signature_help()" }
--   maps.s["<C-S>"] = { function() vim.lsp.buf.signature_help() end, desc = "vim.lsp.buf.signature_help()" }
-- end
--
-- -- Plugin Manager
-- maps.n["<Leader>p"] = vim.tbl_get(sections, "p")
-- maps.n["<Leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
-- maps.n["<Leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
-- maps.n["<Leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
-- maps.n["<Leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
-- maps.n["<Leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }
-- maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Update Lazy and Mason" }
--
-- -- Manage Buffers
-- maps.n["<Leader>c"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
-- maps.n["<Leader>C"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
-- maps.n["]b"] = {
--   function() require("astrocore.buffer").nav(vim.v.count1) end,
--   desc = "Next buffer",
-- }
-- maps.n["[b"] = {
--   function() require("astrocore.buffer").nav(-vim.v.count1) end,
--   desc = "Previous buffer",
-- }
-- maps.n[">b"] = {
--   function() require("astrocore.buffer").move(vim.v.count1) end,
--   desc = "Move buffer tab right",
-- }
-- maps.n["<b"] = {
--   function() require("astrocore.buffer").move(-vim.v.count1) end,
--   desc = "Move buffer tab left",
-- }
--
-- maps.n["<Leader>b"] = vim.tbl_get(sections, "b")
-- maps.n["<Leader>bc"] =
-- { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
-- maps.n["<Leader>bC"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" }
-- maps.n["<Leader>bl"] =
-- { function() require("astrocore.buffer").close_left() end, desc = "Close all buffers to the left" }
-- maps.n["<Leader>bp"] = { function() require("astrocore.buffer").prev() end, desc = "Previous buffer" }
-- maps.n["<Leader>br"] =
-- { function() require("astrocore.buffer").close_right() end, desc = "Close all buffers to the right" }
-- maps.n["<Leader>bs"] = vim.tbl_get(sections, "bs")
-- maps.n["<Leader>bse"] = { function() require("astrocore.buffer").sort "extension" end, desc = "By extension" }
-- maps.n["<Leader>bsr"] = { function() require("astrocore.buffer").sort "unique_path" end, desc = "By relative path" }
-- maps.n["<Leader>bsp"] = { function() require("astrocore.buffer").sort "full_path" end, desc = "By full path" }
-- maps.n["<Leader>bsi"] = { function() require("astrocore.buffer").sort "bufnr" end, desc = "By buffer number" }
-- maps.n["<Leader>bsm"] = { function() require("astrocore.buffer").sort "modified" end, desc = "By modification" }
--
-- maps.n["<Leader>l"] = vim.tbl_get(sections, "l")
-- maps.n["<Leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
-- local function diagnostic_jump(dir, severity)
--   local jump_opts = {}
--   if type(severity) == "string" then jump_opts.severity = vim.diagnostic.severity[severity] end
--   if vim.fn.has "nvim-0.11" == 1 then
--     return function()
--       jump_opts.count = dir and vim.v.count1 or -vim.v.count1
--       vim.diagnostic.jump(jump_opts)
--     end
--   else     -- TODO: remove when dropping support for Neovim v0.10
--     local jump = vim.diagnostic["goto_" .. (dir and "next" or "prev")]
--     return function() jump(jump_opts) end
--   end
-- end
-- -- TODO: Remove mapping after dropping support for Neovim v0.10, it's automatic
-- if vim.fn.has "nvim-0.11" == 0 then
--   maps.n["[d"] = { diagnostic_jump(false), desc = "Previous diagnostic" }
--   maps.n["]d"] = { diagnostic_jump(true), desc = "Next diagnostic" }
-- end
-- maps.n["[e"] = { diagnostic_jump(false, "ERROR"), desc = "Previous error" }
-- maps.n["]e"] = { diagnostic_jump(true, "ERROR"), desc = "Next error" }
-- maps.n["[w"] = { diagnostic_jump(false, "WARN"), desc = "Previous warning" }
-- maps.n["]w"] = { diagnostic_jump(true, "WARN"), desc = "Next warning" }
-- maps.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
--
-- -- Navigate tabs
-- maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
-- maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }
--
-- -- Split navigation
-- maps.n["<C-H>"] = { "<C-w>h", desc = "Move to left split" }
-- maps.n["<C-J>"] = { "<C-w>j", desc = "Move to below split" }
-- maps.n["<C-K>"] = { "<C-w>k", desc = "Move to above split" }
-- maps.n["<C-L>"] = { "<C-w>l", desc = "Move to right split" }
-- maps.n["<C-Up>"] = { "<Cmd>resize -2<CR>", desc = "Resize split up" }
-- maps.n["<C-Down>"] = { "<Cmd>resize +2<CR>", desc = "Resize split down" }
-- maps.n["<C-Left>"] = { "<Cmd>vertical resize -2<CR>", desc = "Resize split left" }
-- maps.n["<C-Right>"] = { "<Cmd>vertical resize +2<CR>", desc = "Resize split right" }
--
-- -- List management
-- maps.n["<Leader>x"] = vim.tbl_get(sections, "x")
-- maps.n["<Leader>xq"] = { "<Cmd>copen<CR>", desc = "Quickfix List" }
-- maps.n["<Leader>xl"] = { "<Cmd>lopen<CR>", desc = "Location List" }
-- if vim.fn.has "nvim-0.11" == 0 then
--   maps.n["]q"] = { vim.cmd.cnext, desc = "Next quickfix" }
--   maps.n["[q"] = { vim.cmd.cprev, desc = "Previous quickfix" }
--   maps.n["]Q"] = { vim.cmd.clast, desc = "End quickfix" }
--   maps.n["[Q"] = { vim.cmd.cfirst, desc = "Beginning quickfix" }
--
--   maps.n["]l"] = { vim.cmd.lnext, desc = "Next loclist" }
--   maps.n["[l"] = { vim.cmd.lprev, desc = "Previous loclist" }
--   maps.n["]L"] = { vim.cmd.llast, desc = "End loclist" }
--   maps.n["[L"] = { vim.cmd.lfirst, desc = "Beginning loclist" }
-- end
--
-- -- Stay in indent mode
-- maps.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }
-- maps.v["<Tab>"] = { ">gv", desc = "Indent line" }
--
-- -- Improved Terminal Navigation
-- local function term_nav(dir)
--   return function()
--     if vim.api.nvim_win_get_config(0).zindex then
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-" .. dir .. ">", true, false, true), "n", false)
--     else
--       vim.cmd.wincmd(dir)
--     end
--   end
-- end
-- maps.t["<C-H>"] = { term_nav "h", desc = "Terminal left window navigation" }
-- maps.t["<C-J>"] = { term_nav "j", desc = "Terminal down window navigation" }
-- maps.t["<C-K>"] = { term_nav "k", desc = "Terminal up window navigation" }
-- maps.t["<C-L>"] = { term_nav "l", desc = "Terminal right window navigation" }
