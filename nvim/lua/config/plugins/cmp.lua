return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local cmp = require("cmp")

			require("luasnip.loaders.from_vscode").lazy_load()

			vim.cmd(
				[[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>']]
			)
			vim.cmd([[inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>]])
			vim.cmd([[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]])
			vim.cmd([[snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>]])

			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			cmp.setup({
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
			})
		end,
	},
}
