local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local status, telescope = pcall(require, "telescope")
if not status then
	return
end

-- Telescope.nvim
local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		find_command = { "rg", "--ignore", "--hidden", "--files", GitDir() },
		winblend = 20,
		mappings = {
			n = {
				["<C-q>"] = actions.send_to_qflist,
				["d"] = actions.delete_buffer,
			},
			i = {
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
	extensions = {
		["ui-select"] = require("telescope.themes").get_dropdown({}),
	},
})

telescope.load_extension("ui-select")

vim.cmd([[au FileType TelescopePrompt nmap <buffer> v <c-v>]])
vim.cmd([[au FileType TelescopePrompt nmap <buffer> x <c-x>]])

keymap("n", "<leader>f", ':lua require("telescope.builtin").git_files()<cr>', opts)
keymap("n", "<leader>g", ':lua require("telescope.builtin").live_grep()<cr>', opts)
keymap(
	"n",
	"<c-p>",
	':lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>',
	opts
)
keymap("n", "<leader>s", ':lua require("telescope.builtin").git_status()<cr>', opts)
keymap("n", "<A-b>", ':lua require("telescope.builtin").git_branches()<cr>', opts)
keymap("n", "<A-t>", ':lua require("telescope.builtin").treesitter()<cr>', opts)
keymap("n", "<A-q>", ':lua require("telescope.builtin").quickfix()<cr>', opts)
keymap(
	"n",
	"<space>b",
	':lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))<cr>',
	opts
)
keymap("n", "<space>ca", ":lua vim.lsp.buf.code_action()<cr>", opts)
