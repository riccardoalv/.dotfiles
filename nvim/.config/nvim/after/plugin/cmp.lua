local status, cmp = pcall(require, "cmp")
if not status then
	return
end

local status1, lspkind = pcall(require, "lspkind")
if not status1 then
	return
end

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			maxwidth = 50,
		}),
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
})
