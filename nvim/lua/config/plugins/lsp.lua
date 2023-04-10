local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


return {
    {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})

-- LSP finder - Find the symbol's definition
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
-- Code action
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
-- Peek definition
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
-- Go to definition
keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>", opts)
-- Peek type definition
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
-- Show line diagnostics
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>", opts)
-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
-- Show workspace diagnostics
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>",opts )
-- Show cursor diagnostics
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
-- Diagnostic jump
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
-- Toggle outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>", opts)
-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)
-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
-- Floating terminal
keymap("n", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)
keymap("t", "<A-i>", "<cmd>Lspsaga term_toggle<CR>", opts)
    end,
},
{
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
		end

		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			signs = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig.rnix.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}
}
