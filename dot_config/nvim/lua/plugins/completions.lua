return {
  {
    "hrsh7th/cmp-nvim-lsp",
    commit = "cbc7b02",
  },
  {
    "L3MON4D3/LuaSnip",
    version = "^2.0.0",
    dependencies = {
      { "saadparwaiz1/cmp_luasnip", commit = "98d9cb5" },
      { "rafamadriz/friendly-snippets", commit = "6cd7280" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    commit = "a1d5048",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
