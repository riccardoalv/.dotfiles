local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Toggle mouse
function ToggleMouse()
  if vim.o.mouse == "a" then
    vim.o.mouse = ""
    vim.notify("Mouse OFF")
  else
    vim.o.mouse = "a"
    vim.notify("Mouse ON")
  end
end

keymap("n", "<space>m", ToggleMouse)

-- Toggle clipboard
function ToggleClipboard()
  if vim.o.clipboard == "unnamedplus" then
    vim.o.clipboard = ""
    vim.notify("Clipboard OFF")
  else
    vim.o.clipboard = "unnamedplus"
    vim.notify("Clipboard ON")
  end
end

keymap("n", "<space>c", ToggleClipboard)

-- movement
keymap("n", "0", "^", opts)

-- select all
keymap("n", "aa", "ggVG", opts)

-- next/previous buffer/quickfix list
keymap("n", "<space>n", ":bn<cr>", opts)
keymap("n", "<space>p", ":bp<cr>", opts)
keymap("n", "cn", ":cn<cr>", opts)
keymap("n", "cp", ":cp<cr>", opts)

-- resize splits
vim.fn.Submode("resize", "<c-w>+", "+", "<c-w>+")
vim.fn.Submode("resize", "<c-w>-", "-", "<c-w>-")
vim.fn.Submode("resize", "<c-w>>", ">", "<c-w>>")
vim.fn.Submode("resize", "<c-w><", "<", "<c-w><")

-- repeat last command
keymap("n", "<A-m>", "@:", opts)

-- Esc
keymap("t", "<esc>", [[<C-\><C-n>]], opts)
keymap("t", "<C-c>", [[<C-\><C-n>]], opts)
keymap("n", "<C-c>", "<esc>", opts)
keymap("x", "<C-c>", "<esc>", opts)
keymap("n", "<C-c>", "<esc>", opts)
keymap("v", "<C-c>", "<esc>", opts)

-- Disable highlight
keymap("n", "<leader>h", ":noh<cr>", opts)

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
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", opts)
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", opts)
keymap("n", "<space><tab>", "i<cr><esc>", opts)
keymap("n", "<space><space>", "i<space><esc>", opts)

-- Shiftwidth
keymap("n", "<A-,>", "<ap", opts)
keymap("n", "<A-.>", ">ap", opts)

-- Fast editing and reloading of vimrc configs
keymap("n", "<leader>e", "<cmd>vs " .. git_dir .. "/.nvim.lua<cr>")

-- Add undo break-points
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ";", ";<c-g>u", opts)

-- Switch CWD to the directory of the open buffer
keymap("n", "cd", ":cd %:p:h<cr>:pwd<cr>", opts)
