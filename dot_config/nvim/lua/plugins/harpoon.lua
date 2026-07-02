-- harpoon: Quick-switch between a small set of pinned files
-- https://github.com/ThePrimeagen/harpoon
-- Keys: <leader>jj = add file     | <leader>jf = toggle menu
--        [h         = prev file    | ]h         = next file
return {
  "ThePrimeagen/harpoon",
  commit = "87b1a35",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>jj", function()
      harpoon:list():add()
    end, { desc = "Add file to harpoon list" })

    vim.keymap.set("n", "<leader>jf", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle harpoon quick menu" })

    vim.keymap.set("n", "[h", function()
      harpoon:list():prev()
    end, { desc = "Go to previous harpoon file" })

    vim.keymap.set("n", "]h", function()
      harpoon:list():next()
    end, { desc = "Go to next harpoon file" })
  end,
}
