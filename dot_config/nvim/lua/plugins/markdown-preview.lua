-- markdown-preview.nvim: Live markdown preview in the browser
-- https://github.com/iamcco/markdown-preview.nvim
-- Keys: <leader>Mp = start preview, <leader>Ms = stop, <leader>Mt = toggle
if require("utils").skip_if_windows("markdown-preview") then
  return {}
end

return {
  "iamcco/markdown-preview.nvim",
  version = "^0.0.10",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_theme = "dark"

    vim.keymap.set("n", "<leader>Mp", ":MarkdownPreview<CR>", { desc = "Start markdown preview in browser" })
    vim.keymap.set("n", "<leader>Ms", ":MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })
    vim.keymap.set("n", "<leader>Mt", ":MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
  end,
}
