local map = vim.keymap.set
local opts = { noremap = true }

-- No clipboard override with x, s, c, Del and visual p
map("n", "x", '"_x', opts)
map("n", "X", '"_X', opts)
map({ "n", "v" }, "s", '"_s', opts)
map({ "n", "v" }, "S", '"_S', opts)


-- Yank to / paste from system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard (before)" })

map({ "n", "v" }, "c", '"_c', opts)
map({ "n", "v" }, "C", '"_C', opts)
map({ "n", "v" }, "<Del>", '"_x', opts)
map("v", "p", "pgvy", opts)

-- Clear search highlighting on Esc
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })

-- Move lines up/down with Alt-j/k
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centred when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centred)" })

-- Keep cursor centred on search next/prev
map("n", "n", "nzzzv", { desc = "Next search result (centred)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centred)" })

-- Join lines without cursor jumping
map("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })

-- Search and replace word under cursor
map("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- Search and replace word under cursor
map("n", "<leader>A", "ggVG", { desc = "Select everything in buffer" })
