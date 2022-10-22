local status, npairs = pcall(require, "nvim-autopairs")
if not status then
	return
end
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	disable_filetype = { "TelescopePrompt" },
	map_c_w = true,
	map_c_h = true,
})

-- Add spaces between parentheses
local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
npairs.add_rules({
	Rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({
			brackets[1][1] .. brackets[1][2],
			brackets[2][1] .. brackets[2][2],
			brackets[3][1] .. brackets[3][2],
		}, pair)
	end),
})
for _, bracket in pairs(brackets) do
	npairs.add_rules({
		Rule(bracket[1] .. " ", " " .. bracket[2])
			:with_pair(function()
				return false
			end)
			:with_move(function(opts)
				return opts.prev_char:match(".%" .. bracket[2]) ~= nil
			end)
			:use_key(bracket[2]),
	})
end

-- Expand multiple pairs on enter key
local get_closing_for_line = function(line)
	local i = -1
	local clo = ""

	while true do
		i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
		if i == nil then
			break
		end
		local ch = string.sub(line, i, i)
		local st = string.sub(clo, 1, 1)

		if ch == "{" then
			clo = "}" .. clo
		elseif ch == "}" then
			if st ~= "}" then
				return ""
			end
			clo = string.sub(clo, 2)
		elseif ch == "(" then
			clo = ")" .. clo
		elseif ch == ")" then
			if st ~= ")" then
				return ""
			end
			clo = string.sub(clo, 2)
		elseif ch == "[" then
			clo = "]" .. clo
		elseif ch == "]" then
			if st ~= "]" then
				return ""
			end
			clo = string.sub(clo, 2)
		end
	end

	return clo
end

npairs.remove_rule("(")
npairs.remove_rule("{")
npairs.remove_rule("[")

npairs.add_rules({
	Rule("[%(%{%[]", "")
		:use_regex(true)
		:replace_endpair(function(opts)
			return get_closing_for_line(opts.line)
		end)
		:end_wise(),
	Rule("$$", "$$", { "plaintex", "markdown" }),
	Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
		:use_regex(true)
		:set_end_pair_length(2),
	Rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
})
