return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"saghen/blink.cmp",
				version = "*",
			},

			"stevearc/conform.nvim",
			"mfussenegger/nvim-lint",
		},

		opts = {
			diagnostics = {
				underline = true,
				virtual_text = { spacing = 4, source = "if_many" },
				severity_sort = true,
				update_in_insert = false,
				signs = true,
			},

			servers = {
				vtsls = {
					experimental = {
						diagnostics = {
							packageWatcher = true,
						},
					},
					autoUseWorkspaceTsdk = true,
					settings = {
						typescript = {
							format = { semicolons = "insert" },
							preferences = { importModuleSpecifier = "non-relative" },
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							workspace = { checkThirdParty = false },
							format = { enable = false },
						},
					},
				},
				basedpyright = {},
				ruff = {},
				nil_ls = {},
				prismals = {
					cmd = { "npx", "prisma-language-server", "--stdio" },
				},
				matlab_ls = {},
			},

			conform = {
				format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
				format_after_save = {
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					nix = { "nixfmt" },
					javascript = { "biome", "prettierd", "prettier" },
					javascriptreact = { "biome", "prettierd", "prettier" },
					typescript = { "biome", "prettierd", "prettier" },
					typescriptreact = { "biome", "prettierd", "prettier" },
					json = { "biome", "jq" },
					css = { "prettierd", "prettier" },
					scss = { "prettierd", "prettier" },
					html = { "prettierd", "prettier" },
					python = { "ruff_format" },
					prisma = { "prisma_fmt" },
					markdown = { "prettierd", "prettier" },
				},
			},

			lint = {
				linters_by_ft = {
					javascript = { "eslint_d" },
					javascriptreact = { "eslint_d" },
					typescript = { "eslint_d" },
					typescriptreact = { "eslint_d" },
					python = { "ruff" },
				},
			},
		},

		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostics)

			local ok_blink, blink = pcall(require, "blink.cmp")
			local capabilities = ok_blink and blink.get_lsp_capabilities()
				or vim.lsp.protocol.make_client_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(ev)
					local bufnr = ev.buf

					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, {
							buffer = bufnr,
							silent = true,
							noremap = true,
							desc = desc,
						})
					end

					map("n", "<c-f>", function()
						require("conform").format({ async = true })
					end, "Format")
				end,
			})

			for server_name, server_opts in pairs(opts.servers) do
				server_opts.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
				vim.lsp.config(server_name, server_opts)
			end

			vim.lsp.enable(vim.tbl_keys(opts.servers))

			require("conform").setup(opts.conform)

			if opts.conform.format_on_save then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
					callback = function(args)
						require("conform").format({ bufnr = args.buf })
					end,
				})
			end

			require("lint").linters_by_ft = opts.lint.linters_by_ft

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("LintOnEvents", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
