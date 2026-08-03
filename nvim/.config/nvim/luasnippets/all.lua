-- ~/.config/nvim/luasnippets/all.lua
-- Snippets here are available in every filetype.
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function clip()
	local reg = vim.fn.getreg("+") or ""
	return (reg:gsub("[\r\n]", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

return {
	-- paste the clipboard as an editable node (handy inside other snippets/strings)
	s({ trig = "clip", desc = "Clipboard contents" }, {
		d(1, function()
			return sn(nil, i(1, clip()))
		end),
	}),

	s(
		{ trig = "date", desc = "YYYY-MM-DD" },
		f(function()
			return os.date("%Y-%m-%d")
		end)
	),

	s(
		{ trig = "now", desc = "YYYY-MM-DD HH:MM" },
		f(function()
			return os.date("%Y-%m-%d %H:%M")
		end)
	),

	s(
		{ trig = "uuid", desc = "Random UUID v4" },
		f(function()
			local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
			return (
				template:gsub("[xy]", function(ch)
					local v = (ch == "x") and math.random(0, 15) or math.random(8, 11)
					return string.format("%x", v)
				end)
			)
		end)
	),

	s({ trig = "todo", desc = "TODO comment" }, fmt("TODO({}): {}", { i(1, os.getenv("USER") or "me"), i(2) })),
	s({ trig = "fixme", desc = "FIXME comment" }, fmt("FIXME({}): {}", { i(1, os.getenv("USER") or "me"), i(2) })),
}
