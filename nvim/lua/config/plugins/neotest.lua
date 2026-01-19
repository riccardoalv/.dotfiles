return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-vim-test",
	},
	keys = {
		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Neotest: Toggle output panel",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Neotest: Run nearest test",
		},
		{
			"<leader>t<space>",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Neotest: Run test file",
		},
	},
	opts = function()
		return {
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.ERROR,
			},
			output = {
				enabled = true,
				open_on_run = false,
				short = false,
			},
			output_panel = {
				enabled = true,
				open = "botright vsplit | vertical resize 80",
			},
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },

					runner = "pytest",

					python = function()
						local venv = vim.env.VIRTUAL_ENV
						if venv and #venv > 0 then
							return venv .. "/bin/python"
						end
						return "python"
					end,

					args = { "-q", "--disable-warnings" },

					pytest_discover_instances = true,
				}),

				require("neotest-plenary"),

				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
				}),

				require("neotest-jest")({
					jestCommand = "npm test --",
				}),
			},
		}
	end,
}
