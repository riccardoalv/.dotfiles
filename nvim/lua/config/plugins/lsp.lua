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

			"nvimdev/lspsaga.nvim",
		},

		opts = {
			diagnostics = {
				underline = true,
				virtual_text = { spacing = 4, source = "if_many" },
				severity_sort = true,
				update_in_insert = false,
				signs = true,
			},
			inlay_hints = { enabled = true },

			servers = {
				vtsls = {
					settings = {
						typescript = {
							format = { semicolons = "insert" },
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = false },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
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
				prismals = { cmd = { "npx", "prisma-language-server", "--stdio" } },
				matlab_ls = {},
			},

			conform = {
				format_on_save = { timeout_ms = 8000, lsp_fallback = true },
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

			require("lspsaga").setup({
				term = {
					size = 0.7,
					border = "rounded",
				},
				lightbulb = { enable = false },
			})
			vim.keymap.set(
				"n",
				"<A-i>",
				"<cmd>Lspsaga term_toggle<CR>",
				{ silent = true, desc = "Saga Terminal (float)" }
			)
			vim.keymap.set("t", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })
			vim.keymap.set(
				"n",
				"<A-g>",
				"<cmd>Lspsaga term_toggle<CR>lazygit<CR>",
				{ silent = true, desc = "Saga Lazygit" }
			)

			local ok_blink, blink = pcall(require, "blink.cmp")
			local capabilities = ok_blink and blink.get_lsp_capabilities()
				or vim.lsp.protocol.make_client_capabilities()

			local enable_inlay = function(client, bufnr)
				if opts.inlay_hints.enabled and client.supports_method("textDocument/inlayHint") then
					pcall(vim.lsp.inlay_hint, bufnr, true)
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(ev)
					local bufnr = ev.buf
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					enable_inlay(client, bufnr)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
					end

					map("n", "gd", "<cmd>Lspsaga goto_definition<cr>")
					map("n", "gi", "<cmd>Lspsaga finder imp<CR>", "Implementations")
					map("n", "gy", "<cmd>Lspsaga peek_type_definition<CR>", "Type Definition")
					map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover")
					map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename")
					map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
					map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev Diagnostic")
					map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
					map("n", "<c-f>", function()
						require("conform").format({ async = false })
					end, "Format")
					map("n", "gh", "<cmd>Lspsaga finder<CR>", "LSP Finder")
					map("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
					map("v", "<space>ca", "<cmd>Lspsaga code_action<CR>", "Code Action (visual)")
					map("n", "gr", "<cmd>Lspsaga rename<CR>", "Rename")
					map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition")
					map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", "Incoming Calls")
					map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing Calls")
				end,
			})

			local lspconfig = require("lspconfig")
			for server_name, server_opts in pairs(opts.servers) do
				server_opts.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
				if lspconfig[server_name] then
					lspconfig[server_name].setup(server_opts)
				else
					vim.schedule(function()
						vim.notify("lspconfig: server não encontrado: " .. server_name, vim.log.levels.WARN)
					end)
				end
			end

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
