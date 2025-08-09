return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",

		opts = {
			formatting = {
				fields = { "abbr", "menu" },
				format = function(_, item)
					item.kind = ""
					return item
				end,
			},

			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-Space>"] = { "show" },
				["<CR>"] = { "accept", "fallback" },
				["<C-u>"] = { "scroll_documentation_up" },
				["<C-d>"] = { "scroll_documentation_down" },
			},

			sources = {
				default = { "lsp", "path", "buffer" },
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind", gap = 1 }, { "source_name" } },
					},
				},
			},
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
	},
}
