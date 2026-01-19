local set_var = vim.api.nvim_set_var
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
	{
		"tpope/vim-repeat",
	},
	{
		"junegunn/vim-easy-align",
		config = function()
			keymap("x", "ga", "<Plug>(EasyAlign)", opts)
			keymap("n", "ga", "<Plug>(EasyAlign)", opts)
		end,
	},

	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
			keymap("n", "<leader-c>", require("telescope").extensions.neoclip.default)
		end,
	},
}
