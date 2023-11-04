local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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
    keymap("n", "<F12>", [[<cmd>lua require'dap'.continue()<cr>]], opts)
    keymap("n", "<leader>b", [[<cmd>lua require'dap'.toggle_breakpoint()<cr>]], opts)
    keymap("n", "<right>", [[<cmd>lua require'dap'.step_over()<cr>]], opts)
    keymap("n", "<left>", [[<cmd>lua require'dap'.step_back()<cr>]], opts)
    keymap("n", "<leader>t", [[<cmd>lua require'telescope'.extensions.dap.variables{}<cr>]], opts)
    -- stylua: ignore end

    dap.adapters.lldb = {
      type = 'executable',
      command = 'lldb-vscode',
      name = 'lldb'
    }

    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
