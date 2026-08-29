-- blink.cmp: Fast completion engine with built-in LSP, snippet, and fuzzy support
-- https://github.com/saghen/blink.cmp
-- Keys: <C-n>/<C-p>     = next/prev item   | <C-y>       = accept
--        <C-e>           = dismiss           | <C-b>/<C-f> = scroll docs
--        <Tab>/<S-Tab>   = snippet jump      | <C-k>       = signature help
return {
    "saghen/blink.cmp",
    version = "^1.0.0",
    dependencies = {
        { "rafamadriz/friendly-snippets", commit = "6cd7280" },
    },
    opts = {
        keymap = { preset = "default" },
        completion = {
            documentation = {
                auto_show = true,
                window = { border = "rounded" },
            },
            menu = {
                border = "rounded",
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
}
