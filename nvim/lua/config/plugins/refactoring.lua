return {
  "ThePrimeagen/refactoring.nvim",
  depedencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local keymap = vim.keymap.set

    require("telescope").load_extension("refactoring")
    keymap("v", "<space>rt", require("telescope").extensions.refactoring.refactors, { noremap = true })

    keymap("n", "<space>rp", function()
      require("refactoring").debug.printf({ below = false })
    end, { noremap = true })

    keymap("v", "<space>rp", require("refactoring").debug.print_var)
    keymap("n", "<space>rc", require("refactoring").debug.cleanup)
  end
}
