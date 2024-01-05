local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    local dap = require("dap")

    require("nvim-dap-virtual-text").setup()

    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

    vim.g.dap_virtual_text = "all frames"

    -- stylua: ignore start
    keymap("n", "<F12>", require('dap').continue)
    keymap("n", "<leader>b", require('dap').toggle_breakpoint)
    keymap("n", "<right>", require('dap').step_over)
    keymap("n", "<left>", require('dap').step_back)
    keymap("n", "<leader>t", require('telescope').extensions.dap.variables)  -- stylua: ignore end

    dap.adapters.lldb = {
      type = "executable",
      command = "lldb-vscode",
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
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
