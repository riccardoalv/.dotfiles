return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      flavour = "mocha",
      show_end_of_buffer = true,
      custom_highlights = function(colors)
        return {
          DiagnosticVirtualTextError = { bg = colors.none },
          DiagnosticVirtualTextWarn = { bg = colors.none },
          DiagnosticVirtualTextInfo = { bg = colors.none },
          DiagnosticVirtualTextHint = { bg = colors.none },
        }
      end,
      integrations = {
        harpoon = true,
        hop = true,
        lsp_saga = true,
      },
    })

  vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
