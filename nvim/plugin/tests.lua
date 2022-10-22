local status, neotest = pcall(require, "neotest")
if not status then
	return
end

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

neotest.setup({
	adapters = {
		require("neotest-python"),
		require("neotest-jest"),
	},
})

keymap("n", "<f12>", [[<cmd>lua require("neotest").run.run()<cr>]], opts)
