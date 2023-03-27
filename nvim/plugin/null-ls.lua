local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.code_actions.gitsigns,
	},
})
