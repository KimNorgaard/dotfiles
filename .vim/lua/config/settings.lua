local set = vim.opt -- global options

vim.g.mapleader = ","
set.termguicolors = true
set.guifont = "Go Mono:16"

set.timeout = false  -- don't timeout on mappings
set.ttimeout = true  -- do timeout on terminal key codes
set.ttimeoutlen = 10 -- key code timeout
set.timeoutlen = 500 -- mapped key sequence timeout
set.updatetime = 750

set.hidden = true

set.tabstop = 8 -- one tab = eight columns
set.softtabstop = 2 -- one tab = two spaces (tab key)
set.shiftround = true
set.shiftwidth = 2 -- one tab = two spaces (autoindent)
set.expandtab = true -- never use hard tabs

set.autoindent = true -- keep indenting on <CR>

set.textwidth = 80 -- wrap after 80 columns
-- set.colorcolumn = "+1" -- highlight 81st column
set.linebreak = true -- break on what looks like boundaries
set.showbreak = "↳\\" -- shown at the start of a wrapped line
set.formatoptions = "qrn1"
--                ||||
--                |||+-- ?
--                ||+--- recognize numbered lists
--                |+---- insert current comment leader after hitting enter
--                +----- format comments with gq

set.incsearch = true  -- Jump while searching
set.ignorecase = true -- Case insensitive searches
set.smartcase = true  -- Ignore 'ignorecase' when uppercase is used
set.hlsearch = true   -- Highlight searches
set.showmatch = true  -- Show matching brackets while typing
set.gdefault = true   -- Append /g to replace regex

set.foldenable = true -- Enable code folding
set.foldlevel = 99
set.foldlevelstart = 99
set.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

set.splitbelow = true -- Split windows below current window.
set.splitright = true -- Split windows right of current window
set.modeline = true   -- Check modeline in beginning of file

set.completeopt = "longest,menuone,preview"
set.wildmode = "longest,list,full"                           -- complete longest common prefix first
set.wildignore = set.wildignore + ".*.sw*,__pycache__,*.pyc" -- ignore junk files
set.wildmenu = true                                          -- show a menu of completions like zsh
set.pumheight = 10                                           -- max height of completion menu
set.omnifunc = "syntaxcomplete#Complete"

set.backupdir = vim.fn.stdpath("config") .. "/tmp/backup//"
set.directory = vim.fn.stdpath("config") .. "/tmp/swap//"
set.backup = true
set.undodir = vim.fn.stdpath("config") .. "/tmp/undo" -- persistent undo storage
set.undofile = true                                   -- persistent undo on
set.autowrite = true

set.ttyfast = true

set.title = true
set.titlestring = [[ %{expand("%t")} ]]

set.mousehide = true   -- Hide mouse when typing
set.mouse = "a"        -- No mouse

set.history = 50       -- keep 50 lines of command line history
set.lazyredraw = true  -- don't update screen inside macros, etc

set.number = false     -- no line numbers
set.numberwidth = 5    -- width of numbers column
set.laststatus = 2     -- always show status line
set.ruler = true       -- show the cursor position all the time
set.showcmd = true     -- display incomplete commands
set.cursorline = true  -- highlight current line
set.scrolloff = 10     -- keep at lest N lines while scrolling
set.errorbells = false -- Do not use bells on errors
set.helpheight = 0     -- Height of help screen is 50%
set.list = true
vim.opt.listchars = {
  tab = "▸ ",
  extends = ">",
  precedes = "<",
  nbsp = "␠",
  trail = "⌴",
  eol = "¬",
}

set.fileformats = "unix,dos,mac"       -- unix linebreaks in new files please
vim.g.fileencoding = "utf-8"           -- ...
set.fileencodings = "utf-8,iso-8859-1" -- order to detect Unicodeyness
set.shortmess = set.shortmess + "I"    -- Don't display intro message
set.shortmess = set.shortmess + "c"    -- Don't give ins-completion-menu messages

set.signcolumn = "yes"
set.tags = "./tags;"
set.diffopt:append("vertical")
set.inccommand = "split"

if vim.fn.executable("rg") ~= 0 then
  set.grepprg = "rg --no-heading --vimgrep"
  set.grepformat = "%f:%l:%c:%m"
end

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
      msg = msg .. ", TRL: " .. lineno
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
