return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "drybalka/tree-climber.nvim"
    },
    opts = {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = {'ruby'}
        },
        auto_install = true,
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["ii"] = "@conditional.inner",
              ["oi"] = "@conditional.outer",
              ["a="] = "@assignment.outer",
              ["i="] = "@assignment.inner",
              ["l="] = "@assignment.lhs",
              ["r="] = "@assignment.rhs",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
        },
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
        },
      },
    config = function()
      local o = vim.o
      local keyopts = { noremap = true, silent = true }
      vim.keymap.set({ 'n', 'v', 'o' }, 'L', require('tree-climber').goto_next, keyopts)
      vim.keymap.set({ 'n', 'v', 'o' }, 'H', require('tree-climber').goto_prev, keyopts)
      vim.keymap.set({ 'v', 'o' }, 'in', require('tree-climber').select_node, keyopts)
      vim.keymap.set('n', '<space>h', require('tree-climber').highlight_node, keyopts)
    end,
  }
