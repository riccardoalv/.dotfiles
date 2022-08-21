local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- leader keys
vim.api.nvim_set_var("mapleader", ",")
vim.api.nvim_set_var("localmapleader", [[\]])

-- toggle theme
keymap("n", "<leader>cs", ":lua require('onedark').toggle()<cr>", opts)

-- select all
keymap("n", "aa", "ggVG", opts)

-- next/previous buffer/quickfix list
keymap("n", "<space>n", ":bn<cr>", opts)
keymap("n", "<space>p", ":bp<cr>", opts)
keymap("n", "cn", ":cn<cr>", opts)
keymap("n", "cp", ":cp<cr>", opts)

-- set system clipboard
keymap("n", "cc", ":lua StatusClipboard()<cr>", opts)

-- repeat last command
keymap("n", "<A-m>", "@:", opts)

-- Terminal Esc
keymap("t", "<esc>", [[<C-\><C-n>]], opts)

-- Disable highlight
keymap("n", "<A-h>", ":noh<cr>", opts)

-- copy
keymap("n", "Y", "y$", opts)

-- text-objectis quotes
keymap("o", "ix", [[i']], opts)
keymap("o", "iq", [[i"]], opts)
keymap("o", "ax", [[a']], opts)
keymap("o", "aq", [[a!]], opts)

-- formatting
keymap("n", "<A-j>", ":m .+1<cr>==", opts)
keymap("n", "<A-k>", ":m .-2<cr>==", opts)
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", opts)
keymap("n", "<space><tab>", "i<cr><esc>", opts)
keymap("n", "<space><space>", "i<space><esc>", opts)
keymap("n", "<c-j>", "o<esc>", opts)
keymap("n", "<c-k>", "O<esc>", opts)
keymap("i", "<M-space>", "<BS>", opts)
keymap("i", "<M-w>", "<c-w>", opts)

-- Shiftwidth
keymap("n", "<A-,>", "<ap", opts)
keymap("n", "<A-.>", ">ap", opts)

-- Fast editing and reloading of vimrc configs
keymap("n", "<leader>e", ":vs " .. GitDir() .. "/.vim<cr>", opts)

-- Switch CWD to the directory of the open buffer
keymap("n", "cd", ":cd %:p:h<cr>:pwd<cr>", opts)
