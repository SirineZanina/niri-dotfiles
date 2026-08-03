-- ~/.config/nvim/luasnippets/markdown.lua
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- ---------------------------------------------------------------- helpers --

local function clip()
	local reg = vim.fn.getreg("+") or ""
	return (reg:gsub("[\r\n]", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function is_url(str)
	return str:match("^https?://") ~= nil or str:match("^www%.") ~= nil
end

-- editable node pre-filled with the clipboard, only if it looks like a URL
local function clip_url()
	return sn(nil, i(1, is_url(clip()) and clip() or ""))
end

-- editable node pre-filled with the clipboard, only if it is NOT a URL
local function clip_text()
	return sn(nil, i(1, is_url(clip()) and "" or clip()))
end

-- text selected before triggering (requires store_selection_keys = "<Tab>")
local function visual(_, parent)
	local sel = parent.snippet.env.LS_SELECT_RAW
	if sel and #sel > 0 then
		return sn(nil, i(1, sel))
	end
	return sn(nil, i(1, ""))
end

-- ------------------------------------------------------------- code fences --

local langs = {
	"lua",
	"python",
	"bash",
	"sh",
	"json",
	"yaml",
	"toml",
	"javascript",
	"typescript",
	"tsx",
	"jsx",
	"rust",
	"go",
	"c",
	"cpp",
	"java",
	"cs",
	"sql",
	"html",
	"css",
	"vim",
	"diff",
	"text",
}

local M = {}

-- generic fence, language is an insert node
table.insert(
	M,
	s(
		{ trig = "code", desc = "Fenced code block (pick language)" },
		fmt("```{}\n{}\n```", { i(1, "lua"), d(2, visual) })
	)
)

-- generic fence with a choice node instead of free typing
table.insert(
	M,
	s(
		{ trig = "codec", desc = "Fenced code block (choice: <C-y> cycles)" },
		fmt("```{}\n{}\n```", {
			c(1, { t("lua"), t("bash"), t("python"), t("javascript"), t("typescript"), t("json"), t("rust"), t("go") }),
			d(2, visual),
		})
	)
)

-- one snippet per language: type `lua`, `bash`, ... in markdown
for _, lang in ipairs(langs) do
	table.insert(
		M,
		s({ trig = lang, desc = lang .. " code block" }, fmt("```" .. lang .. "\n{}\n```", { d(1, visual) }))
	)
end

-- inline code from the clipboard
table.insert(M, s({ trig = "ic", desc = "Inline code" }, fmt("`{}`", { d(1, visual) })))

-- ------------------------------------------------------------------ links --

vim.list_extend(M, {
	-- [text](https://url-from-clipboard)
	s({ trig = "link", desc = "Markdown link (URL from clipboard)" }, {
		t("["),
		d(1, clip_text),
		t("]("),
		d(2, clip_url),
		t(")"),
	}),

	-- same thing, short trigger, works on a visual selection as the label
	s({ trig = "ml", desc = "Link, selection becomes the label" }, {
		t("["),
		d(1, visual),
		t("]("),
		d(2, clip_url),
		t(")"),
	}),

	-- bare autolink
	s({ trig = "url", desc = "Bare URL from clipboard" }, {
		t("<"),
		d(1, clip_url),
		t(">"),
	}),

	-- image
	s({ trig = "img", desc = "Markdown image (path/URL from clipboard)" }, {
		t("!["),
		i(1, "alt"),
		t("]("),
		d(2, function()
			return sn(nil, i(1, clip()))
		end),
		t(")"),
	}),

	-- obsidian wiki link / embed
	s({ trig = "wl", desc = "Wiki link" }, fmt("[[{}]]", { d(1, visual) })),
	s({ trig = "we", desc = "Wiki embed" }, fmt("![[{}]]", { i(1, "note") })),

	-- reference-style link
	s({ trig = "rlink", desc = "Reference link" }, {
		t("["),
		i(1, "text"),
		t("]["),
		i(2, "ref"),
		t("]"),
	}),
})

-- --------------------------------------------------------------- structure --

vim.list_extend(M, {
	-- YAML frontmatter
	s(
		{ trig = "meta", desc = "YAML frontmatter" },
		fmt(
			[[
---
title: {}
date: {}
tags: [{}]
---

{}]],
			{
				i(1, "Title"),
				f(function()
					return os.date("%Y-%m-%d")
				end),
				i(2),
				i(0),
			}
		)
	),

	-- obsidian callout
	s(
		{ trig = "cal", desc = "Callout" },
		fmt("> [!{}] {}\n> {}", {
			c(1, { t("note"), t("tip"), t("info"), t("warning"), t("danger"), t("example"), t("quote") }),
			i(2, "Title"),
			d(3, visual),
		})
	),

	-- details/summary fold
	s(
		{ trig = "det", desc = "Collapsible details block" },
		fmt("<details>\n<summary>{}</summary>\n\n{}\n\n</details>", { i(1, "Summary"), d(2, visual) })
	),

	-- table
	s(
		{ trig = "table", desc = "3-column table" },
		fmt("| {} | {} | {} |\n| --- | --- | --- |\n| {} | {} | {} |", {
			i(1, "a"),
			i(2, "b"),
			i(3, "c"),
			i(4),
			i(5),
			i(6),
		})
	),

	-- task list item
	s({ trig = "todo", desc = "Task item" }, fmt("- [ ] {}", { i(1) })),

	-- today's date
	s(
		{ trig = "date", desc = "Today's date" },
		f(function()
			return os.date("%Y-%m-%d")
		end)
	),
	s(
		{ trig = "now", desc = "Date and time" },
		f(function()
			return os.date("%Y-%m-%d %H:%M")
		end)
	),
})

return M
