local set = vim.opt -- global options

-- Globals
vim.g.mapleader = ","

-- UI
set.termguicolors = true
set.guifont = "Go Mono:16"
set.lazyredraw = true -- don't update screen inside macros, etc
set.cursorline = true -- highlight current line
set.title = true
set.titlestring = [[ %{expand("%t")} ]]
set.helpheight = 0 -- Height of help screen is 50%

-- Clipboard
-- set.clipboard = "unnamedplus"

-- Ticks
set.timeout = false -- don't timeout on mappings
set.ttimeoutlen = 10 -- key code timeout
set.timeoutlen = 500 -- mapped key sequence timeout
set.updatetime = 750

-- Indentation
set.tabstop = 8 -- one tab = eight columns
set.softtabstop = 2 -- one tab = two spaces (tab key)
set.shiftround = true -- round indent to multiple of shiftwidth
set.shiftwidth = 2 -- one tab = two spaces (autoindent)
set.expandtab = true -- never use hard tabs
set.autoindent = true -- keep indenting on <CR>

-- Files
set.history = 50 -- keep 50 lines of command line history
set.backup = true
set.backupdir = vim.fn.stdpath("config") .. "/tmp/backup//"
set.directory = vim.fn.stdpath("config") .. "/tmp/swap//"
set.undodir = vim.fn.stdpath("config") .. "/tmp/undo" -- persistent undo storage
set.undofile = true -- persistent undo on
set.autowrite = true
set.fileformats = "unix,dos,mac" -- unix linebreaks in new files please
set.fileencodings = "utf-8,iso-8859-1" -- order to detect Unicodeyness
set.modeline = true -- Check modeline in beginning of file
set.tags = "./tags;"

-- Mouse
set.mouse = "a"

-- Folding
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldlevel = 99
set.foldlevelstart = 99

-- Wrap & textwidth
set.textwidth = 80 -- wrap after 80 columns
-- set.colorcolumn = "+1" -- highlight 81st column
set.linebreak = true -- break on what looks like boundaries

-- Completion
-- set.completeopt = "longest,menuone,preview"
set.completeopt = { "menu", "menuone", "noselect", "noinsert" }
set.wildmode = "longest,list,full" -- complete longest common prefix first
set.wildignore = set.wildignore + ".*.sw*,__pycache__,*.pyc" -- ignore junk files
set.wildmenu = true -- show a menu of completions like zsh
set.pumheight = 15 -- max height of completion menu
-- set.omnifunc = "syntaxcomplete#Complete"

-- Formatting
set.formatoptions = "qrn1"
--                   ||||
--                   |||+-- ?
--                   ||+--- recognize numbered lists
--                   |+---- insert current comment leader after hitting enter
--                   +----- format comments with gq

-- Searching
set.inccommand = "split"
set.ignorecase = true -- Case insensitive searches
set.smartcase = true -- Ignore 'ignorecase' when uppercase is used
set.showmatch = true -- Show matching brackets while typing
set.gdefault = true -- Append /g to replace regex
if vim.fn.executable("rg") ~= 0 then
	set.grepprg = "rg --no-heading --vimgrep"
	set.grepformat = "%f:%l:%c:%m"
end

-- Windows
set.splitbelow = true -- Split windows below current window.
set.splitright = true -- Split windows right of current window

-- Statuscolumn and signcolumn
set.numberwidth = 5 -- width of numbers column
set.signcolumn = "yes" -- always show the sign column
set.shortmess = set.shortmess + "I" -- Don't display intro message
set.shortmess = set.shortmess + "c" -- Don't give ins-completion-menu messages

-- Scrolling
set.scrolloff = 10 -- keep at lest N lines while scrolling

-- Non-text characters
set.showbreak = "↳\\" -- shown at the start of a wrapped line
set.list = true
set.listchars = {
	tab = "▸ ",
	extends = ">",
	precedes = "<",
	nbsp = "␠",
	trail = "⌴",
	eol = "¬",
}

-- Statusline
set.laststatus = 2 -- always show status line

-- Diff
set.diffopt:append("vertical")

local function get_trl()
	local cache_key = "statusline_cache_trails"
	local cache_ok, cache = pcall(vim.api.nvim_buf_get_var, 0, cache_key)
	if cache_ok then
		return cache
	end

	local msg = ""
	if not vim.bo.readonly and vim.bo.modifiable then
		local lineno = vim.fn.search("\\s$", "nw")
		if lineno > 0 then
			msg = msg .. ",TRL: " .. lineno
		end
	end
	vim.api.nvim_buf_set_var(0, cache_key, msg)
	return msg
end

vim.api.nvim_create_autocmd({ "CursorHold", "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("statusline", {}),
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end
		pcall(vim.api.nvim_buf_del_var, 0, "statusline_cache_trails")
	end,
})

function _G.gen_statusline()
	-- buffer name
	local statusline = "%f"
	-- %Y - file type
	-- %M - modified flag
	-- %R - readonly flag
	-- %H - help flag
	-- %W - preview flag
	-- statusline = statusline .. '%( [%Y%M%R%H%W%{&paste?",PASTE":""}%{TrailingSpaceWarning()}]%)'
	statusline = statusline .. '%( [%Y%M%R%H%W%{&paste?",PASTE":""}' .. get_trl() .. "]%)"
	-- %< - truncate
	-- %= - right align (ruler)
	-- %l - line number
	-- %c - colum number
	-- %V - virtual column number
	-- %P - percent
	statusline = statusline .. "%< %=%-14.(%l,%c%V%) %P"
	return statusline
end

set.statusline = "%!v:lua._G.gen_statusline()"
