return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local sources = {}
    if not require("utils").is_windows() then
      table.insert(sources, null_ls.builtins.formatting.stylua)
      table.insert(sources, null_ls.builtins.formatting.prettier)
      -- table.insert(sources, null_ls.builtins.formatting.ruff)
      table.insert(sources, null_ls.builtins.formatting.shfmt.with({ args = { "-i", "4" } }))
      -- table.insert(sources, null_ls.builtins.formatting.rubocop)
      -- table.insert(sources, null_ls.builtins.diagnostics.rubocop)
      -- table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
    else
      table.insert(sources, null_ls.builtins.formatting.stylua)
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format" })
  end,
}
