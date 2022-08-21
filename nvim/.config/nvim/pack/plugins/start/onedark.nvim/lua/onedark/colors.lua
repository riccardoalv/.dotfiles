local colors = {
	black = { "#101012", "#101012" },
	bg0 = { "#171B20", "#fafafa" }, --
	bg1 = { "#171B20", "#f0f0f0" }, --
	bg2 = { "#35363b", "#e6e6e6" }, --
	bg3 = { "#37383d", "#dcdcdc" }, --
	bg_d = { "#1b1c1e", "#c9c9c9" }, --
	bg_blue = { "#68aee8", "#68aee8" },
	bg_yellow = { "#e2c792", "#e2c792" },
	fg = { "#a7aab0", "#383a42" }, --
	purple = { "#bb70d2", "#a626a4" }, --
	green = { "#8fb573", "#50a14f" }, --
	orange = { "#c49060", "#c18401" }, --
	blue = { "#57a5e5", "#4078f2" }, --
	yellow = { "#dbb671", "#986801" }, --
	cyan = { "#51a8b3", "#0184bc" }, --
	red = { "#de5d68", "#e45649" }, --
	grey = { "#5a5b5e", "#a0a1a7" }, --
	light_grey = { "#818387", "#818387" },
	dark_cyan = { "#2b5d63", "#2b5d63" },
	dark_red = { "#833b3b", "#833b3b" },
	dark_yellow = { "#7c5c20", "#7c5c20" },
	dark_purple = { "#79428a", "#79428a" },
	diff_add = { "#282b26", "#282b26" },
	diff_delete = { "#2a2626", "#2a2626" },
	diff_change = { "#1a2a37", "#1a2a37" },
	diff_text = { "#2c485f", "#2c485f" },
}

local styles = { dark = 1, light = 2 }

local function select_colors()
	local index = styles[vim.g.onedark_style]
	local selected = {}
	for k, v in pairs(colors) do
		selected[k] = v[index]
	end
	selected["none"] = "NONE"
	return selected
end

return select_colors()
