-- LSP configuration: Mason (installer), mason-lspconfig (auto-install), nvim-lspconfig (server configs)
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig
-- Keys (built-in): K = hover, grr = references, gra = code action, grn = rename,
--                   gri = implementation, grt = type definition
-- Keys (explicit): gd = definition, gD = declaration, gl = diagnostic float
return {
  {
    "williamboman/mason.nvim",
    version = "^2.0.0",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^2.0.0",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    version = "^2.0.0",
    lazy = false,
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

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
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
      })
      vim.lsp.enable("ruff")

      vim.lsp.config("ty", {
        capabilities = capabilities,
        root_markers = { "pyproject.toml", ".git" },
        on_attach = function(client, bufnr)
          -- ty sends unused bindings as hint-severity (4) diagnostics.
          -- These don't appear in `ty check` CLI output and are noise in the editor.
          -- Re-set each ty namespace with hints stripped whenever diagnostics change.
          vim.api.nvim_create_autocmd("DiagnosticChanged", {
            buffer = bufnr,
            callback = function()
              for name, ns_id in pairs(vim.api.nvim_get_namespaces()) do
                if name:find("nvim%.lsp%.ty%." .. client.id) then
                  local diags = vim.diagnostic.get(bufnr, { namespace = ns_id })
                  local filtered = vim.tbl_filter(function(d)
                    return d.severity ~= vim.diagnostic.severity.HINT
                  end, diags)
                  if #filtered ~= #diags then
                    vim.diagnostic.set(ns_id, bufnr, filtered)
                  end
                end
              end
            end,
          })
        end,
      })
      vim.lsp.enable("ty")

      vim.lsp.config("clangd", {
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

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp.keymaps", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition,  vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic float" }))
        end,
      })
    end,
  },
}
