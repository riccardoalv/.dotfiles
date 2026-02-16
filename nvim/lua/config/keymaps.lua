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

-- movement
keymap("n", "0", "^", opts)

-- next/previous buffer/quickfix list
keymap("n", "<space>n", ":bn<cr>", opts)
keymap("n", "<space>p", ":bp<cr>", opts)
keymap("n", "cn", ":cn<cr>", opts)
keymap("n", "cp", ":cp<cr>", opts)

-- repeat last command
keymap("n", "<A-m>", "@:", opts)

-- Esc
keymap("t", "<esc>", [[<C-\><C-n>]], opts)
keymap("t", "<C-c>", [[<C-\><C-n>]], opts)
keymap("i", "<C-c>", "<esc>", opts)
keymap("n", "<C-c>", "<esc>", opts)
keymap("x", "<C-c>", "<esc>", opts)
keymap("n", "<C-c>", "<esc>", opts)
keymap("v", "<C-c>", "<esc>", opts)

-- Disable highlight
keymap("n", "<leader>h", ":noh<cr>", opts)

-- copy
keymap({ "n", "v" }, "+", '"+', opts)
keymap("n", "Y", '"+y$', opts)

-- text-objectis quotes
keymap("o", "ix", [[i']], opts)
keymap("o", "iq", [[i"]], opts)
keymap("o", "ax", [[a']], opts)
keymap("o", "aq", [[a!]], opts)

-- resize splits
keymap("n", "<A-0>", "<cmd>res -1<cr>", opts)
keymap("n", "<A-->", "<cmd>res +1<cr>", opts)
keymap("n", "<A-,>", "<cmd>vertical res -1<cr>", opts)
keymap("n", "<A-.>", "<cmd>vertical res +1<cr>", opts)

-- Add undo break-points
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ";", ";<c-g>u", opts)

-- Switch CWD to the directory of the open buffer
keymap("n", "cd", ":cd %:p:h<cr>:pwd<cr>", opts)
