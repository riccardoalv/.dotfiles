local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

return {

	{
		"ThePrimeagen/harpoon",
		config = function()
			local status2, harpoon = pcall(require, "harpoon")
			if not status2 then
				return
			end

			harpoon.setup()

			keymap("n", "<leader>n", ':lua require("harpoon.mark").add_file()<cr>', opts)
			keymap("n", "<leader><space>", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
			keymap("n", "<f1>", ':lua require("harpoon.ui").nav_file(1)<cr>', opts)
			keymap("n", "<f2>", ':lua require("harpoon.ui").nav_file(2)<cr>', opts)
			keymap("n", "<f3>", ':lua require("harpoon.ui").nav_file(3)<cr>', opts)
			keymap("n", "<f4>", ':lua require("harpoon.ui").nav_file(4)<cr>', opts)
		end,
	},

	{
		"phaazon/hop.nvim",
		config = function()
			require("hop").setup()
			keymap("n", "<space>w", ":HopWord<cr>", opts)
		end,
	},

	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
			keymap("n", "<leader>c", [[:Telescope neoclip ]], {})
			keymap("n", "<A-y>", ':lua require("telescope").extensions.neoclip.default()<cr>', opts)
		end,
	},

	"ThePrimeagen/git-worktree.nvim",

	{
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
	},
}
