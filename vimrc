" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
" Kim Nørgard <jasen@jasen.dk>

set nocompatible                      " vim, not vi

execute pathogen#infect()


" General Settings {
    filetype plugin indent on             " load plugins and indent

    set notimeout                         " don't timeout on mappings
    set ttimeout                          " do timeout on terminal key codes
    set ttimeoutlen=10                    " key code timeout
    set timeoutlen=500                    " mapped key sequence timeout

    set hidden                            " switch between buffers without saving

    set shiftwidth=2                      " one tab = two spaces (autoindent)
    set softtabstop=2                     " one tab = two spaces (tab key)
    set tabstop=2                         " one tab = two columns
    set expandtab                         " never use hard tabs

    set autoindent                        " keep indenting on <CR>
    set smartindent                       " be smart about indentation

    set wrap                              " wrap long lines
    set textwidth=80                      " wrap after 80 columns
    set colorcolumn=+1                    " highlight 81st column
    set linebreak                         " break on what looks like boundaries
    set showbreak=↳\                      " shown at the start of a wrapped line
    set formatoptions=qrn1

    set incsearch                         " Jump while searching
    set ignorecase                        " Case insensitive searches
    set smartcase                         " Ignore 'ignorecase' when uppercase is used
    set hlsearch                          " Highlight searches
    set showmatch                         " Show matching brackets while typing
    set gdefault                          " Append /g to replace regex

    set foldenable                        " Enable code folding
    "set foldlevelstart=0
    set foldlevel=100
    set foldmethod=indent

    set splitbelow                        " Split windows below the current window.
    set modeline                          " Check modeline in beginning of file

    set complete=.,w,b,u,t
    set completeopt=longest,menuone,preview
    set wildmode=longest,list,full           " complete longest common prefix first
    set wildignore+=.*.sw*,__pycache__,*.pyc " ignore junk files
    set wildmenu                             " show a menu of completions like zsh
    set omnifunc=syntaxcomplete#Complete

    set backupdir=~/.vim/tmp/backup//
    set directory=~/.vim/tmp/swap//
    set backup
    set undodir=~/.vim/tmp/undo         " persistent undo storage
    set undofile                        " persistent undo on
    set autowrite
    "au BufLeave,FocusLost * silent! wall     " Save after loosing focus

    set backspace=indent,eol,start
    "set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
    set ttyfast
    set magic

    " Title string
    set title
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

    set mousehide                   " Hide mouse when typing
    set mouse=a                     " Terminal mouse support
    set history=50                  " keep 50 lines of command line history
    set lazyredraw                  " don't update screen inside macros, etc
    set matchtime=5                 " ms to show the matching paren for showmatch

    set number                      " line numbers
    set numberwidth=5               " width of numbers column
    set laststatus=2                " always show status line
    set ruler                       " show the cursor position all the time
    set showcmd                     " display incomplete commands
    set cursorline                  " highlight current line
    set scrolloff=3                 " keep at lest N lines while scrolling
    "set noshowmode                  " Do not show mode on bottom line
    set noerrorbells                " Do not use bells on errors
    set helpheight=0                " Height of help screen is 50%
    set list
    set listchars=tab:▸\ ,extends:>,precedes:<,nbsp:␠,trail:⌴,eol:¬

    set fileformats=unix,dos,mac    " unix linebreaks in new files please
    set encoding=utf-8              " best default encoding
    setglobal fileencoding=utf-8    " ...
    set nobomb                      " do not write utf-8 BOM!
    set fileencodings=utf-8,iso-8859-1
                                    " order to detect Unicodeyness
    set shortmess+=I                " Don't display intro message

    set pastetoggle=<F6>            " Toggle paste mode

    set tags=./tags;

    set diffopt+=vertical
" }

" Vim UI {
    if &t_Co > 2 || has("gui_running")
        syntax on                           " syntax highlighting
        set t_Co=256                        " 256 colors

        let g:nofrils_heavycomments = 1       " make comments stand out
        let g:nofrils_strbackgrounds = 1      " make strings stand out
        colorscheme nofrils-dark
    endif

    if has("gui_running")
        set macligatures
        set guifont=Fira\ Code:h12
        set linespace=3
        set noicon
        "set macmeta
        set guioptions-=r
        set guioptions-=L
        set guioptions-=T
    endif
" }

let mapleader = ","                   " map leader

" clear search highlight
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

map <tab> %

"Hard-wrap paragraphs of text
nnoremap <leader>q gqip

"Map code completion to , + tab
imap <leader><tab> <C-x><C-o>

"Use better regexp
nnoremap / /\v
vnoremap / /\v

"Bubble single lines (kicks butt)
""http://vimcasts.org/episodes/bubbling-text/
nmap <leader>k ddkP
nmap <leader>j ddp

"Bubble multiple lines
vmap <leader>k xkP`[V`]
vmap <leader>j xp`[V`]

