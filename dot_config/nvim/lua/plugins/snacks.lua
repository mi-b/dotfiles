-- snacks.nvim: A collection of small QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim
--
-- All modules are disabled by default.
--
-- Modules:
--   bigfile       – disables heavy features (treesitter, LSP) for large files
--   quickfile     – renders file before plugins load (`nvim somefile.txt`)
--   notifier      – DISABLED (replaced by noice.nvim)
--   indent        – indent guides and scope highlighting
--   words         – highlight LSP references under cursor, jump between them
--   input         – better vim.ui.input float
--   bufdelete     – delete buffers without disrupting window layout
--   toggle        – toggle keymaps integrated with which-key
--   rename        – LSP-aware file rename (integrates with neo-tree)
--   scope         – treesitter/indent scope detection (could replace wildfire)
--   statuscolumn  – pretty status column
--
-- Keymaps:
--   <leader>z   Toggle Zen mode                       (zen)
--   <leader>Z   Toggle Zoom (maximise current window) (zen)
--   <leader>bc  Delete current buffer (layout-safe)   (bufdelete)
--   <leader>bo  Delete all other buffers               (bufdelete)
--   <leader>lr  Rename file (LSP-aware)                (rename)
--   ]]          Jump to next LSP reference             (words)
--   [[          Jump to previous LSP reference         (words)
--
-- Toggle keymaps (<leader>o = Options):
--   <leader>os  Toggle spell check
--   <leader>ow  Toggle word wrap
--   <leader>ol  Toggle line numbers
--   <leader>oL  Toggle relative line numbers
--   <leader>od  Toggle diagnostics
--   <leader>oi  Toggle inlay hints
--   <leader>og  Toggle indent guides                   (requires indent module)
--   <leader>oD  Toggle dim mode
--   <leader>oc  Toggle conceal level
--
-- Conflicts:
--   <leader>bc and <leader>bo are also defined in which-key.lua.
--   When bufdelete is enabled, remove those mappings from which-key.lua
--   to avoid duplicates.

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- ── Module configuration ────────────────────────────────────────
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        notifier = { enabled = false },
        indent = { enabled = true, only_scope = true, only_current = true },
        words = { enabled = false },
        input = { enabled = true },
        scope = { enabled = false }, -- NOTE: could replace wildfire.nvim
        statuscolumn = { enabled = true },
    },

    -- ── Keymaps ──────────────────────────────────────────────────────
    keys = {
        -- Zen

        -- Buffer delete (replaces <leader>bc and <leader>bo in which-key.lua)
        {
            "<leader>bc",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete current buffer (layout-safe)",
        },
        {
            "<leader>bo",
            function()
                Snacks.bufdelete.other()
            end,
            desc = "Delete all other buffers",
        },

        -- Rename
        {
            "<leader>lr",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename file (LSP-aware)",
        },

        -- Words (LSP references)
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Jump to next LSP reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Jump to previous LSP reference",
            mode = { "n", "t" },
        },
    },

    -- ── Toggles (set up after plugins load) ──────────────────────────
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Option toggles (<leader>o prefix)
                Snacks.toggle.option("spell", { name = "Spell check" }):map("<leader>os")
                Snacks.toggle.option("wrap", { name = "Word wrap" }):map("<leader>ow")
                Snacks.toggle.line_number():map("<leader>ol")
                Snacks.toggle.option("relativenumber", { name = "Relative line numbers" }):map("<leader>oL")
                Snacks.toggle.diagnostics():map("<leader>od")
                Snacks.toggle.inlay_hints():map("<leader>oi")
                Snacks.toggle.indent():map("<leader>og")
                Snacks.toggle.dim():map("<leader>oD")
                Snacks.toggle
                    .option("conceallevel", {
                        off = 0,
                        on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
                        name = "Conceal level",
                    })
                    :map("<leader>oc")
            end,
        })
    end,
}
