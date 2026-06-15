-- NOTE: Treesitter crashes with Windows for pretty much all plugins! Maybe it is an issue with the compiler: https://github.com/nvim-treesitter/nvim-treesitter/issues/5264

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local is_windows = require("utils").is_windows()
    local treesitter = require("nvim-treesitter")
    local installed = treesitter.get_installed("parsers")

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang or not vim.list_contains(installed, lang) then
          if not is_windows and lang then
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
