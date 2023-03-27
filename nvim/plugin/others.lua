local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local set_var = vim.api.nvim_set_var

-- octo.nvim
require("octo").setup()

-- nvim-surround
require("nvim-surround").setup()

-- vim-easy-align
keymap("x", "ga", "<Plug>(EasyAlign)", opts)
keymap("n", "ga", "<Plug>(EasyAlign)", opts)

-- vim-argwrap
keymap("n", "<leader>a", "<cmd>ArgWrap<cr>", opts)

-- Gitsigns
local status, gitsigns = pcall(require, "gitsigns")
if not status then
	return
end
gitsigns.setup({ current_line_blame = true })

-- neoclip
local status1, neoclip = pcall(require, "neoclip")
if not status1 then
	return
end
neoclip.setup()
keymap("n", "<leader>c", [[:Telescope neoclip ]], {})
keymap("n", "<A-y>", ':lua require("telescope").extensions.neoclip.default()<cr>', opts)

-- harpoon
local status2, harpoon = pcall(require, "harpoon")
if not status2 then
	return
end

harpoon.setup()

keymap("n", "<leader>n", ':lua require("harpoon.mark").add_file()<cr>', opts)
keymap("n", "<leader><space>", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
keymap("n", "<f1>", ':lua require("harpoon.ui").nav_file(1)<cr>', opts)
keymap("n", "<f2>", ':lua require("harpoon.ui").nav_file(2)<cr>', opts)
keymap("n", "<f3>", ':lua require("harpoon.ui").nav_file(3)<cr>', opts)
keymap("n", "<f4>", ':lua require("harpoon.ui").nav_file(4)<cr>', opts)

-- LuaSnip
vim.cmd([[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>']])
vim.cmd([[inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>]])

vim.cmd([[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]])
vim.cmd([[snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>]])

require("luasnip.loaders.from_vscode").lazy_load()

-- Submode
set_var("submode_keep_leaving_key", 1)
set_var("submode_timeout", 0)

vim.cmd([[
fun! Submode_alias(map, key, exec, mode)
  call submode#enter_with('mode', a:mode, '', a:map, a:exec)
  call submode#map('mode',        a:mode, '', a:key, a:exec)
endf
]])

-- Hop.nvim
require("hop").setup()
keymap("n", "<space>w", ":HopWord<cr>", opts)

-- toggle term

require("toggleterm").setup({
	open_mapping = [[<A-i>]],
	highlights = {
		FloatBorder = {
			guibg = "NONE",
		},
	},
	direction = "float",
	float_opts = {
		border = "rounded",
		winblend = 10,
		width = math.ceil(0.55 * vim.o.columns),
		height = math.ceil(0.55 * vim.o.lines),
	},
})

-- nvim-tree.lua
local nvim_tree = require("nvim-tree")
if not status then
	return
end

nvim_tree.setup({ view = { side = "right" } })
keymap("n", "<leader>nn", ":NvimTreeToggle<cr>", opts)

-- Matchup
vim.g.loaded_matchit = 1

-- refactoring
require("telescope").load_extension("refactoring")

keymap(
	"v",
	"<space>rt",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)

keymap("n", "<space>rp", ":lua require('refactoring').debug.printf({below = false})<CR>", { noremap = true })

keymap("v", "<space>rp", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
keymap("n", "<space>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

-- colorizer
local colorizer = require("colorizer")
if not status then
	return
end
colorizer.setup()

-- indent blankline
vim.opt.list = true
require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = true,
	buftype_exclude = { "terminal" },
})

-- Nvim Comment
require("nvim_comment").setup()
