-- noice.nvim: Replaces cmdline, messages, and notifications with a modern UI
-- https://github.com/folke/noice.nvim
-- Replaces: command line, search popup, messages, notifications, LSP progress
-- Sets cmdheight=0 to reclaim the bottom line
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
        },
        messages = {
            enabled = true,
        },
        popupmenu = {
            enabled = true,
        },
        notify = {
            enabled = true,
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            progress = {
                enabled = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
        routes = {
            -- Written messages → mini (subtle)
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                view = "mini",
            },
        },
    },
    config = function(_, opts)
        require("noice").setup(opts)
        vim.o.cmdheight = 0
    end,
}
