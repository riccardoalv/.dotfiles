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
			require("treesitter").setup({
				highlight = {
					enable = true,
					use_languagetree = true,
				},
				textobjects = {
					select = {
						enable = true,
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

			local parsers = require("nvim-treesitter.parsers")

			function _G.ensure_treesitter_language_installed()
				local lang = parsers.get_buf_lang()
				if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
					vim.schedule_wrap(function()
						vim.cmd("TSInstallSync " .. lang)
						vim.cmd([[e!]])
					end)()
				end
			end

			vim.cmd([[autocmd FileType * :lua ensure_treesitter_language_installed()]])

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
