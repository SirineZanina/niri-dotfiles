vim.pack.add({
	{
		src = "https://github.com/catppuccin/nvim",
		name = "catppuccin",
	},
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin-mocha")

local function set_transparent() -- set UI component to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		-- "StatusLine",
		-- "StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

-- ======================================================
-- OPTIONS
-- ======================================================

vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backscpae
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behavior
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- =======================================================================
-- STATUSLINE
-- =======================================================================
--
-- -- Git branch function with caching and Nerd Font icon
-- local cached_branch = ""
-- local last_check = 0
-- local function git_branch()
-- 	local now = vim.uv.now()
-- 	if now - last_check > 5000 then -- Check every 5 seconds
-- 		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
-- 		last_check = now
-- 	end
-- 	if cached_branch ~= "" then
-- 		return " \u{e725} " .. cached_branch .. " " -- nf-dev-git_branch
-- 	end
-- 	return ""
-- end
--
-- -- File type with Nerd Font icon
-- local function file_type()
-- 	local ft = vim.bo.filetype
-- 	local icons = {
-- 		lua = "\u{e620} ", -- nf-dev-lua
-- 		python = "\u{e73c} ", -- nf-dev-python
-- 		javascript = "\u{e74e} ", -- nf-dev-javascript
-- 		typescript = "\u{e628} ", -- nf-dev-typescript
-- 		javascriptreact = "\u{e7ba} ",
-- 		typescriptreact = "\u{e7ba} ",
-- 		html = "\u{e736} ", -- nf-dev-html5
-- 		css = "\u{e749} ", -- nf-dev-css3
-- 		scss = "\u{e749} ",
-- 		json = "\u{e60b} ", -- nf-dev-json
-- 		markdown = "\u{e73e} ", -- nf-dev-markdown
-- 		vim = "\u{e62b} ", -- nf-dev-vim
-- 		sh = "\u{f489} ", -- nf-oct-terminal
-- 		bash = "\u{f489} ",
-- 		zsh = "\u{f489} ",
-- 		rust = "\u{e7a8} ", -- nf-dev-rust
-- 		go = "\u{e724} ", -- nf-dev-go
-- 		c = "\u{e61e} ", -- nf-dev-c
-- 		cpp = "\u{e61d} ", -- nf-dev-cplusplus
-- 		java = "\u{e738} ", -- nf-dev-java
-- 		php = "\u{e73d} ", -- nf-dev-php
-- 		ruby = "\u{e739} ", -- nf-dev-ruby
-- 		swift = "\u{e755} ", -- nf-dev-swift
-- 		kotlin = "\u{e634} ",
-- 		dart = "\u{e798} ",
-- 		elixir = "\u{e62d} ",
-- 		haskell = "\u{e777} ",
-- 		sql = "\u{e706} ",
-- 		yaml = "\u{f481} ",
-- 		toml = "\u{e615} ",
-- 		xml = "\u{f05c} ",
-- 		dockerfile = "\u{f308} ", -- nf-linux-docker
-- 		gitcommit = "\u{f418} ", -- nf-oct-git_commit
-- 		gitconfig = "\u{f1d3} ", -- nf-fa-git
-- 		vue = "\u{fd42} ", -- nf-md-vuejs
-- 		svelte = "\u{e697} ",
-- 		astro = "\u{e628} ",
-- 	}
--
-- 	if ft == "" then
-- 		return " \u{f15b} " -- nf-fa-file_o
-- 	end
--
-- 	return ((icons[ft] or " \u{f15b} ") .. ft)
-- end
--
-- -- File size with Nerd Font icon
-- local function file_size()
-- 	local size = vim.fn.getfsize(vim.fn.expand("%"))
-- 	if size < 0 then
-- 		return ""
-- 	end
-- 	local size_str
-- 	if size < 1024 then
-- 		size_str = size .. "B"
-- 	elseif size < 1024 * 1024 then
-- 		size_str = string.format("%.1fK", size / 1024)
-- 	else
-- 		size_str = string.format("%.1fM", size / 1024 / 1024)
-- 	end
-- 	return " \u{f016} " .. size_str .. " " -- nf-fa-file_o
-- end
--
-- -- Mode indicators with Nerd Font icons
-- local function mode_icon()
-- 	local mode = vim.fn.mode()
-- 	local modes = {
-- 		n = " \u{f121}  NORMAL",
-- 		i = " \u{f11c}  INSERT",
-- 		v = " \u{f0168} VISUAL",
-- 		V = " \u{f0168} V-LINE",
-- 		["\22"] = " \u{f0168} V-BLOCK",
-- 		c = " \u{f120} COMMAND",
-- 		s = " \u{f0c5} SELECT",
-- 		S = " \u{f0c5} S-LINE",
-- 		["\19"] = " \u{f0c5} S-BLOCK",
-- 		R = " \u{f044} REPLACE",
-- 		r = " \u{f044} REPLACE",
-- 		["!"] = " \u{f489} SHELL",
-- 		t = " \u{f120} TERMINAL",
-- 	}
-- 	return modes[mode] or (" \u{f059} " .. mode)
-- end
--
-- _G.mode_icon = mode_icon
-- _G.git_branch = git_branch
-- _G.file_type = file_type
-- _G.file_size = file_size
--
-- -- Statusline: solid light bar with dark text (distinct from transparent bg)
-- local statusline_bg = "#bac2de" -- subtext1 — soft off-white, less harsh than pure white
-- local statusline_fg = "#1e1e2e" -- base — dark text for contrast
-- vim.api.nvim_set_hl(0, "StatusLine", { fg = statusline_fg, bg = statusline_bg })
-- vim.api.nvim_set_hl(0, "StatusLineBold", { fg = statusline_fg, bg = statusline_bg, bold = true })
--
-- -- Function to change statusline based on window focus
-- local function setup_dynamic_statusline()
-- 	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
-- 		callback = function()
-- 			vim.opt_local.statusline = table.concat({
-- 				"  ",
-- 				"%#StatusLineBold#",
-- 				"%{v:lua.mode_icon()}",
-- 				"%#StatusLine#",
-- 				" \u{e0b1} %f %h%m%r", -- nf-pl-left_hard_divider
-- 				"%{v:lua.git_branch()}",
-- 				"\u{e0b1} ", -- nf-pl-left_hard_divider
-- 				"%{v:lua.file_type()}",
-- 				"\u{e0b1} ", -- nf-pl-left_hard_divider
-- 				"%{v:lua.file_size()}",
-- 				"%=", -- Right-align everything after this
-- 				" \u{f017} %l:%c  %P ", -- nf-fa-clock_o for line/col
-- 			})
-- 		end,
-- 	})
-- 	vim.api.nvim_set_hl(0, "StatusLineBold", { fg = statusline_fg, bg = statusline_bg, bold = true })
--
-- 	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
-- 		callback = function()
-- 			vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
-- 		end,
-- 	})
-- end
--
-- setup_dynamic_statusline()

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Move to left window/pane" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Move to bottom window/pane" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move to top window/pane" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Move to right window/pane" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (ONLY real file buffers, ONLY when efm is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
		"*.java",
		"*.cs",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

-- highlight yanked and pasted text
vim.api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
	group = augroup,
	callback = function()
		vim.hl.hl_op()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
		vim.opt_local.conceallevel = 0
	end,
})

