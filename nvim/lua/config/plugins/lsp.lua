local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"jose-elias-alvarez/null-ls.nvim",
		"glepnir/lspsaga.nvim",
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

		require("lspsaga").setup({})

		-- LSP finder - Find the symbol's definition
		keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
		-- Code action
		keymap("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", opts)
		keymap("v", "<space>ca", "<cmd>Lspsaga code_action<CR>", opts)
		-- Rename all occurrences of the hovered word for the entire file
		keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
		-- Peek definition
		keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
		-- Go to definition
		keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
		-- Peek type definition
		keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
		-- Show line diagnostics
		keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>", opts)
		-- Show buffer diagnostics
		keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
		-- Show workspace diagnostics
		keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
		-- Show cursor diagnostics
		keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
		-- Diagnostic jump
		keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
		keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
		-- Toggle outline
		keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
		-- Hover Doc
		keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)
		-- Call hierarchy
		keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
		keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
		-- Floating terminal
		keymap("n", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)
		keymap("t", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.nixfmt,
				null_ls.builtins.code_actions.gitsigns,
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})

		lspconfig.rnix.setup({
			capabilities = capabilities,
		})
	end,
}
