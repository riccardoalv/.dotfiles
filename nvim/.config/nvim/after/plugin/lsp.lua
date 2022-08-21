local keymap = vim.api.nvim_set_keymap

local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local status1, signature = pcall(require, "lsp_signature")
if not status1 then
	return
end

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { noremap = true, silent = true }
	keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)

	-- formatting
	if client.resolved_capabilities.document_formatting then
		vim.cmd([[augroup Format]])
		vim.cmd([[autocmd! * <buffer>]])
		vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
		vim.cmd([[augroup END]])
	end

	client.resolved_capabilities.document_formatting = false
end

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticHint" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticWarn" })

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
