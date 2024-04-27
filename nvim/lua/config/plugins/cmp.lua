return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-emoji",
    },

    config = function()
      local cmp = require("cmp")
      local compare = require("cmp.config.compare")
      local types = require("cmp.types")


      local modified_priority = {
        [types.lsp.CompletionItemKind.Variable]      = 1,
        [types.lsp.CompletionItemKind.Method]        = 2,
        [types.lsp.CompletionItemKind.Function]      = 3,
        [types.lsp.CompletionItemKind.Constructor]   = 4,
        [types.lsp.CompletionItemKind.Field]         = 5,
        [types.lsp.CompletionItemKind.Class]         = 7,
        [types.lsp.CompletionItemKind.Interface]     = 8,
        [types.lsp.CompletionItemKind.Module]        = 9,
        [types.lsp.CompletionItemKind.Property]      = 10,
        [types.lsp.CompletionItemKind.Unit]          = 11,
        [types.lsp.CompletionItemKind.Value]         = 12,
        [types.lsp.CompletionItemKind.Enum]          = 13,
        [types.lsp.CompletionItemKind.Keyword]       = 14,
        [types.lsp.CompletionItemKind.Color]         = 16,
        [types.lsp.CompletionItemKind.File]          = 17,
        [types.lsp.CompletionItemKind.Reference]     = 18,
        [types.lsp.CompletionItemKind.Folder]        = 19,
        [types.lsp.CompletionItemKind.EnumMember]    = 20,
        [types.lsp.CompletionItemKind.Constant]      = 21,
        [types.lsp.CompletionItemKind.Struct]        = 22,
        [types.lsp.CompletionItemKind.Event]         = 23,
        [types.lsp.CompletionItemKind.Operator]      = 24,
        [types.lsp.CompletionItemKind.TypeParameter] = 25,
        [types.lsp.CompletionItemKind.Snippet]       = 26,
        [types.lsp.CompletionItemKind.Text]          = 100,
      }


      local function modified_kind(kind)
        return modified_priority[kind] or kind
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        preselect = cmp.PreselectMode.Item,
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.recently_used,
            function(entry1, entry2)
              local kind1 = modified_kind(entry1:get_kind())
              local kind2 = modified_kind(entry2:get_kind())
              if kind1 ~= kind2 then
                return kind1 - kind2 < 0
              end
            end,
            compare.score,
            compare.order,
          },
          priority_weight = 2,
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- ... Your other mappings ...
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "buffer" },
          { name = "path" },
          { name = 'luasnip' },
          { name = "emoji" },
        },
      })
    end,
  },
}
