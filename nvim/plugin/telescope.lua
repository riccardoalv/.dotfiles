local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local dropdown = [[ require("telescope.themes").get_dropdown({}) ]]

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
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("undo")

local f = string.format

vim.cmd([[au FileType TelescopePrompt nmap <buffer> v <c-v>]])
vim.cmd([[au FileType TelescopePrompt nmap <buffer> x <c-x>]])

vim.cmd([[
call Alias("t", "Telescope")
]])

-- stylua: ignore start
keymap("n", "<leader>f", f(':lua require("telescope.builtin").git_files(%s)<cr>',    dropdown), opts)
keymap("n", "<c-p>",     f(':lua require("telescope.builtin").find_files(%s)<cr>',   dropdown), opts)
keymap("n", "<leader>s", f(':lua require("telescope.builtin").git_status(%s)<cr>',   dropdown), opts)
keymap("n", "<A-b>",     f(':lua require("telescope.builtin").git_branches(%s)<cr>', dropdown), opts)
keymap("n", "<A-q>",     f(':lua require("telescope.builtin").quickfix(%s)<cr>',     dropdown), opts)
keymap("n", "<space>b",  f(':lua require("telescope.builtin").buffers(%s)<cr>',      dropdown), opts)
keymap("n", "<leader>g", ':lua require("telescope.builtin").live_grep()<cr>',        opts)
keymap("n", "<A-t>",     ':lua require("telescope.builtin").treesitter()<cr>',       opts)
keymap("n", "<space>ca", ":lua vim.lsp.buf.code_action()<cr>",                       opts)
-- stylua: ignore end