-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/nvim-lualine/lualine.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	-- Language Server Protocols
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/obsidian-nvim/obsidian.nvim",
	"https://github.com/mrcjkb/rustaceanvim",
	"https://github.com/christoomey/vim-tmux-navigator",

	-- wakatime
	"https://github.com/wakatime/vim-wakatime",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

	-- image preview
	"https://github.com/folke/snacks.nvim",
	"https://github.com/HakonHarnes/img-clip.nvim",
})

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"c_sharp",
		"go",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"typescript",
		"tsx",
		"java",
		"vue",
		"svelte",
		"bash",
		"yaml",
		"toml",
		"xml",
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(config.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

local function get_notes_path()
	local os_release = vim.fn.system("cat /etc/os-release")
	if os_release:match("Arch") then
		return vim.fn.expand("~/Documents/MyVault")
	else
		vim.notify("Unsupported OS: falling back to default notes path", vim.log.levels.WARN)
		return vim.fn.expand("~/Documents/MyVault")
	end
end

local function setup_obsidian()
	require("obsidian").setup({
		legacy_commands = false,
		workspaces = { { name = "Notes", path = get_notes_path() } },
		picker = { name = "fzf-lua" },
		link = { style = "wiki" },
		frontmatter = { enabled = false },
		templates = {
			folder = "5 - Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},

		attachments = {
			folder = "Images",
			confirm_img_paste = true,
		},
	})

	vim.keymap.set("n", "<leader>ni", "<cmd>Obsidian paste_img<cr>", { desc = "Paste image into note" })
	vim.keymap.set("n", "<leader>nn", function()
		vim.cmd("Obsidian workspace")
		vim.defer_fn(function()
			vim.cmd("Obsidian new")
		end, 500)
	end, { desc = "New note" })
	vim.keymap.set("n", "<leader>nf", "<cmd>Obsidian quick_switch<cr>", { desc = "Find note" })
	vim.keymap.set("n", "<leader>ns", "<cmd>Obsidian search<cr>", { desc = "Search notes" })
	vim.keymap.set("n", "<leader>nt", "<cmd>Obsidian today<cr>", { desc = "Today's daily note" })
	vim.keymap.set("n", "<leader>nw", "<cmd>Obsidian workspace<cr>", { desc = "Switch workspace" })
end

local obsidian_ok, obsidian_err = pcall(setup_obsidian)
if not obsidian_ok then
	vim.notify("Obsidian disabled: " .. tostring(obsidian_err), vim.log.levels.WARN)
end

require("nvim-tree").setup({
	view = {
		width = 35,
	},
	filters = {
		dotfiles = false,
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
})

vim.keymap.set("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })

vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

require("mini.icons").mock_nvim_web_devicons()

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "▎" },
	},
})

