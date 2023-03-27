local o = vim.o

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- nvim tree sitter
treesitter.setup({
	highlight = {
		enable = true,
		disable = {},
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
	matchup = {
		enable = true,
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
