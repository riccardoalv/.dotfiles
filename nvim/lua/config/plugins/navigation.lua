local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

return {
	"christoomey/vim-tmux-navigator",

	{
		"ThePrimeagen/harpoon",
		config = function()
			local status2, harpoon = pcall(require, "harpoon")
			if not status2 then
				return
			end

			harpoon.setup()

			keymap("n", "<leader><leader>", ':lua require("harpoon.mark").add_file()<cr>', opts)
			keymap("n", "<leader><space>", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
			keymap("n", "<c-l>", ':lua require("harpoon.ui").nav_next()<cr>', {})
			keymap("n", "<c-h>", ':lua require("harpoon.ui").nav_prev()<cr>', {})
			keymap("n", "<f1>", ':lua require("harpoon.ui").nav_file(1)<cr>', opts)
			keymap("n", "<f2>", ':lua require("harpoon.ui").nav_file(2)<cr>', opts)
			keymap("n", "<f3>", ':lua require("harpoon.ui").nav_file(3)<cr>', opts)
			keymap("n", "<f4>", ':lua require("harpoon.ui").nav_file(4)<cr>', opts)
			keymap("n", "<f5>", ':lua require("harpoon.ui").nav_file(5)<cr>', opts)
			keymap("n", "<f6>", ':lua require("harpoon.ui").nav_file(6)<cr>', opts)
			keymap("n", "<f7>", ':lua require("harpoon.ui").nav_file(7)<cr>', opts)
			keymap("n", "<f8>", ':lua require("harpoon.ui").nav_file(8)<cr>', opts)
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
