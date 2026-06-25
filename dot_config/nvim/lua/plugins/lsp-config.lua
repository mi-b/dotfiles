return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("ruff", {
        capabilities = capabilities,
      })
      vim.lsp.enable("ruff")

      vim.lsp.config("ty", {
        capabilities = capabilities,
      })
      vim.lsp.enable("ty")

      vim.lsp.config("clangd",{
        capabilities = capabilities,
        cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        },
      })
      vim.lsp.enable("clangd")

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "lsp references" })
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "lsp code action" })
      vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "lsp rename" })
    end,
  },
}
