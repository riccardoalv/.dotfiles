return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			show_end_of_buffer = true,

			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = {},
						warnings = {},
						hints = {},
						information = {},
					},
					underlines = {
						errors = { "undercurl" },
						warnings = { "undercurl" },
						hints = { "undercurl" },
						information = { "undercurl" },
					},
				},
				blink_cmp = { style = "bordered" },
				telescope = { enabled = true },
				gitsigns = true,
				nvimtree = true,
				indent_blankline = { enabled = true },
				harpoon = true,
				hop = true,
				lsp_saga = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
