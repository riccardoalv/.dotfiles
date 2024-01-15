local set_var = vim.api.nvim_set_var
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  {
    "mattn/emmet-vim",
    ft = { "html", "css" },
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
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
  -- comments
  "JoosepAlviste/nvim-ts-context-commentstring",
  {
    "echasnovski/mini.comment",
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
    "kana/vim-submode",
    config = function()
      set_var("submode_keep_leaving_key", 1)
      set_var("submode_timeout", 0)

      vim.fn.Submode = function(mode, map, key, exec)
        vim.cmd(string.format("call submode#enter_with('%s', 'n', '', '%s', '%s')", mode, map, exec))
        vim.cmd(string.format("call submode#map('%s', 'n', '', '%s', '%s')", mode, key, exec))
      end
    end,
  },
  "tpope/vim-repeat",

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
