" .vimrc
" Kim Nørgard <jasen@jasen.dk>

" Because fuck vi
set nocompatible

" Enable filetypes
filetype off
execute pathogen#infect()
filetype plugin indent on

"Mapleader
let mapleader = ","

"GUI
if &t_Co > 2 || has("gui_running")
  syntax on
endif

if has("gui_running")
  set guifont=Menlo:h12
  set linespace=3
  set noicon
endif

"Color
set t_Co=256
colorscheme Mustang_Vim_Colorscheme_by_hcalves

"Leader+command timeout
set notimeout
set ttimeout
set ttimeoutlen=10
set timeoutlen=500

"Switch between buffers without saving
set hidden

"TABs
set shiftwidth=2                " one tab = two spaces (autoindent)
set softtabstop=2               " one tab = two spaces (tab key)
set tabstop=2
set expandtab                   " never use hard tabs

"Indentation
set autoindent                  " keep indenting on <CR>
set smartindent

"Wrapping
set wrap
set colorcolumn=+1              " highlight 81st column
set linebreak                   " break on what looks like boundaries
set showbreak=↳\                " shown at the start of a wrapped line
set textwidth=80                " wrap after 80 columns
set formatoptions=qrn1

"Searching
set incsearch                   " Jump while searching
set ignorecase                  " Case insensitive searches
set smartcase                   " Ignore 'ignorecase' when uppercase is used
set hlsearch                    " Highlight searches
set showmatch                   " Show matching brackets while typing
set gdefault                    " Append /g to replace regex

"Hard-wrap paragraphs of text
nnoremap <leader>q gqip

"Map code completion to , + tab
imap <leader><tab> <C-x><C-o>

"Use better regexp
nnoremap / /\v
vnoremap / /\v

"Enable code folding
set foldenable

"Window handling
set splitbelow                  "Split windows below the current window.

"Editing
set modeline                    "Check modeline in beginning of file

"Command-line completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set wildmode=longest,list,full           " complete longest common prefix first
set wildignore+=.*.sw*,__pycache__,*.pyc " ignore junk files
set wildmenu                             " show a menu of completions like zsh

"Bubble single lines (kicks butt)
""http://vimcasts.org/episodes/bubbling-text/
nmap <leader>k ddkP
nmap <leader>j ddp

"Bubble multiple lines
vmap <leader>k xkP`[V`]
vmap <leader>j xp`[V`]

" Select pasted text
nnoremap <leader>v V`]

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"------------------------"
"NERDTREE PLUGIN SETTINGS
"------------------------"
""Shortcut for NERDTreeToggle
nmap <leader>nt :NERDTreeToggle <CR>
noremap  <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>

augroup ps_nerdtree
    au!

    au Filetype nerdtree setlocal nolist
augroup END

"Show hidden files in NerdTree
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'


"autopen NERDTree and focus cursor in new document
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

"------------------------"
"Command-T SETTINGS
"------------------------"

if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
endif

" Backup
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set undodir=~/.vim/tmp/undo         " persistent undo storage
set undofile                        " persistent undo on
set autowrite
au FocusLost * :wa                  " Save after loosing focus

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set backspace=indent,eol,start
"set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
set ttyfast
set magic

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

" user interface
set mousehide                   " Hide mouse when typing
set history=50                  " keep 50 lines of command line history
set lazyredraw                  " don't update screen inside macros, etc
set matchtime=5                 " ms to show the matching paren for showmatch
set number                      " line numbers
set numberwidth=5               " width of numbers column
set laststatus=2                " always show status line
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands

set cursorline                  " highlight current line
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

set scrolloff=3                 " keep at lest N lines while scrolling
set showmode                    " Show mode on bottom line
set noerrorbells                " Do not use bells on errors
set helpheight=0                " Height of help screen is 50%

set list
set listchars=tab:▸\ ,extends:>,precedes:<,nbsp:␠,trail:⌴,eol:¬
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴,eol:¬
    au InsertLeave * :set listchars+=trail:⌴,eol:¬
augroup END

" Encoding, file types
set fileformats=unix,dos        " unix linebreaks in new files please
                                " appearance of invisible characters
set encoding=utf-8              " best default encoding
setglobal fileencoding=utf-8    " ...
set nobomb                      " do not write utf-8 BOM!
set fileencodings=utf-8,iso-8859-1
                                " order to detect Unicodeyness

autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" eyaml and yaml are the same
au BufRead,BufNewFile *.eyaml setfiletype yaml

" sudo-trick.. Save precious changes as root, fuck yeah
cnoremap w!! w !sudo tee % >/dev/null

" Don't display intro message
set shortmess+=I

set mouse=a

" Toggle paste
set pastetoggle=<F6>

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

map <tab> %


" Folding
set foldlevelstart=0
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

augroup ft_puppet
    au!

    au Filetype puppet setlocal foldmethod=marker
    au Filetype puppet setlocal foldmarker={,}
augroup END

augroup ft_perl
    au!

    au Filetype perl setlocal foldmethod=marker
    au Filetype perl setlocal foldmarker={,}
augroup END

augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
augroup END

noremap <leader>p mz:r!pbpaste<cr>`z
noremap <leader>y :.w !pbcopy<CR><CR>
vnoremap <leader>y :w !pbcopy<CR><CR>
