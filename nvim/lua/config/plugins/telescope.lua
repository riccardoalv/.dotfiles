return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "debugloop/telescope-undo.nvim",
  },

  config = function()
    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    telescope = require("telescope")

    -- Telescope.nvim
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["d"] = actions.delete_buffer,
          },
          i = {
            ["<C-q>"] = actions.send_to_qflist,
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
    telescope.load_extension("notify")
    telescope.load_extension("git_worktree")

    vim.cmd([[au FileType TelescopePrompt nmap <buffer> v <c-v>]])
    vim.cmd([[au FileType TelescopePrompt nmap <buffer> x <c-x>]])

    keymap("n", "<leader>f", '<cmd>lua require("telescope.builtin").git_files()<cr>', opts)
    keymap("n", "<c-p>", '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
    keymap("n", "<leader>s", '<cmd>lua require("telescope.builtin").git_status()<cr>', opts)
    keymap("n", "<A-b>", '<cmd>lua require("telescope.builtin").git_branches()<cr>', opts)
    keymap("n", "<A-q>", '<cmd>lua require("telescope.builtin").quickfix()<cr>', opts)
    keymap("n", "<space>b", '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
    keymap("n", "<leader>g", '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
    keymap("n", "<A-t>", '<cmd>lua require("telescope.builtin").treesitter()<cr>', opts)
  end,
}
