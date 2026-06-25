vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.g.mapleader = " "


vim.filetype.add({
  pattern = {
    [".*%.yaml%.tmpl"] = "yaml",
    [".*%.toml%.tmpl"] = "toml",
    [".*%.sh%.tmpl"] = "sh",
  },
})