require("mini.git").setup({})

local MiniDiff = require("mini.diff")
vim.keymap.set("n", "]h", function()
	MiniDiff.goto_hunk("next")
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	MiniDiff.goto_hunk("prev")
end, { desc = "Prev git hunk" })
vim.keymap.set("n", "<leader>hs", MiniDiff.operator, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hp", function()
	MiniDiff.toggle_overlay()
end, { desc = "Preview diff overlay" })
vim.keymap.set("n", "<leader>hb", function()
	require("mini.git").show_at_cursor()
end, { desc = "Git blame/show" })

-- ============================================================================
-- STATUSLINE (lualine)
-- ============================================================================

-- lualine's diff component defaults to gitsigns; feed it mini.diff instead
local function minidiff_source()
	local summary = vim.b.minidiff_summary
	if not summary then
		return nil
	end
	return {
		added = summary.add,
		modified = summary.change,
		removed = summary.delete,
	}
end

require("lualine").setup({
	options = {
		theme = "catppuccin",
		globalstatus = true,
		component_separators = { left = "\u{e0b1}", right = "\u{e0b3}" },
		section_separators = { left = "\u{e0b0}", right = "\u{e0b2}" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					local icons = {
						NORMAL = "\u{f121}",
						INSERT = "\u{f11c}",
						VISUAL = "\u{f0168}",
						["V-LINE"] = "\u{f0168}",
						["V-BLOCK"] = "\u{f0168}",
						SELECT = "\u{f0c5}",
						COMMAND = "\u{f120}",
						REPLACE = "\u{f044}",
						TERMINAL = "\u{f120}",
					}
					return (icons[str] or "\u{f059}") .. "  " .. str
				end,
			},
		},
		lualine_b = {
			"branch",
			{ "diff", source = minidiff_source },
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = "\u{f057} ",
					warn = "\u{f071} ",
					info = "\u{f05a} ",
					hint = "\u{ea61} ",
				},
			},
		},
		lualine_c = {
			{
				"filename",
				path = 3,
				shorting_target = 40,
				symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]" },
			},
		},
		lualine_x = { "filesize", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "nvim-tree", "fzf", "mason", "quickfix" },
})

require("mason").setup({})

require("mason-tool-installer").setup({
	ensure_installed = {
		"bash-language-server",
		"black",
		"clang-format",
		"clangd",
		"cpplint",
		"csharpier",
		"css-lsp",
		"efm",
		"emmet-language-server",
		"eslint_d",
		"fixjson",
		"flake8",
		"gofumpt",
		"google-java-format",
		"gopls",
		"html-lsp",
		"jdtls",
		"lua-language-server",
		"luacheck",
		"omnisharp",
		"prettierd",
		"pyright",
		"revive",
		"shellcheck",
		"shfmt",
		"stylua",
		"typescript-language-server",
	},
})

require("which-key").setup({})

require("snacks").setup({
	image = {
		enabled = true,
		doc = {
			inline = true,
			max_width = 60,
			max_height = 30,
		},
		img_dirs = { "Images", "img", "images", "assets", "static", "public", "media", "attachments" },
		resolve = function(file, src)
			local ok, api = pcall(require, "obsidian.api")
			if not ok or not api.path_is_note(file) then
				return
			end
			local fn = api.resolve_attachment_path or api.resolve_image_path
			return fn and fn(src) or nil
		end,
	},
})

local vault = vim.fn.expand("~/Documents/ObsidianVault/MyVault")

