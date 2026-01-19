local keymap = vim.keymap.set

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▎" },
				topdelete = { text = "▎" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
				virt_text = true,
				virt_text_pos = "eol",
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"NvimTree",
					"Trouble",
					"lazy",
					"gitcommit",
					"gitrebase",
					"markdown",
					"checkhealth",
					"lspinfo",
				},
				buftypes = { "terminal", "nofile", "prompt" },
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			view = { side = "right", width = 36 },
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = { enable = true, update_root = false },
			renderer = {
				highlight_git = true,
				group_empty = true,
				indent_markers = { enable = true },
			},
			actions = { open_file = { quit_on_open = false } },
			filters = { dotfiles = false, custom = { "^.git$" } },
		},
		config = function(_, opts)
			keymap("n", "<leader>nn", function()
				vim.cmd("NvimTreeToggle")
			end, {})
			require("nvim-tree").setup(opts)
		end,
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
