return {
  "ThePrimeagen/harpoon",
  config = function()
    require("harpoon").setup({})
    vim.keymap.set(
      { "n", "v" },
      "<leader>jf",
      ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
      { desc = "Harpoon List" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>jj",
      ':lua require("harpoon.mark").add_file()<CR>',
      { desc = "Add to harpoon List" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<S-h>",
      ':lua require("harpoon.ui").nav_next()<CR>',
      { desc = "Next harpoon file." }
    )
    vim.keymap.set(
      { "n", "v" },
      "<S-l>",
      ':lua require("harpoon.ui").nav_prev()<CR>',
      { desc = "Pevious harpoon file." }
    )
  end,
}
