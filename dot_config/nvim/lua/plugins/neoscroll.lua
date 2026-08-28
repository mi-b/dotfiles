-- neoscroll.nvim: Smooth scrolling animations for window movement
-- https://github.com/karb94/neoscroll.nvim
return {
    "karb94/neoscroll.nvim",
    cond = not (vim.env.SSH_TTY or vim.env.SSH_CLIENT),
    opts = {},
}
