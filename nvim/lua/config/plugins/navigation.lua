local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  "christoomey/vim-tmux-navigator",

  {
    "smoka7/hop.nvim",
    config = function()
      require("hop").setup()
      keymap("n", "<space>w", ":HopWord<cr>", opts)
    end,
  },

  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
      keymap("n", "<leader>c", [[:Telescope neoclip ]], {})
      keymap("n", "<A-y>", require("telescope").extensions.neoclip.default)
    end,
  },
}
