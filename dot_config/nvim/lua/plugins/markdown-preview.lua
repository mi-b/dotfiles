if require("utils").skip_if_windows("markdown-preview") then
  return {}
end

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_browser = "/usr/bin/firefox"

    vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
    vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Markdown preview stop" })
    vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { desc = "Markdown preview toggle" })
  end,
}