" Select pasted text
nnoremap <leader>v V`]

" Easy buffer/window/tab navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <leader>l :ls<CR>:b<space>
noremap <M-k> :bn<cr>
noremap <M-j> :bp<cr>

inoremap <M-1> <Esc>:tabn 1<CR>i
inoremap <M-2> <Esc>:tabn 2<CR>i
inoremap <M-3> <Esc>:tabn 3<CR>i
inoremap <M-4> <Esc>:tabn 4<CR>i
inoremap <M-5> <Esc>:tabn 5<CR>i
inoremap <M-6> <Esc>:tabn 6<CR>i
inoremap <M-7> <Esc>:tabn 7<CR>i
inoremap <M-8> <Esc>:tabn 8<CR>i
inoremap <M-9> <Esc>:tabn 9<CR>i

noremap <M-1> :tabn 1<CR>
noremap <M-2> :tabn 2<CR>
noremap <M-3> :tabn 3<CR>
noremap <M-4> :tabn 4<CR>
noremap <M-5> :tabn 5<CR>
noremap <M-6> :tabn 6<CR>
noremap <M-7> :tabn 7<CR>
noremap <M-8> :tabn 8<CR>
noremap <M-9> :tabn 9<CR>

noremap ø :tabnext<CR>
noremap æ :tabprevious<CR>

" Bind gb to toggle between the last two tabs
map å :exe "tabn ".g:ltv<CR>
function! Setlasttabpagevisited()
    let g:ltv = tabpagenr()
endfunction

augroup localtl
    autocmd!
    autocmd TabLeave * call Setlasttabpagevisited()
augroup END
autocmd VimEnter * let g:ltv = 1

nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" sudo-trick.. Save precious changes as root, fuck yeah
cnoremap w!! w !sudo tee % >/dev/null

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Copy/paste
noremap <leader>p mz:r!pbpaste<cr>`z
noremap <leader>y :.w !pbcopy<CR><CR>
vnoremap <leader>y :w !pbcopy<CR><CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" <leader>v select the text just pasted
nnoremap <leader>v V`]

autocmd VimEnter *
    \ if exists(":Tabularize") |
        \ nmap <leader>a= :Tabularize /=<CR> |
        \ vmap <leader>a= :Tabularize /=<CR> |
        \ nmap <leader>a: :Tabularize /:\zs<CR> |
        \ vmap <leader>a: :Tabularize /:\zs<CR> |
    \ endif

"------------------------"
"NERDTREE PLUGIN SETTINGS
"------------------------"
""Shortcut for NERDTreeToggle
" nmap <leader>nt :NERDTreeToggle <CR>
" noremap  <F2> :NERDTreeToggle<cr>
" inoremap <F2> <esc>:NERDTreeToggle<cr>
"
" augroup ps_nerdtree
"     au!
"
"     au Filetype nerdtree setlocal nolist
" augroup END

"Show hidden files in NerdTree
" let NERDTreeHighlightCursorline = 1
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" let NERDChristmasTree = 1
" let NERDTreeChDirMode = 2
" let NERDTreeMapJumpFirstChild = 'gK'

"autopen NERDTree and focus cursor in new document
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p


"ctrlp
let g:ctrlp_max_files = 50000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_dotfiles = 1
let g:ctrlp_lazy_update = 100


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


autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" eyaml and yaml are the same
au BufRead,BufNewFile *.eyaml setfiletype yaml
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴,eol:¬
    au InsertLeave * :set listchars+=trail:⌴,eol:¬
augroup END

augroup ft_puppet
    au!
    au FileType puppet setlocal isk+=:
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

let g:syntastic_puppet_puppetlint_args='--no-80chars-check --no-class_inherits_from_params_class-check'
" use python-mode, not syntastic
let g:syntastic_ignore_files = ['\.py$']
let g:pymode_lint = 0


let g:NERDCustomDelimiters = {
      \ 'puppet': { 'left': '#', 'leftAlt': '/*', 'rightAlt': '*/' }
      \ }

let g:tagbar_type_puppet = {
  \ 'ctagstype': 'puppet',
  \ 'kinds': [
    \'c:class',
    \'s:site',
    \'n:node',
    \'d:definition',
    \'r:resource',
    \'f:default'
  \]
\}


" distraction-free-writing-vim
"let g:fullscreen_colorscheme = "iawriter"
"let g:fullscreen_font = "Cousine:h14"
"let g:normal_colorscheme = "solarized"
"let g:normal_font="Menlo:h12"

let g:vim_markdown_folding_disabled=1

" snippets
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['mkd'] = 'markdown,mkd'

" pymode
" Don't autofold code. It sucks.
let g:pymode_folding = 0
" Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" No rope. It hurts us.
let g:pymode_rope = 0

" Use separate plugin
let g:polyglot_disabled = ['ansible', 'python']
