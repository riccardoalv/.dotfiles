local set_var = vim.api.nvim_set_var
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
  {
    "tpope/vim-repeat",
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css" },
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      keymap("x", "ga", "<Plug>(EasyAlign)", opts)
      keymap("n", "ga", "<Plug>(EasyAlign)", opts)
    end,
  },
}
