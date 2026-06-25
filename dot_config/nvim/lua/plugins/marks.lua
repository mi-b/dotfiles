return {
  "chentoast/marks.nvim",
  commit = "f353e8c",
  event = "VeryLazy",
  config = function()
    require 'marks'.setup {
      mappings = {
        set_next = "<leader>ms",
        prev = "<leader>mp",
        next = "<leader>mn",
        preview = "<leader>mm",
        delete_buf = "<leader>md"
      }
    }
  end
}
