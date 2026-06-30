-- which-key.nvim: Popup showing available keybindings as you type
-- https://github.com/folke/which-key.nvim
-- Keys: <leader>? = show buffer-local keymaps (see config below for all bindings)
return {
  { "nvim-tree/nvim-web-devicons", version = "^0.100", opts = {} },
  {
    "folke/which-key.nvim",
    version = "^3.0.0",
    event = "VeryLazy",
    opts = {},
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
      wk.add({
        { "<leader>b", group = "Buffers",        icon = "📑" },
        { "<leader>d", group = "Debug",          icon = "🐞" },
        { "<leader>f", group = "Find",           icon = "🔍" },
        { "<leader>j", group = "Harpoon",        icon = "🪝" },
        { "<leader>l", group = "Language Tools", icon = "🌐" },
        { "<leader>m", group = "Marks",          icon = "📌" },
        { "<leader>g", group = "Git",            icon = "🌱" },
        { "<leader>M", group = "Markdown",       icon = "📝" },
        { "<leader>x", group = "Lists",          icon = "📋" },

        {
          "<leader>b",
          group = "Buffers",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },

        {
          mode = "n",
          { "<leader>bp", "<cmd>bprevious<cr>",   desc = "Go to previous buffer" },
          { "<leader>bn", "<cmd>bnext<cr>",       desc = "Go to next buffer" },
          { "<leader>bl", "<cmd>buffers<cr>",     desc = "List all buffers" },
          { "<leader>bb", "<C-^>",               desc = "Switch to last used buffer" },
          { "<leader>bc", "<cmd>bd<cr>",          desc = "Close current buffer" },
          { "<leader>bo", "<cmd>:%bd|e#|bd#<cr>", desc = "Close all other buffers" },
          { "<leader>bC", "<cmd>:bufdo bd<cr>",   desc = "Close all buffers" },
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
          { "<C-Up>",    "<cmd>resize -2<cr>",          desc = "Shrink split vertically" },
          { "<C-Down>",  "<cmd>resize +2<cr>",          desc = "Grow split vertically" },
          { "<C-Left>",  "<cmd>vertical resize -2<cr>", desc = "Shrink split horizontally" },
          { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Grow split horizontally" },
        },

        {
          mode = "n",
          { "|",  "<cmd>vsplit<cr>", desc = "Create vertical split" },
          { "\\", "<cmd>split<cr>",  desc = "Create horizontal split" },
        },

        {
          mode = "n",
          { "[d", function() vim.diagnostic.jump({ count = -1 }) end,                                           desc = "Jump to previous diagnostic" },
          { "]d", function() vim.diagnostic.jump({ count = 1 }) end,                                            desc = "Jump to next diagnostic" },
          { "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, desc = "Jump to previous error" },
          { "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end,  desc = "Jump to next error" },
          { "[w", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end,  desc = "Jump to previous warning" },
          { "]w", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end,   desc = "Jump to next warning" },
        },

        {
          mode = "n",
          { "<leader>xq", "<cmd>copen<cr>", desc = "Open quickfix list" },
          { "<leader>xl", "<cmd>lopen<cr>", desc = "Open location list" },
        },

        { "<leader>/", "gcc", remap = true, desc = "Toggle comment on line",      mode = "n" },
        { "<leader>/", "gc",  remap = true, desc = "Toggle comment on selection", mode = "x" },

        {
          mode = "v",
          { "<Tab>",   ">gv", desc = "Indent and stay in visual mode" },
          { "<S-Tab>", "<gv", desc = "Unindent and stay in visual mode" },
        },

        {
          mode = { "n", "v" },
          { "<leader>q", "<cmd>q<cr>",    desc = "Quit window" },
          { "<leader>Q", "<cmd>qall<cr>", desc = "Quit all windows" },
          { "<leader>w", "<cmd>w<cr>",    desc = "Save file" },
          { "<leader>W", "<cmd>wall<cr>", desc = "Save all files" },
          { "<leader>i", "gg=G",          desc = "Re-indent entire file" },
        },
      })
    end,
  }
}
