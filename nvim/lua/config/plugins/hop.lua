local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
	"christoomey/vim-tmux-navigator",

	{
		"smoka7/hop.nvim",
		config = function()
			require("hop").setup()
			keymap("n", "<space>w", ":HopWord<cr>", opts)
		end,
	},
}
