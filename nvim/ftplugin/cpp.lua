local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.o.makeprg = "g++ -g -O2 -Wall -std=gnu++17 '%'"

keymap("n", "<f11>", "<cmd>w<cr><cmd>make<cr>", opts)
keymap("n", "<f12>", "<cmd>! ./a.out < '%:h/input.txt'<cr>", opts)
