-- visual-whitespace.nvim: Show whitespace characters in visual mode selections
-- https://github.com/mcauley-penney/visual-whitespace.nvim
return {
    "mcauley-penney/visual-whitespace.nvim",
    commit = "d1f8889",
    config = true,
    event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
    opts = {},
}
