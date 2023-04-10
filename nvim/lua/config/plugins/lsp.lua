local keymap = vim.api.nvim_set_keymap

return {
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

	local bufopts = { noremap = true, silent = true }
	keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
	keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	keymap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
	keymap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
	keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

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
end

}
