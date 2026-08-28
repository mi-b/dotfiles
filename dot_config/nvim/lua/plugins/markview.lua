-- markview.nvim: In-editor markdown rendering with preview and splitview
-- https://github.com/OXY2DEV/markview.nvim
-- Keys: <leader>MM = toggle preview | <leader>MS = toggle splitview
--
-- Do NOT lazy-load this plugin (ft, cmd, etc.) — it handles its own
-- lazy-loading internally. Using `lazy = false` ensures setup() runs
-- at startup before any buffer triggers auto-attach.

return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    config = function()
        local presets = require("markview.presets").headings
        require("markview").setup({
            preview = { enable = false },
            markdown = { headings = presets.numbered },
        })

        vim.keymap.set("n", "<leader>MM", "<CMD>Markview Toggle<CR>", { desc = "markview: Toggle preview" })
        vim.keymap.set("n", "<leader>MS", "<CMD>Markview splitToggle<CR>", { desc = "markview: Toggle splitview" })
    end,
}
