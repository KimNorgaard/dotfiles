vim.loader.enable()

-- Globals
vim.g.mapleader = ","

-- UI
vim.o.termguicolors = true
vim.o.guifont = "GoMono Nerd Font:16"
vim.o.lazyredraw = true -- don't update screen inside macros, etc
vim.o.cursorline = true -- highlight current line
vim.o.title = true
vim.o.titlestring = [[%{&modified?'● ':''}%{empty(expand('%:t'))?'nvim':expand('%:t')}]]
vim.o.helpheight = 0 -- Height of help screen is 50%
vim.o.laststatus = 2 -- always show status line

-- Clipboard
-- vim.o.clipboard = "unnamedplus"

-- Ticks
vim.o.timeout = false -- don't timeout on mappings
vim.o.ttimeoutlen = 10 -- key code timeout
vim.o.timeoutlen = 500 -- mapped key sequence timeout
vim.o.updatetime = 750

-- Indentation
vim.o.tabstop = 8 -- one tab = eight columns
vim.o.softtabstop = 2 -- one tab = two spaces (tab key)
vim.o.shiftround = true -- round indent to multiple of shiftwidth
vim.o.shiftwidth = 2 -- one tab = two spaces (autoindent)
vim.o.expandtab = true -- never use hard tabs
vim.o.autoindent = true -- keep indenting on <CR>

-- Files
vim.o.history = 50 -- keep 50 lines of command line history
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath("config") .. "/tmp/backup//"
vim.o.directory = vim.fn.stdpath("config") .. "/tmp/swap//"
vim.o.undodir = vim.fn.stdpath("config") .. "/tmp/undo" -- persistent undo storage
vim.o.undofile = true -- persistent undo on
vim.o.autowrite = true
vim.o.fileformats = "unix,dos,mac" -- unix linebreaks in new files please
vim.o.fileencodings = "utf-8,iso-8859-1" -- order to detect Unicodeyness
vim.o.modeline = true -- Check modeline in beginning of file
vim.o.tags = "./tags;"

-- Mouse
vim.o.mouse = "a"

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- Wrap & textwidth
vim.o.textwidth = 80 -- wrap after 80 columns
-- vim.o.colorcolumn = "+1" -- highlight 81st column
vim.o.linebreak = true -- break on what looks like boundaries

-- Completion
-- vim.o.completeopt = "longest,menuone,preview"
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.o.wildmode = "longest,list,full" -- complete longest common prefix first
vim.opt.wildignore:append({ ".*.sw*", "__pycache__", "*.pyc" }) -- ignore junk files
vim.o.wildmenu = true -- show a menu of completions like zsh
vim.o.pumheight = 15 -- max height of completion menu
-- vim.o.omnifunc = "syntaxcomplete#Complete"

-- Formatting
vim.o.formatoptions = "jtqrn1"
--                     ||||||
--                     |||||+-- ?
--                     ||||+--- recognize numbered lists
--                     |||+---- insert current comment leader after hitting enter
--                     ||+----- format comments with gq
--                     |+------ auto-wrap comments using 'textwidth', inserting
--                     |        the current comment leader automatically.
--                     +------- remove comment leaders when joining

-- Searching
vim.o.inccommand = "split"
vim.o.ignorecase = true -- Case insensitive searches
vim.o.smartcase = true -- Ignore 'ignorecase' when uppercase is used
vim.o.showmatch = true -- Show matching brackets while typing
vim.o.gdefault = true -- Append /g to replace regex
if vim.fn.executable("rg") ~= 0 then
	vim.o.grepprg = "rg --no-heading --vimgrep"
	vim.o.grepformat = "%f:%l:%c:%m"
end

-- Windows
vim.o.splitbelow = true -- Split windows below current window.
vim.o.splitright = true -- Split windows right of current window

-- Statuscolumn and signcolumn
vim.o.numberwidth = 5 -- width of numbers column
vim.o.signcolumn = "yes" -- always show the sign column
vim.opt.shortmess:append("I") -- Don't display intro message
vim.opt.shortmess:append("c") -- Don't give ins-completion-menu messages

-- Scrolling
vim.o.scrolloff = 3 -- keep at lest N lines while scrolling

-- Non-text characters
vim.o.showbreak = "↳\\" -- shown at the start of a wrapped line
vim.o.list = true
vim.opt.listchars = {
	tab = "▸ ",
	extends = ">",
	precedes = "<",
	nbsp = "␠",
	trail = "⌴",
	eol = "¬",
}

-- Diff
vim.opt.diffopt:append("vertical")

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

vim.o.statusline = "%!v:lua._G.gen_statusline()"

-- require("config.settings")
require("config.keymaps")
require("config.autocmds")
require("config.commands")
require("config.plugins")
