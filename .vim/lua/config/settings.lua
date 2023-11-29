local exec = vim.api.nvim_exec -- execute Vimscript
local api = vim.api -- neovim commands
local autocmd = vim.api.nvim_create_autocmd -- execute autocommands
local set = vim.opt -- global options
local cmd = vim.cmd -- execute Vim commands

vim.g.mapleader = ","
set.termguicolors = true

set.timeout = false                 -- don't timeout on mappings
set.ttimeout = true                 -- do timeout on terminal key codes
set.ttimeoutlen = 10                -- key code timeout
set.timeoutlen = 500                -- mapped key sequence timeout
set.updatetime = 750

set.hidden = true

set.tabstop = 8                     -- one tab = eight columns
set.softtabstop = 2                 -- one tab = two spaces (tab key)
set.shiftwidth = 2                  -- one tab = two spaces (autoindent)
set.expandtab = true                -- never use hard tabs

set.autoindent = true               -- keep indenting on <CR>

set.textwidth = 80                  -- wrap after 80 columns
set.colorcolumn = "+1"              -- highlight 81st column
set.linebreak = true                -- break on what looks like boundaries
set.showbreak = "↳\\"               -- shown at the start of a wrapped line
set.formatoptions = "qrn1"
--                ||||
--                |||+-- ?
--                ||+--- recognize numbered lists
--                |+---- insert current comment leader after hitting enter
--                +----- format comments with gq

set.incsearch = true                -- Jump while searching
set.ignorecase = true               -- Case insensitive searches
set.smartcase = true                -- Ignore 'ignorecase' when uppercase is used
set.hlsearch = true                 -- Highlight searches
set.showmatch = true                -- Show matching brackets while typing
set.gdefault = true                 -- Append /g to replace regex

set.foldenable = true               -- Enable code folding
set.foldlevel = 100
set.foldmethod = "indent"

set.splitbelow = true               -- Split windows below current window.
set.splitright = true               -- Split windows right of current window
set.modeline = true                 -- Check modeline in beginning of file

set.completeopt = "longest,menuone,preview"
set.wildmode = "longest,list,full"  -- complete longest common prefix first
set.wildignore = set.wildignore + ".*.sw*,__pycache__,*.pyc" -- ignore junk files
set.wildmenu = true                 -- show a menu of completions like zsh
set.pumheight = 16                  -- max height of completion menu
set.omnifunc = "syntaxcomplete#Complete"

set.backupdir = vim.fn.stdpath('config') .. "/tmp/backup//"
set.directory = vim.fn.stdpath('config') .. "/tmp/swap//"
set.backup = true
set.undodir = vim.fn.stdpath('config') .. "/tmp/undo"     -- persistent undo storage
set.undofile = true                 -- persistent undo on
set.autowrite = true

set.ttyfast = true

set.title = true
set.titlestring = [[ %{expand("%t")} ]]

set.mousehide = true                -- Hide mouse when typing
set.mouse = ""                      -- No mouse

set.history = 50                    -- keep 50 lines of command line history
set.lazyredraw = true               -- don't update screen inside macros, etc

set.number = false                  -- no line numbers
set.numberwidth = 5                 -- width of numbers column
set.laststatus = 2                  -- always show status line
set.ruler = true                    -- show the cursor position all the time
set.showcmd = true                  -- display incomplete commands
set.cursorline = true               -- highlight current line
set.scrolloff = 5                   -- keep at lest N lines while scrolling
set.errorbells = false              -- Do not use bells on errors
set.helpheight = 0                  -- Height of help screen is 50%
set.list = true
vim.opt.listchars= {
  tab = "▸ ",
  extends = ">",
  precedes = "<",
  nbsp = "␠",
  trail = "⌴",
  eol = "¬"
}

set.fileformats = "unix,dos,mac"    -- unix linebreaks in new files please
vim.g.fileencoding = "utf-8"        -- ...
set.fileencodings = "utf-8,iso-8859-1" -- order to detect Unicodeyness
set.shortmess = set.shortmess + "I" -- Don't display intro message
set.shortmess = set.shortmess + "c" -- Don't give ins-completion-menu messages

set.pastetoggle = "<F6>"            -- Toggle paste mode
set.signcolumn = "yes"
set.tags = "./tags;"
set.diffopt = set.diffopt + "vertical"
set.inccommand = "nosplit"

if vim.fn.executable("ag") == 1 then
  set.grepprg="rg --no-heading --vimgrep"
  set.grepformat="%f:%l:%c:%m"
end

-- vim.g.python_host_prog = os.getenv( "HOME" ) .. "/.python2_neovim/bin/python"
-- vim.g.python3_host_prog = os.getenv( "HOME" ) .. "/.python3_neovim/bin/python"
