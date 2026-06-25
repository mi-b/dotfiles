return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>jj", function()
      harpoon:list():add()
    end, { desc = "Add to harpoon list" })

    vim.keymap.set("n", "<leader>jf", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon list" })

    vim.keymap.set("n", "<S-h>", function()
      harpoon:list():prev()
    end, { desc = "Previous harpoon file" })

    vim.keymap.set("n", "<S-l>", function()
      harpoon:list():next()
    end, { desc = "Next harpoon file" })
  end,
}
