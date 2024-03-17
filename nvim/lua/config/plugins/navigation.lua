local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  "christoomey/vim-tmux-navigator",

  {
    "ThePrimeagen/harpoon",
    config = function()
      local status2, harpoon = pcall(require, "harpoon")
      if not status2 then
        return
      end

      harpoon.setup()

      keymap("n", "<leader><leader>", require("harpoon.mark").add_file)
      keymap("n", "<leader><space>", require("harpoon.ui").toggle_quick_menu)
      keymap("n", "<M-l>", require("harpoon.ui").nav_next)
      keymap("n", "<M-h>", require("harpoon.ui").nav_prev)
      keymap("n", "<f1>", function()
        require("harpoon.ui").nav_file(1)
      end)
      keymap("n", "<f2>", function()
        require("harpoon.ui").nav_file(2)
      end)
      keymap("n", "<f3>", function()
        require("harpoon.ui").nav_file(3)
      end)
      keymap("n", "<f4>", function()
        require("harpoon.ui").nav_file(4)
      end)
      keymap("n", "<f5>", function()
        require("harpoon.ui").nav_file(5)
      end)
      keymap("n", "<f6>", function()
        require("harpoon.ui").nav_file(6)
      end)
      keymap("n", "<f7>", function()
        require("harpoon.ui").nav_file(7)
      end)
      keymap("n", "<f8>", function()
        require("harpoon.ui").nav_file(8)
      end)
    end,
  },

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

  "ThePrimeagen/git-worktree.nvim",

  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
  },
}
