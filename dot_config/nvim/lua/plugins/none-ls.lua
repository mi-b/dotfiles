-- none-ls.nvim: Inject external formatters and linters as virtual LSP sources.
-- https://github.com/nvimtools/none-ls.nvim
--
-- This is the maintained fork of null-ls.nvim. It wraps CLI tools (stylua,
-- prettier, shfmt, etc.) so they appear as LSP formatting/diagnostic providers.
-- This lets us use a single vim.lsp.buf.format() call for everything.
--
-- Note: some languages use their own LSP server for formatting instead of
-- none-ls (ruff for Python, taplo for TOML, tinymist for Typst). The filter
-- in the <leader>lf keymap below routes each filetype to the right provider.
--
-- Keys: <leader>lf = format current buffer
return {
    "nvimtools/none-ls.nvim",
    commit = "c4b82bb",
    config = function()
        local null_ls = require("null-ls")

        -- Build the list of formatting sources. On Windows we only use stylua
        -- because most Unix CLI tools aren't readily available there.
        local sources = {}
        if not require("utils").is_windows() then
            -- Lua formatter (opinionated, respects .stylua.toml)
            table.insert(sources, null_ls.builtins.formatting.stylua)

            -- Multi-language formatter for web files: JS, TS, CSS, HTML, JSON,
            -- Markdown, YAML, and more. Respects .prettierrc config.
            table.insert(sources, null_ls.builtins.formatting.prettier)

            table.insert(sources, null_ls.builtins.formatting.nixfmt)

            -- Shell script formatter. Indent set to 4 spaces.
            -- Skipped for .tmpl files (chezmoi templates) to avoid mangling
            -- Go template syntax embedded in shell scripts.
            table.insert(
                sources,
                null_ls.builtins.formatting.shfmt.with({
                    condition = function()
                        return not vim.api.nvim_buf_get_name(0):match("%.tmpl$")
                    end,
                    args = { "-i", "4" },
                })
            )

            -- C/C++ formatter (uses .clang-format config if present)
            table.insert(sources, null_ls.builtins.formatting.clang_format)

            -- Linters (diagnostics only, no formatting)
            -- NOTE: shellcheck diagnostics come via bashls (bash-language-server
            -- runs shellcheck internally), so no none-ls source needed.
            table.insert(sources, null_ls.builtins.diagnostics.markdownlint_cli2)
            table.insert(sources, null_ls.builtins.diagnostics.hadolint)
            table.insert(sources, null_ls.builtins.diagnostics.yamllint)
        else
            table.insert(sources, null_ls.builtins.formatting.stylua)
        end

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            sources = sources,
            -- Format-on-save (disabled). Uncomment to auto-format before every write.
            -- on_attach = function(client, bufnr)
            --   if client.supports_method("textDocument/formatting") then
            --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            --     vim.api.nvim_create_autocmd("BufWritePre", {
            --       group = augroup,
            --       buffer = bufnr,
            --       callback = function()
            --         vim.lsp.buf.format({ async = false })
            --       end,
            --     })
            --   end
            -- end,
        })

        -- Format keymap: routes each filetype to the correct formatting provider.
        -- Most filetypes use none-ls (which wraps CLI tools like stylua, prettier,
        -- shfmt, clang-format). Some filetypes have LSP servers with native
        -- formatting support — these are listed in native_formatters below.
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({
                async = false,
                filter = function(c)
                    local ft = vim.bo.filetype
                    -- LSP servers that handle their own formatting natively.
                    -- For these filetypes, we bypass none-ls and use the server directly.
                    local native_formatters = {
                        python = "ruff", -- ruff: fast Python formatter (replaces black/isort)
                        toml = "taplo", -- taplo: TOML formatter + validator
                        typst = "tinymist", -- tinymist: Typst formatter + LSP
                    }
                    if native_formatters[ft] then
                        return c.name == native_formatters[ft]
                    end
                    -- Everything else: use none-ls (stylua, prettier, shfmt, clang-format)
                    return c.name == "null-ls"
                end,
            })
        end, { desc = "Format current buffer" })
    end,
}
