-- hardtime.nvim: Break bad Vim habits by restricting repeated key presses
-- https://github.com/m4xshen/hardtime.nvim
return {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        disabled_keys = {
            ["<Up>"] = {},
            ["<Down>"] = {},
            ["<Left>"] = {},
            ["<Right>"] = {},
        },
        disable_mouse = false,
        max_count = 5,
        restriction_mode = "hint",
    },
}
