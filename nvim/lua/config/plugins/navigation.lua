local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  "christoomey/vim-tmux-navigator",

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      local status2, harpoon = pcall(require, "harpoon")
      if not status2 then
        return
      end

      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        }
      })

      keymap("n", "<leader><leader>", function() harpoon:list():append() end)
      keymap("n", "<leader><space>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      keymap("n", "<M-h>", function() harpoon:list():prev() end)
      keymap("n", "<M-l>", function() harpoon:list():next() end)
      keymap("n", "<f1>", function() harpoon:list():select(1) end)
      keymap("n", "<f2>", function() harpoon:list():select(2) end)
      keymap("n", "<f3>", function() harpoon:list():select(3) end)
      keymap("n", "<f4>", function() harpoon:list():select(4) end)
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
