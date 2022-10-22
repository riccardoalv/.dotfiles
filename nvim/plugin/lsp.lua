local keymap = vim.api.nvim_set_keymap

local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local status1, signature = pcall(require, "lsp_signature")
if not status1 then
	return
end

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
	virtual_text = {
		prefix = "● ",
	},
	severity_sort = true,
	float = {
		source = "always",
	},
})

signature.setup({
	handler_opts = { border = "single" },
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.texlab.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.rnix.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})