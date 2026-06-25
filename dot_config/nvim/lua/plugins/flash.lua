-- flash.nvim: Navigate anywhere with search labels and treesitter integration
-- https://github.com/folke/flash.nvim
-- Keys: <leader>s = jump to match, <leader>S = select treesitter node,
--        r = remote flash (operator), R = search treesitter node, <C-s> = toggle in / search
return {
  "folke/flash.nvim",
  version = "^2.0.0",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>s", function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Jump to any match on screen" },
    { "<leader>S", function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Select treesitter node" },
    { "r",         function() require("flash").remote() end,            mode = "o",                desc = "Remote flash (operator pending)" },
    { "R",         function() require("flash").treesitter_search() end, mode = { "o", "x" },       desc = "Search and select treesitter node" },
    { "<C-s>",     function() require("flash").toggle() end,            mode = "c",                desc = "Toggle flash in search mode" },
  },
}
