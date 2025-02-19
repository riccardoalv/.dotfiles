return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-python",
  },
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace("neotest")

    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
    require("neotest").setup({
      status = { virtual_text = true },
      adapters = {
        require("neotest-jest")({
          jestCommand = "yarn jest",
        }),
      },
    })
    local keymap = vim.keymap.set

    keymap("n", "<leader>tt", function()
      require("neotest").run.run()
    end)
    keymap("n", "<leader>ts", function()
      require("neotest").watch.toggle(vim.uv.cwd())
      require("neotest").summary.toggle()
    end)
    keymap("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end)
    keymap("n", "<leader>ta", function()
      require("neotest").run.run(vim.uv.cwd())
    end)
  end,
}
