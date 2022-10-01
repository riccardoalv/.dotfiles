local status, impatient = pcall(require, "impatient")
if not status then
	return
end

require("ricardo")

require("onedark").setup({
	style = "darker",
	ending_tildes = true,
	colors = {
		bg0 = "#171b20",
	},
})
require("onedark").load()
