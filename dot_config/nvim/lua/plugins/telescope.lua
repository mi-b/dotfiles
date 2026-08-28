-- telescope.nvim: Fuzzy finder for files, text, diagnostics, and more
-- https://github.com/nvim-telescope/telescope.nvim
-- Keys: <leader>ff = find files     | <leader>fr = recent (frecency)
--        <leader>fg = live grep      | <leader>fd = find diagnostics
--        <leader>fk = find keymaps
return {
    {
        "nvim-telescope/telescope.nvim",
        commit = "427b576",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-frecency.nvim", version = "^1.0.0" },
            { "nvim-telescope/telescope-ui-select.nvim", commit = "6e51d7d" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            telescope.load_extension("ui-select")
            telescope.load_extension("frecency")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files by name" })
            vim.keymap.set(
                "n",
                "<leader>fr",
                "<cmd>Telescope frecency<cr>",
                { desc = "Find recently opened files (frecency)" }
            )
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find text in project (grep)" })
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
            vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
        end,
    },
}
