return {
	"ThePrimeagen/refactoring.nvim",
	lazy = false,
	dependencies = {
		"lewis6991/async.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local keymap = vim.keymap.set

		keymap("n", "<space>rp", function()
			return require("refactoring.debug").print_loc({ output_location = "above" })
		end, { desc = "Debug print location above", expr = true })

		keymap("x", "<space>rp", function()
			return require("refactoring.debug").print_var({ output_location = "below" })
		end, { desc = "Debug print var below", expr = true })

		keymap({ "n", "x" }, "<space>rc", function()
			return require("refactoring.debug").cleanup()
		end, { desc = "Cleanup debug prints", expr = true })

		keymap("x", "<leader>re", function()
			return require("refactoring").extract_func()
		end, { desc = "Extract Function", expr = true })

		keymap("x", "<leader>rf", function()
			return require("refactoring").extract_func_to_file()
		end, { desc = "Extract Function to File", expr = true })

		keymap("x", "<leader>rv", function()
			return require("refactoring").extract_var()
		end, { desc = "Extract Variable", expr = true })

		keymap({ "n", "x" }, "<leader>ri", function()
			return require("refactoring").inline_var()
		end, { desc = "Inline Variable", expr = true })

		keymap("n", "<leader>rI", function()
			return require("refactoring").inline_func()
		end, { desc = "Inline Function", expr = true })

		keymap({ "n", "x" }, "<leader>rs", function()
			require("refactoring").select_refactor()
		end, { desc = "Select Refactor" })
	end,
}
