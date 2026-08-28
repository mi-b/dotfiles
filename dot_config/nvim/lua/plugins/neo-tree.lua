-- neo-tree.nvim: File explorer sidebar with git status and diagnostics
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- Keys: <leader>e = toggle file explorer
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".venv",
                        "__pycache__",
                        "node_modules",
                    },
                },
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },
        })
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

        -- Disable treesitter folding in neo-tree buffers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "neo-tree",
            callback = function()
                vim.opt_local.foldenable = false
                vim.opt_local.foldmethod = "manual"
                vim.opt_local.foldexpr = "0"
            end,
        })
    end,
}
