-- NOTE: Treesitter crashes with Windows for pretty much all plugins! Maybe it is an issue with the compiler: https://github.com/nvim-treesitter/nvim-treesitter/issues/5264

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local is_windows = require("utils").is_windows()
    local treesitter = require("nvim-treesitter")
    local installed = treesitter.get_installed("parsers")
    local has_tree_sitter_cli = vim.fn.executable("tree-sitter") == 1

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Filetypes from UI plugins that have no treesitter parser.
    local ignore_ft = { alpha = true, lazy = true, neo = true, ["neo-tree"] = true }

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ignore_ft[ft] then return end
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang or not vim.list_contains(installed, lang) then
          if not is_windows and has_tree_sitter_cli and lang then
            treesitter.install(lang)
          end
          return
        end

        pcall(vim.treesitter.start, args.buf)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
