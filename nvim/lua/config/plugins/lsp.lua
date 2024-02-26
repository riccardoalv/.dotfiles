return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvimtools/none-ls.nvim",
    "glepnir/lspsaga.nvim",
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").setup(opts)
      end,
    },
  },
  opts = {
    diagnostics = {
      underline = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
      },
      severity_sort = true,
    },
    inlay_hints = {
      enabled = false,
    },
    autoformat = true,
  },
  config = function()
    local lspconfig = require("lspconfig")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })

    require("lspsaga").setup({
      ui = {
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        hide_keyword = true,
        delay = 0,
      },
    })

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    function on_attach()
      -- LSP finder - Find the symbol's definition
      keymap("n", "gh", "<cmd>Lspsaga finder<CR>", opts)
      -- Code action
      keymap("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", opts)
      keymap("v", "<space>ca", "<cmd>Lspsaga code_action<CR>", opts)
      -- Rename all occurrences of the hovered word for the entire file
      keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
      -- Peek definition
      keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
      -- Go to definition
      keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
      -- Diagnostic jump
      keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
      keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
      -- Hover Doc
      keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
      -- Call hierarchy
      keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
      keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
    end

    -- Floating terminal
    keymap("n", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)
    keymap("n", "<A-g>", "<cmd>Lspsaga term_toggle<CR>lazygit<cr>", opts)
    keymap("t", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.nixfmt,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.astyle,
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.rnix.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.clangd.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    })
  end,
}
