vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.makeprg = "g++ -std=c++20 -O2 -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS % -o %< && time ./%< < %<.txt"

vim.o.splitright = true

vim.keymap.set("n", "<F5>", function()
	vim.cmd("write")

	local cmd = vim.fn.expandcmd(vim.bo.makeprg)

	vim.cmd("silent! bd! term://*")

	vim.cmd("vsplit term://" .. cmd)

	vim.cmd("wincmd p")
end)

vim.keymap.set("i", "(", "()<Left>", { noremap = true })
vim.keymap.set("i", "[", "[]<Left>", { noremap = true })
vim.keymap.set("i", "{", "{}<Left>", { noremap = true })
vim.keymap.set("i", '"', '""<Left>', { noremap = true })
