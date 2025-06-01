vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "


vim.filetype.add({
  pattern = {
    [".*%.yaml%.tmpl"] = "yaml",
    [".*%.toml%.tmpl"] = "toml",
    [".*%.sh%.tmpl"] = "sh",
  },
})
