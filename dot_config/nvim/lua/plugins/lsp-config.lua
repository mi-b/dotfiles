-- LSP configuration: nvim-lspconfig (server configs)
-- https://github.com/neovim/nvim-lspconfig
--
-- LSP servers and formatters are installed system-wide via Nix (Home Manager).
-- No Mason required — servers are found on $PATH.
--
-- Keymaps set by Neovim's built-in LSP client (no config needed):
--   K   = hover docs       | grr = references      | gra = code action
--   grn = rename symbol    | gri = implementation   | grt = type definition
--
-- Keymaps added explicitly below (in LspAttach autocmd):
--   gd  = go to definition | gD  = go to declaration | gl = diagnostic float
--
-- Formatting is handled in none-ls.lua via <leader>lf. Some LSP servers
-- (ruff, taplo, tinymist) provide native formatting and are routed to
-- directly; everything else goes through none-ls.
return {
    -- nvim-lspconfig: community-maintained default configurations for LSP servers.
    -- Each server is configured with blink.cmp capabilities for enhanced completion.
    {
        "neovim/nvim-lspconfig",
        version = "^2.0.0",
        lazy = false,
        config = function()
            -- Extend default LSP capabilities with blink.cmp's completion support
            -- (additional completionItem features like snippets, label details, etc.)
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            --------------------------------------------------------------------
            -- Lua: lua_ls (sumneko)
            -- Provides completion, diagnostics, formatting, and workspace-aware
            -- analysis for Lua (including Neovim's runtime and plugin APIs).
            --------------------------------------------------------------------
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("lua_ls")

            --------------------------------------------------------------------
            -- TypeScript / JavaScript: ts_ls
            -- Microsoft's TypeScript language server. Handles JS/TS/JSX/TSX
            -- with full type checking, refactoring, and auto-imports.
            --------------------------------------------------------------------
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("ts_ls")

            --------------------------------------------------------------------
            -- Python (linting + formatting): ruff
            -- Extremely fast Python linter and formatter (replaces flake8,
            -- isort, black, pyflakes, etc.). Runs as an LSP server here.
            -- Formatting is routed to ruff in none-ls.lua's filter.
            --------------------------------------------------------------------
            vim.lsp.config("ruff", {
                capabilities = capabilities,
                root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
            })
            vim.lsp.enable("ruff")

            --------------------------------------------------------------------
            -- Python (type checking): ty
            -- Astral's type checker (early preview). Complements ruff by
            -- providing type diagnostics.
            --------------------------------------------------------------------
            vim.lsp.config("ty", {
                capabilities = capabilities,
                root_markers = { "pyproject.toml", ".git" },
                on_attach = function(client, bufnr)
                    -- ty sends unused bindings as hint-severity (4) diagnostics.
                    -- These don't appear in `ty check` CLI output and are noise
                    -- in the editor, so we strip them whenever diagnostics change.
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

            --------------------------------------------------------------------
            -- C / C++: clangd
            -- LLVM's language server. Provides completion, diagnostics,
            -- include management, and clang-tidy integration.
            --   --background-index     : index the project in the background
            --   --clang-tidy           : enable clang-tidy diagnostics
            --   --header-insertion=iwyu : auto-insert headers (include-what-you-use style)
            --   --completion-style=detailed : show full signature in completions
            --------------------------------------------------------------------
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

            --------------------------------------------------------------------
            -- TOML: taplo
            -- LSP server, formatter, and validator for TOML files.
            -- Provides schema-aware completion (e.g. Cargo.toml, pyproject.toml)
            -- and native formatting (routed to in none-ls.lua's filter).
            --------------------------------------------------------------------
            vim.lsp.config("taplo", {
                capabilities = capabilities,
            })
            vim.lsp.enable("taplo")

            --------------------------------------------------------------------
            -- Typst: tinymist
            -- Full-featured LSP for Typst (replaced typst-lsp). Provides
            -- completion, diagnostics, formatting, preview, and symbol info.
            -- Native formatting is routed to in none-ls.lua's filter.
            --------------------------------------------------------------------
            vim.lsp.config("tinymist", {
                capabilities = capabilities,
            })
            vim.lsp.enable("tinymist")

            --------------------------------------------------------------------
            -- YAML: yamlls (Red Hat)
            -- Schema-aware YAML language server. Provides validation and
            -- completion for common formats (docker-compose, GitHub Actions,
            -- Kubernetes manifests, etc.) via SchemaStore integration.
            --------------------------------------------------------------------
            vim.lsp.config("yamlls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("yamlls")

            --------------------------------------------------------------------
            -- Bash / Shell: bashls
            -- Language server for Bash. Provides completion, hover docs,
            -- diagnostics, and go-to-definition for shell scripts.
            -- Pairs well with shellcheck (linter) and shfmt (formatter)
            -- configured in none-ls.lua.
            --------------------------------------------------------------------
            vim.lsp.config("bashls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("bashls")

            --------------------------------------------------------------------
            -- Nix: nixd
            -- Feature-rich Nix LSP with full evaluation support. Provides
            -- completion, diagnostics, go-to-definition, and hover docs.
            -- Configured with Home Manager option completion so typing e.g.
            -- "programs." completes with all available HM options.
            -- Formatting is handled by nixfmt via none-ls, not nixd.
            --------------------------------------------------------------------
            vim.lsp.config("nixd", {
                capabilities = capabilities,
                settings = {
                    nixd = {
                        nixpkgs = { expr = "import <nixpkgs> {}" },
                        options = {
                            home_manager = {
                                expr = '(builtins.getFlake "'
                                    .. os.getenv("HOME")
                                    .. '/.config/home-manager").homeConfigurations.'
                                    .. os.getenv("USER")
                                    .. ".options",
                            },
                        },
                    },
                },
            })
            vim.lsp.enable("nixd")

            --------------------------------------------------------------------
            -- Shared keymaps: applied to every buffer when an LSP server attaches.
            -- These supplement the built-in keymaps listed in the header.
            --------------------------------------------------------------------
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("my.lsp.keymaps", { clear = true }),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set(
                        "n",
                        "gd",
                        vim.lsp.buf.definition,
                        vim.tbl_extend("force", opts, { desc = "Go to definition" })
                    )
                    vim.keymap.set(
                        "n",
                        "gD",
                        vim.lsp.buf.declaration,
                        vim.tbl_extend("force", opts, { desc = "Go to declaration" })
                    )
                    vim.keymap.set(
                        "n",
                        "gl",
                        vim.diagnostic.open_float,
                        vim.tbl_extend("force", opts, { desc = "Show diagnostic float" })
                    )
                    vim.keymap.set("n", "<leader>li", function()
                        vim.lsp.buf.code_action({
                            apply = true,
                            context = {
                                only = { "source.organizeImports.ruff" },
                                diagnostics = {},
                            },
                        })
                    end, vim.tbl_extend("force", opts, { desc = "Organise Python imports" }))
                end,
            })
        end,
    },
}
