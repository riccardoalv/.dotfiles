local set_var = vim.api.nvim_set_var
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  {
    "tpope/vim-repeat",
  },
  {
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup({
        options = {
          "buffers",
          "curdir",
          "tabpages",
          "winsize",
          "tabpages",
          "folds",
          "terminal",
        },
      })
      vim.api.nvim_set_keymap("n", "<space>s", [[<cmd>lua require("persistence").load()<cr>]], {})
    end,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css" },
  },
  {
    "echasnovski/mini.pairs",
    config = function()
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      keymap("x", "ga", "<Plug>(EasyAlign)", opts)
      keymap("n", "ga", "<Plug>(EasyAlign)", opts)
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("telescope").load_extension("refactoring")
      keymap("v", "<space>rt", require("telescope").extensions.refactoring.refactors, { noremap = true })

      keymap("n", "<space>rp", function()
        require("refactoring").debug.printf({ below = false })
      end, { noremap = true })

      keymap("v", "<space>rp", require("refactoring").debug.print_var)
      keymap("n", "<space>rc", require("refactoring").debug.cleanup)
    end,
  },
}
