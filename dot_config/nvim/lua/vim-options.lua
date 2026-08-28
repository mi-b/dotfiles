vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

vim.filetype.add({
    pattern = {
        [".*%.yaml%.tmpl"] = "yaml",
        [".*%.toml%.tmpl"] = "toml",
        [".*%.sh%.tmpl"] = "sh",
    },
})
