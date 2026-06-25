-- blink.cmp: Fast completion engine with built-in LSP, snippet, and fuzzy support
-- https://github.com/saghen/blink.cmp
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
