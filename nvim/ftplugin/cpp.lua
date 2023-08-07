local o = vim.o

o.expandtab = true
o.smarttab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.ai = true
o.si = true
o.wrap = false
o.syntax = true

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.o.makeprg = "g++ -x c++ -g -O2 -Wall -std=gnu++20 '%'"

keymap("i", "{<cr>", "{<cr><cr>}<up><tab>", opts)

keymap("n", "<f11>", "<cmd>w<cr><cmd>make<cr>", opts)
keymap("n", "<f12>", "<cmd>! ./a.out < '%:h/input.txt'<cr>", opts)