require("img-clip").setup({
	default = {
		dir_path = "assets",
		file_name = "%Y-%m-%d-%H-%M-%S",
		prompt_for_file_name = false,
	},
	dirs = {
		[vault] = {
			dir_path = vault .. "/Images",
			file_name = "Pasted image %Y%m%d%H%M%S",
			extension = "webp",
			process_cmd = "magick - -quality 75 webp:-",
			formats = { "jpeg", "jpg", "png", "webp" },
			filetypes = {
				markdown = {
					url_encode_path = false,
					template = "![[$FILE_NAME]]",
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>ip", "<cmd>PasteImage<cr>", { desc = "Paste image from clipboard" })
vim.keymap.set("n", "<leader>ih", function()
	require("snacks.image").hover()
end, { desc = "Show image at cursor" })

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================

local diagnostic_signs = {
	Error = "\u{f057} ",
	Warn = "\u{f071} ",
	Hint = "\u{ea61}",
	Info = "\u{f05a}",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			auto_show = function()
				return vim.bo.filetype ~= "markdown"
			end,
		},
	},
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	snippets = { preset = "luasnip" },
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- ============================================================================
-- SNIPPETS (LuaSnip)
-- ============================================================================
local ls = require("luasnip")

ls.setup({
	history = true, -- let <C-e> jump back into a snippet you left
	updateevents = "TextChanged,TextChangedI", -- live-update dynamic/function nodes
	delete_check_events = "TextChanged", -- drop dead snippets so old tabstops don't fire
	enable_autosnippets = true, -- needed if you later add snippetType = "autosnippet"
	store_selection_keys = "<Tab>", -- visual mode: <Tab> stashes the selection
})

-- friendly-snippets (VSCode JSON) -> registered into LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()

-- your own snippets (Lua) -> registered into LuaSnip
require("luasnip.loaders.from_lua").lazy_load({
	paths = vim.fn.stdpath("config") .. "/luasnippets",
})

-- inherit snippets across related filetypes
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
ls.filetype_extend("vue", { "javascript" })
ls.filetype_extend("svelte", { "javascript" })
ls.filetype_extend("zsh", { "sh" })
ls.filetype_extend("bash", { "sh" })

vim.keymap.set({ "i", "s" }, "<C-e>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true, desc = "Expand snippet / jump forward" })

vim.keymap.set({ "i", "s" }, "<C-b>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true, desc = "Jump backward in snippet" })

vim.keymap.set({ "i", "s" }, "<C-y>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true, desc = "Cycle snippet choice" })

vim.keymap.set("n", "<leader>Ls", function()
	require("luasnip.loaders.from_lua").load({
		paths = vim.fn.stdpath("config") .. "/luasnippets",
	})
	vim.notify("Snippets reloaded")
end, { desc = "Reload snippets" })

vim.keymap.set("n", "<leader>Ll", function()
	require("luasnip.extras.snippet_list").open()
end, { desc = "List snippets for this buffer" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})
vim.lsp.config("jdtls", {})
vim.lsp.config("omnisharp", {})
vim.lsp.config("html", {})
vim.lsp.config("cssls", {})
vim.lsp.config("emmet_language_server", {})

vim.g.rustaceanvim = {
	server = {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	},
}

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local cpplint = require("efmls-configs.linters.cpplint")
	local clangfmt = require("efmls-configs.formatters.clang_format")

	local go_revive = require("efmls-configs.linters.go_revive")
	local gofumpt = require("efmls-configs.formatters.gofumpt")

	local google_java_format = require("efmls-configs.formatters.google_java_format")
	local csharpier = {
		formatCommand = "csharpier format --write-stdout",
		formatStdin = true,
	}

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"java",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				c = { clangfmt, cpplint },
				go = { gofumpt, go_revive },
				cpp = { clangfmt, cpplint },
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				svelte = { eslint_d, prettier_d },
				java = { google_java_format },
				cs = { csharpier },
			},
		},
	})
end

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"ts_ls",
	"gopls",
	"clangd",
	"jdtls",
	"omnisharp",
	"html",
	"cssls",
	"emmet_language_server",
	"efm",
})

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = vim.bo[terminal_state.buf].buftype == "terminal"
	if not has_terminal then
		vim.fn.jobstart(vim.o.shell, { term = true })
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	local term_augroup = vim.api.nvim_create_augroup("FloatingTermLeave_" .. terminal_state.win, { clear = true })
	vim.api.nvim_create_autocmd("BufLeave", {
		group = term_augroup,
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

vim.keymap.set(
	"n",
	"<leader>tt",
	FloatingTerminal,
	{ noremap = true, silent = true, desc = "Toggle floating terminal" }
)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Terminal normal mode" })
vim.keymap.set("t", "<C-q>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true, desc = "Close floating terminal" })
