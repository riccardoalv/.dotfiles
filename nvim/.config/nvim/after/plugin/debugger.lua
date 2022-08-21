local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local dap = require("dap")
require("nvim-dap-virtual-text").setup()
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.python = {
	type = "executable",
	command = "python3",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		stopOnEntry = false,

		program = "${file}",

		runInTerminal = false,
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

vim.g.dap_virtual_text = "all frames"

keymap("n", "<F5>", [[<cmd>lua require'dap'.continue()<cr>]], opts)
keymap("n", "<leader>b", [[<cmd>lua require'dap'.toggle_breakpoint()<cr>]], opts)
keymap("n", "<right>", [[<cmd>lua require'dap'.step_over()<cr>]], opts)
keymap("n", "<left>", [[<cmd>lua require'dap'.step_back()<cr>]], opts)
keymap("n", "<leader>t", [[<cmd>lua require'telescope'.extensions.dap.variables{}<cr>]], opts)
