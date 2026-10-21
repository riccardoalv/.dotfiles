return {
	"nvim-treesitter/nvim-treesitter",

	branch = "main",
	build = ":TSUpdate",
	lazy = false,

	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"tronikelis/ts-autotag.nvim",
		"folke/ts-comments.nvim",

		{
			"Wansmer/treesj",

			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},

			opts = {
				use_default_keymaps = true,
				max_join_length = 150,
			},
		},
	},

	opts = function()
		local max_filesize = 300 * 1024

		local function is_big(buf)
			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))

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

				disable = function(_, buf)
					return is_big(buf)
				end,

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

			autotag = {
				enable = true,
			},
		}
	end,

	config = function(_, opts)
		require("ts-comments").setup({})

		require("ts-autotag").setup({
			live_rename = true,
		})

		require("nvim-treesitter").setup()
		require("nvim-treesitter").install(opts.ensure_installed)

		-- a branch main não liga highlight/indent sozinha: precisa de vim.treesitter.start()
		vim.treesitter.language.register("matlab", "octave")

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function(args)
				local buf = args.buf
				local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)

				if not lang or opts.highlight.disable(lang, buf) then
					return
				end

				if not vim.treesitter.language.add(lang) then
					if opts.auto_install and vim.list_contains(require("nvim-treesitter").get_available(), lang) then
						require("nvim-treesitter").install(lang)
					end
					return
				end

				vim.treesitter.start(buf, lang)

				if not opts.indent.disable(lang, buf) then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		require("nvim-treesitter-textobjects").setup({
			select = {
				enable = true,
				lookahead = true,

				include_surrounding_whitespace = false,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",

					["ac"] = "@class.outer",
					["ic"] = "@class.inner",

					["al"] = "@loop.outer",
					["il"] = "@loop.inner",

					["ai"] = "@conditional.outer",
					["ii"] = "@conditional.inner",

					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
				},
			},

			move = {
				enable = true,
				set_jumps = true,

				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
				},

				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
				},
			},

			swap = {
				enable = true,

				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},

				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		})

		local repeatable_move = require("nvim-treesitter-textobjects.repeatable_move")

		vim.keymap.set({ "n", "x", "o" }, ";", repeatable_move.repeat_last_move_next)

		vim.keymap.set({ "n", "x", "o" }, ",", repeatable_move.repeat_last_move_previous)
	end,
}
