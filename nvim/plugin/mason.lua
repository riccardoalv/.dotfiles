local status, mason = pcall(require, "mason")
if not status then
	return
end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

local status3, installer = pcall(require, "mason-tool-installer")
if not status3 then
	return
end

mason.setup({})

lspconfig.setup({
	ensure_installed = {
		"sumneko_lua",
		"rnix",
	},
	automatic_installation = true,
})

installer.setup({
	ensure_installed = {
		"luacheck",
	},
})
