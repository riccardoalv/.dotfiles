return {
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
    vim.keymap.set("n", "<space>s", [[<cmd>lua require("persistence").load()<cr>]])
  end,
}
