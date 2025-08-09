return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"tronikelis/ts-autotag.nvim",
		"folke/ts-comments.nvim",
	},

	opts = function()
		local max_filesize = 300 * 1024
		local function is_big(buf)
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			return ok and stats and stats.size > max_filesize
		end

		return {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"bash",
				"json",
				"yaml",
				"toml",
				"html",
				"xml",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"svelte",
				"vue",
				"python",
				"ruby",
				"go",
				"regex",
			},
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				-- evita custo em arquivos grandes
				disable = function(_, buf)
					return is_big(buf)
				end,
				-- desliga regex extra para evitar highlight duplicado
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
				disable = function(lang, buf)
					if lang == "ruby" then
						return true
					end
					return is_big(buf)
				end,
			},

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
						["a="] = "@assignment.outer",
						["i="] = "@assignment.inner",
						["l="] = "@assignment.lhs",
						["r="] = "@assignment.rhs",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
			},

			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
				filetypes = {
					"html",
					"xml",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"tsx",
					"jsx",
					"svelte",
					"vue",
					"php",
					"markdown",
				},
			},
		}
	end,

	config = function(_, opts)
		require("ts-comments").setup({})
		require("ts-autotag").setup({
			live_rename = true,
		})

		require("nvim-treesitter.configs").setup(opts)
	end,
}
