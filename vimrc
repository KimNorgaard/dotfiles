autocmd BufRead /tmp/mutt*      :source ~/.vim/mail
set incsearch
set ignorecase
set smartcase
set scrolloff=2
set backspace=indent,eol,start
set modeline
set showmode
set nocompatible
set noerrorbells
set helpheight=0
set hidden
"set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
set noicon
set numberwidth=5
set ttyfast

" Title string
set titlestring=vim\ %{expand(\"%t\")}
if &term =~ "^screen"
    " pretend this is xterm.  it probably is anyway, but if term is left as
    " `screen`, vim doesn't understand ctrl-arrow.
    if &term == "screen-256color"
        set term=xterm-256color
    else
        set term=xterm
    endif

    " gotta set these *last*, since `set term` resets everything
    set t_ts=k
    set t_fs=\
endif
set title

" backup, undo
set nobackup
set undodir=~/.vim/undo         " persistent undo storage
set undofile                    " persistent undo on

" user interface
set history=50                  " keep 50 lines of command line history
set lazyredraw                  " don't update screen inside macros, etc
set matchtime=2                 " ms to show the matching paren for showmatch
set number                      " line numbers
set laststatus=2                " always show status line
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set showmatch                   " show matching brackets while typing
set cursorline                  " highlight current line

" whitespace
set autoindent                  " keep indenting on <CR>
set shiftwidth=2                " one tab = two spaces (autoindent)
set softtabstop=2               " one tab = two spaces (tab key)
set tabstop=2
set expandtab                   " never use hard tabs
set fileformats=unix,dos        " unix linebreaks in new files please
set listchars=tab:↹·,extends:>,precedes:<,nbsp:␠,trail:␠
                                " appearance of invisible characters

" wrapping
"set colorcolumn=+1              " highlight 81st column
set linebreak                   " break on what looks like boundaries
set showbreak=↳\                " shown at the start of a wrapped line
"set textwidth=80                " wrap after 80 columns

" unicode
set encoding=utf-8              " best default encoding
setglobal fileencoding=utf-8    " ...
set nobomb                      " do not write utf-8 BOM!
set fileencodings=utf-8,iso-8859-1
                                " order to detect Unicodeyness

" tab completion
set wildmenu                    " show a menu of completions like zsh
set wildmode=full               " complete longest common prefix first
set wildignore+=.*.sw*,__pycache__,*.pyc
                                " ignore junk files


filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
autocmd FileType text setlocal textwidth=78
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
filetype plugin on    " Enable filetype-specific plugins
let mapleader = ","
execute pathogen#infect()
au BufRead,BufNewFile *.eyaml setfiletype yaml

if &t_Co > 2 || has("gui_running")
  set background=dark
  syntax on
endif

set t_Co=256
colorscheme summerfruit256
" sudo-trick.. Save precious changes as root, fuck yeah
command W w !sudo tee % > /dev/null 

