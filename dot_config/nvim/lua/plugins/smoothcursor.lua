-- SmoothCursor.nvim: Animated cursor position indicator in the sign column
-- https://github.com/gen740/SmoothCursor.nvim
return {
    "gen740/SmoothCursor.nvim",
    config = function()
        require("smoothcursor").setup()
    end,
}
