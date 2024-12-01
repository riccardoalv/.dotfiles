local init_modules = {
	"config.autocmd",
	"config.options",
	"config.keymaps",
}

for _, module in ipairs(init_modules) do
	local ok, err = pcall(require, module)
	if not ok then
		error("Error loading " .. module .. "\n\n" .. err)
	end
end
