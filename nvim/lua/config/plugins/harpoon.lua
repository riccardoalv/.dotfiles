return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local keymap = vim.keymap.set
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      }
    })

    keymap("n", "<leader><leader>", function() harpoon:list():add() end)
    keymap("n", "<leader><space>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    keymap("n", "<M-h>", function() harpoon:list():prev() end)
    keymap("n", "<M-l>", function() harpoon:list():next() end)
    keymap("n", "<M-1>", function() harpoon:list():select(1) end)
    keymap("n", "<M-2>", function() harpoon:list():select(2) end)
    keymap("n", "<M-3>", function() harpoon:list():select(3) end)
    keymap("n", "<M-4>", function() harpoon:list():select(4) end)
  end,
}
