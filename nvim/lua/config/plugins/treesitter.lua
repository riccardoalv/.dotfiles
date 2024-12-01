return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = 'nvim-treesitter.configs',
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = {
      enable = true,
      disable = { 'ruby' },
      disable = function(lang, buf)
        local max_filesize = 200 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
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
}
