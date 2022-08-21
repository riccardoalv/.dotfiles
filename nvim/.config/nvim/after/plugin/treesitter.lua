local o = vim.o

-- nvim tree sitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = {},
		use_languagetree = true,
		additional_vim_regex_highlighting = true,
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
	matchup = {
		enable = true,
	}
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

-- autotag
require("nvim-treesitter.configs").setup({ autotag = { enable = true } })

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
