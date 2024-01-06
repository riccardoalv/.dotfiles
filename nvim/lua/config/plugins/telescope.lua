return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"debugloop/telescope-undo.nvim",
	},

	config = function()
		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		telescope = require("telescope")

		-- Telescope.nvim
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				mappings = {
					n = {
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["d"] = actions.delete_buffer,
					},
					i = {
						["<C-q>"] = actions.send_to_qflist,
					},
				},
			},
			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
				},
			},
		})

		telescope.load_extension("undo")
		telescope.load_extension("notify")
		telescope.load_extension("git_worktree")

		vim.cmd([[au FileType TelescopePrompt nmap <buffer> v <c-v>]])
		vim.cmd([[au FileType TelescopePrompt nmap <buffer> x <c-x>]])

		keymap("n", "<leader>f", require("telescope.builtin").git_files)
		keymap("n", "<c-p>", require("telescope.builtin").find_files)
		keymap("n", "<leader>s", require("telescope.builtin").git_status)
		keymap("n", "<A-b>", require("telescope.builtin").git_branches)
		keymap("n", "<A-q>", require("telescope.builtin").quickfix)
		keymap("n", "<space>b", require("telescope.builtin").buffers)
		keymap("n", "<leader>g", require("telescope.builtin").live_grep)
		keymap("n", "<A-t>", require("telescope.builtin").treesitter)
		keymap("n", "<leader>u", require("telescope").extensions.undo.undo)
	end,
}
