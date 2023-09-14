local set_var = vim.api.nvim_set_var
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

return {
  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup()
  end,
  },
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},

	{
		"junegunn/vim-easy-align",
		config = function()
			keymap("x", "ga", "<Plug>(EasyAlign)", opts)
			keymap("n", "ga", "<Plug>(EasyAlign)", opts)
		end,
	},

	{
		"FooSoft/vim-argwrap",
		config = function()
			keymap("n", "<leader>a", "<cmd>ArgWrap<cr>", opts)
		end,
	},

	{
		"kana/vim-submode",
		config = function()
			set_var("submode_keep_leaving_key", 1)
			set_var("submode_timeout", 0)

			vim.cmd([[
fun! Submode_alias(map, key, exec, mode)
  call submode#enter_with('mode', a:mode, '', a:map, a:exec)
  call submode#map('mode',        a:mode, '', a:key, a:exec)
endf
]])
		end,
	},
	"tpope/vim-repeat",

	{
		"ThePrimeagen/refactoring.nvim",
		config = function()
			require("telescope").load_extension("refactoring")

			keymap(
				"v",
				"<space>rt",
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
				{ noremap = true }
			)

			keymap(
				"n",
				"<space>rp",
				":lua require('refactoring').debug.printf({below = false})<CR>",
				{ noremap = true }
			)

			keymap("v", "<space>rp", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
			keymap("n", "<space>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
		end,
	},
}
