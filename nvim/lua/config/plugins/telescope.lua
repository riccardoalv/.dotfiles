return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "debugloop/telescope-undo.nvim",
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/git-worktree.nvim",
  },
  keys = {
   {"<leader>f", "<cmd>lua require('telescope.builtin').git_files<cr>"   },
   {"<c-p>",     "<cmd>lua require('telescope.builtin').find_files<cr>"  },
   {"<leader>s", "<cmd>lua require('telescope.builtin').git_status<cr>"  },
   {"<A-b>",     "<cmd>lua require('telescope.builtin').git_branches<cr>"},
   {"<A-q>",     "<cmd>lua require('telescope.builtin').quickfix<cr>"    },
   {"<space>b",  "<cmd>lua require('telescope.builtin').buffers<cr>"     },
   {"<leader>g", "<cmd>lua require('telescope.builtin').live_grep<cr>"   },
   {"<leader>d", "<cmd>lua require('telescope.builtin').diagnostics<cr>" },
   {"<A-t>",     "<cmd>lua require('telGscope.builtin').treesitter<cr>"  },
   {"<leader>u", "<cmd>lua require('telescope').extensions.undo.undo<cr>"},
  },
  config = function()
    local keymap = vim.keymap.set

    local telescope = require("telescope")

    -- Telescope.nvim
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["d"] = actions.delete_buffer,
            ["<C-c>"] = actions.close,
          },
          i = {
            ["<C-q>"] = actions.send_to_qflist,
            ["<C-c>"] = false,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
        },
      },
    })

    telescope.load_extension("undo")
    telescope.load_extension("git_worktree")

    vim.cmd([[au FileType TelescopePrompt nmap <buffer> v <c-v>]])
    vim.cmd([[au FileType TelescopePrompt nmap <buffer> x <c-x>]])

    keymap("n", "<leader>f", require("telescope.builtin").git_files)
    keymap("n", "<c-p>", require("telescope.builtin").find_files)
    keymap("n", "<leader>s", require("telescope.builtin").git_status)
    keymap("n", "<A-b>", require("telescope.builtin").git_branches)
    keymap("n", "<A-q>", require("telescope.builtin").quickfix)
    keymap("n", "<space>b", require("telescope.builtin").buffers)
    keymap("n", "<leader>g", require("telescope.builtin").live_grep)
    keymap("n", "<leader>d", require("telescope.builtin").diagnostics)
    keymap("n", "<A-t>", require("telescope.builtin").treesitter)
    keymap("n", "<leader>u", require("telescope").extensions.undo.undo)
  end,
}
