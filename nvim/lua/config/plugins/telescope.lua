return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"debugloop/telescope-undo.nvim",
		"nvim-lua/plenary.nvim",
		"ThePrimeagen/git-worktree.nvim",
	},

	cmd = {
		"Telescope",
	},
	keys = {
		{
			"<leader>f",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "Telescope: git files",
		},
		{
			"<C-p>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope: find files",
		},
		{
			"<leader>s",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "Telescope: git status",
		},
		{
			"<A-b>",
			function()
				require("telescope.builtin").git_branches()
			end,
			desc = "Telescope: git branches",
		},
		{
			"<A-q>",
			function()
				require("telescope.builtin").quickfix()
			end,
			desc = "Telescope: quickfix",
		},
		{
			"<space>b",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Telescope: buffers",
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope: live grep",
		},
		{
			"<leader>d",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "Telescope: diagnostics",
		},
		{
			"<leader>t",
			function()
				require("telescope.builtin").lsp_workspace_symbols()
			end,
			desc = "Telescope: LSP symbols",
		},
		{
			"<A-t>",
			function()
				require("telescope.builtin").treesitter()
			end,
			desc = "Telescope: treesitter",
		},
		{
			"<leader>u",
			function()
				require("telescope").extensions.undo.undo()
			end,
			desc = "Telescope: undo tree",
		},
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				winblend = 10,
				layout_strategy = "flex",
				layout_config = {
					height = 0.90,
					width = 0.90,
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
				dynamic_preview_title = true,
				path_display = { "smart" },

				mappings = {
					n = {
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["d"] = actions.delete_buffer,
						["<C-c>"] = actions.close,
						["v"] = actions.select_vertical,
						["x"] = actions.select_horizontal,
					},
					i = {
						["<C-q>"] = actions.send_to_qflist,
						["<C-c>"] = false,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},

			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},

			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
				},
			},
		})

		pcall(telescope.load_extension, "undo")
		pcall(telescope.load_extension, "git_worktree")
	end,
}
