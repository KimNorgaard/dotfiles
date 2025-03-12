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

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "CursorHold", "BufWritePost" }, {
	group = augroup("statusline", {}),
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end
		pcall(vim.api.nvim_buf_del_var, 0, "statusline_cache_trails")
	end,
})

augroup("buffer", {
	clear = true,
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = "buffer",
	pattern = { "*.md", "*.txt" },
	command = "setlocal spell spelllang=en_us,da",
	desc = "Spell check markdown files",
})

autocmd("FileType", {
	group = "buffer",
	pattern = { "gitcommit", "gitrebase" },
	command = "startinsert | 1",
	desc = "Start git messages in insert mode",
})

augroup("mutt", {
	clear = true,
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = "mutt",
	pattern = "*temp/mutt-*",
	command = "set ft=mail | normal /^$/\n | normal o | startinsert",
	desc = "Mail type for mutt buffers",
})

autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, [["]])
		if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
	desc = "open file with cursor on last position",
})

augroup("hidelistcharsoninsert", {
	clear = true,
})

autocmd({ "InsertEnter" }, {
	group = "hidelistcharsoninsert",
	command = "set listchars-=trail:⌴ | set listchars-=eol:¬",
	desc = "Hide listchars on insert",
})

autocmd({ "InsertLeave" }, {
	group = "hidelistcharsoninsert",
	command = "set listchars+=trail:⌴ | set listchars+=eol:¬",
	desc = "Show listchars on insert",
})

local format_sync_grp = augroup("GoFormat", {})
autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})

local km = vim.keymap

local function o(desc, additional_opts)
	local default_opts = { noremap = true, silent = true, desc = desc }
	if additional_opts then
		return vim.tbl_extend("force", default_opts, additional_opts)
	end
	return default_opts
end

-- clear search highlight
km.set("", "<leader><space>", ":noh<cr>:call clearmatches()<cr>", o("Clear search highlight"))

-- tab through parens
km.set("", "<tab>", "%", o("Tab through parentheses"))

-- reselect visual after indent
km.set("v", "<", "<gv", o("Dedent and reselect visual"))
km.set("v", ">", ">gv", o("Indent and reselect visual"))

km.set("n", "<leader>q", "gqip", o("Format inner paragraph"))

km.set({ "n", "v" }, "/", "/\\v", o("Search", { silent = false }))

-- Bubble lines (kicks butt)
km.set("n", "<leader>k", "ddkP", o("Bubble up line"))
km.set("n", "<leader>j", "ddp", o("Bubble down line"))
km.set("v", "<leader>k", "xkP`[V`]", o("Bubble up lines"))
km.set("v", "<leader>j", "xp`[V`]", o("Bubble down lines"))

-- Select pasted text
km.set("n", "<leader>v", "V`]", o("Select pasted text"))

-- sudo-trick.. Save precious changes as root, fuck yeah
km.set("c", "w!!", "w !sudo tee % >/dev/null", o("Write using sudo", { silent = false }))

-- Space to toggle folds.
km.set({ "n", "v" }, "<space>", "za", o("Toggle fold"))

-- Set working directory
km.set("n", "<leader>.", ":lcd %:p:h<CR>", o("Set lcd to buffer's"))

-- Easy buffer/window/tab navigation
km.set("", "<C-h>", "<C-w>h", o("Select window left"))
km.set("", "<C-l>", "<C-w>l", o("Select window right"))
km.set("", "<C-j>", "<C-w>j", o("Select window below"))
km.set("", "<C-k>", "<C-w>k", o("Select window above"))

km.set("", "<M-k>", ":bn<cr>", o("Select next buffer"))
km.set("", "<M-j>", ":bp<cr>", o("Select prev buffer"))
km.set("", "<A-k>", ":bn<cr>", o("Select next buffer"))
km.set("", "<A-j>", ":bp<cr>", o("Select prev buffer"))

-- Copy/Pasting
km.set({ "n", "x" }, "<leader>d", '"+d', o("Delete to clipboard"))
km.set({ "n", "x" }, "<leader>D", '"+D', o("Delete to clipboard"))
km.set({ "n", "x" }, "<leader>y", '"+y', o("Yank to clipboard"))
km.set({ "n", "x" }, "<leader>Y", '"+Y', o("Yank to clipboard"))
km.set({ "n", "x" }, "<leader>p", '"+p', o("Paste from clipboard"))
km.set({ "n", "x" }, "<leader>P", '"+P', o("Paste from clipboard"))

-- Duplicate a line and comment out the first line
km.set("n", "yc", "yy<cmd>normal gcc<CR>p", o("Duplicate line and comment original"))

-- LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
km.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "LSP hover" })
km.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", o("LSP diag float"))
km.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", o("LSP diag prev"))
km.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", o("LSP diag next"))
km.set("n", "<leader>Q", ":lua vim.diagnostic.setloclist()<CR>", o("LSP diag set location list"))
km.set("n", "<leader>rn", vim.lsp.buf.rename, o("LSP rename"))
km.set("n", "gS", ":vsplit<CR>gd", o("LSP gtd vsplit"))

vim.cmd([[command! Qa :qa]])
vim.cmd([[command! Q :q]])
vim.cmd([[command! W :w]])
vim.cmd([[command! Wa :wa]])

require("plugins")
