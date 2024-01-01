return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},

		config = function()
			local o = vim.o
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					use_languagetree = true,
				},
				auto_install = true,
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["il"] = "@loop.inner",
							["al"] = "@loop.outer",
							["ii"] = "@conditional.inner",
							["oi"] = "@conditional.outer",
						},
					},
				},
				autotag = {
					enable = true,
				},
			})

			o.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				patterns = {
					default = {
						"class",
						"function",
						"method",
						"for",
						"while",
						"if",
						"switch",
						"case",
					},
				},
			})
		end,
	},
}
