return {
"jose-elias-alvarez/null-ls.nvim",

config = function()
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.code_actions.gitsigns,
	},
})
end

}
