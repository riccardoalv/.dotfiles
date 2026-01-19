return {
	"ThePrimeagen/refactoring.nvim",
	depedencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local keymap = vim.keymap.set

		require("telescope").load_extension("refactoring")
		keymap("v", "<space>rt", require("telescope").extensions.refactoring.refactors, { noremap = true })

		keymap("n", "<space>rp", function()
			require("refactoring").debug.printf({ below = false })
		end, { noremap = true })

		keymap("v", "<space>rp", require("refactoring").debug.print_var)
		keymap("n", "<space>rc", require("refactoring").debug.cleanup)

		keymap("x", "<leader>re", ":Refactor extract ")
		keymap("x", "<leader>rf", ":Refactor extract_to_file ")

		keymap("x", "<leader>rv", ":Refactor extract_var ")

		keymap({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

		keymap("n", "<leader>rI", ":Refactor inline_func")

		keymap("n", "<leader>rb", ":Refactor extract_block")
		keymap("n", "<leader>rbf", ":Refactor extract_block_to_file")
	end,
}
