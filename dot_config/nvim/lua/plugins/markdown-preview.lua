if require("utils").skip_if_windows("markdown-preview") then
  return {}
end

return {
  "iamcco/markdown-preview.nvim",
  version = "^0.0.10",
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

    vim.keymap.set("n", "<leader>Mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
    vim.keymap.set("n", "<leader>Ms", ":MarkdownPreviewStop<CR>", { desc = "Markdown preview stop" })
    vim.keymap.set("n", "<leader>Mt", ":MarkdownPreviewToggle<CR>", { desc = "Markdown preview toggle" })
  end,
}
