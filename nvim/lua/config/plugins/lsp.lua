return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "glepnir/lspsaga.nvim",
    'hrsh7th/cmp-nvim-lsp',
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
    inlay_hints = { enabled = false },
    servers = {
      tsserver = {
        root_dir = function(...)
          return require("lspconfig.util").root_pattern(".git")(...)
        end,
        single_file_support = false,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "literal",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            completion = {
              callSnippet = 'Replace',
            },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.RUNTIME },
              maxPreload = 1000,
              preloadFileSize = 1000,
            },
            format = {
              enable = false,
            },
          },
        },
      },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

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

    function on_attach(client, bufnr)
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

      local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp_detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'lsp_highlight', buffer = event2.buf }
          end,
        })
      end

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        virtual_text = {
          spacing = 5,
          severity = {
            min = vim.diagnostic.severity.WARN
          }
        },
        update_in_insert = true,
      }
    )

    -- Floating terminal
    keymap("n", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)
    keymap("n", "<A-g>", "<cmd>Lspsaga term_toggle<CR>lazygit<cr>", opts)
    keymap("t", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)

    local null_ls = require("null-ls")

    null_ls.setup({
      on_attach = on_attach,
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.nixfmt,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.prettierd,
        require("none-ls.diagnostics.eslint"),
        require("none-ls.code_actions.eslint"),
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.nil_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.prismals.setup {
      cmd = { "npx", "prisma-language-server", "--stdio" },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
