" vim: set sw=4 ts=4 sts=4 et tw=78 foldlevel=0 foldmethod=marker:
" Kim Nørgaard <jasen@jasen.dk>

" Plugin Loading {{{
call plug#begin('~/.vim/plugged')

if has('nvim')
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " completion
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'zchee/deoplete-jedi', {'for': 'python'}               " python completion
Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}      " go completion

Plug 'w0rp/ale'                                             " linting, making

Plug 'tpope/vim-repeat'                                     " let plugins use '.'
Plug 'tpope/vim-surround'                                   " parentheses, brackets, quotes!
Plug 'tpope/vim-endwise'                                    " auto-add endings
Plug 'tpope/vim-fugitive'                                   " git
Plug 'mhinz/vim-signify'                                    " vcs-signs in the sign column

Plug 'fatih/vim-go', {'for': 'go'}                          " go
Plug 'sheerun/vim-polyglot'                                 " language support galore
Plug 'rodjek/vim-puppet', {'for': 'puppet'}                 " puppet

Plug 'tomtom/tlib_vim'                                      " tcomment dependency
Plug 'tomtom/tcomment_vim'                                  " comments

Plug 'majutsushi/tagbar'                                    " browse tags
Plug 'godlygeek/tabular'                                    " tabularize text
Plug 'ervandew/supertab'                                    " use <TAB> for insert completions

Plug 'junegunn/fzf'                                         " fuzzy searching
Plug 'junegunn/fzf.vim'                                     " fuzzy searching

Plug 'jlanzarotta/bufexplorer'                              " fancy buffer-handler

Plug 'pangloss/vim-simplefold'                              " smarter folding

Plug 'NLKNguyen/papercolor-theme'                           " papercolor
Plug 'rakr/vim-one'                                         " vim-one color-schemes
Plug 'widatama/vim-phoenix'                                 " phoenix color-schemes
Plug 'morhetz/gruvbox'                                      " gruvbox
Plug 'kamwitsta/flatwhite-vim'                              " flatwhite
Plug 'https://gitlab.com/ducktape/monotone-termnial.git'
Plug 'altercation/vim-colors-solarized'                     " solarized
Plug 'KKPMW/distilled-vim'                                  " distiled

Plug 'junegunn/goyo.vim'                                    " distraction free writing
Plug 'junegunn/limelight.vim'                               " section highlight

Plug 'soywod/kronos.vim'
Plug 'junegunn/vader.vim'

Plug 'vimwiki/vimwiki', {'branch': 'dev'}                   " vimwiki
Plug 'vim-pandoc/vim-pandoc-syntax'                         " pandoc markdown syntax

call plug#end()
" }}}

" General Settings {{{
filetype plugin indent on         " load plugins and indent

if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if has('termguicolors')
    set termguicolors
endif

set notimeout                     " don't timeout on mappings
set ttimeout                      " do timeout on terminal key codes
set ttimeoutlen=10                " key code timeout
set timeoutlen=500                " mapped key sequence timeout

set hidden                        " switch between buffers without saving

set tabstop=8                     " one tab = eight columns
set softtabstop=2                 " one tab = two spaces (tab key)
set shiftwidth=2                  " one tab = two spaces (autoindent)
set expandtab                     " never use hard tabs

set autoindent                    " keep indenting on <CR>

set textwidth=80                  " wrap after 80 columns
set colorcolumn=+1                " highlight 81st column
set linebreak                     " break on what looks like boundaries
set showbreak=↳\                  " shown at the start of a wrapped line
set formatoptions=qrn1

set incsearch                     " Jump while searching
set ignorecase                    " Case insensitive searches
set smartcase                     " Ignore 'ignorecase' when uppercase is used
set hlsearch                      " Highlight searches
set showmatch                     " Show matching brackets while typing
set gdefault                      " Append /g to replace regex

set foldenable                    " Enable code folding
set foldlevel=100
set foldmethod=indent

set splitbelow                    " Split windows below current window.
set splitright                    " Split windows right of current window
set modeline                      " Check modeline in beginning of file

set completeopt=longest,menuone,preview
set wildmode=longest,list,full    " complete longest common prefix first
set wildignore+=.*.sw*,__pycache__,*.pyc " ignore junk files
set wildmenu                      " show a menu of completions like zsh
set pumheight=16                  " max height of completion menu
set omnifunc=syntaxcomplete#Complete

set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set undodir=~/.vim/tmp/undo       " persistent undo storage
set undofile                      " persistent undo on
set autowrite

set backspace=indent,eol,start
set ttyfast
set magic

" Title string
set title
set titlestring=vim\ %{expand(\"%t\")}

set mousehide                   " Hide mouse when typing
set mouse=                      " No mouse

set history=50                  " keep 50 lines of command line history
set lazyredraw                  " don't update screen inside macros, etc
set matchtime=5                 " ms to show the matching paren for showmatch

set nonumber                    " no line numbers
set numberwidth=5               " width of numbers column
set laststatus=2                " always show status line
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set nocursorline                  " highlight current line
set scrolloff=5                 " keep at lest N lines while scrolling
set noerrorbells                " Do not use bells on errors
set helpheight=0                " Height of help screen is 50%
set list
set listchars=tab:▸\ ,extends:>,precedes:<,nbsp:␠,trail:⌴,eol:¬

set fileformats=unix,dos,mac        " unix linebreaks in new files please
if !has('nvim')
    set encoding=utf-8              " best default encoding
endif
setglobal fileencoding=utf-8        " ...
set nobomb                          " do not write utf-8 BOM!
set fileencodings=utf-8,iso-8859-1  " order to detect Unicodeyness
set shortmess+=I                    " Don't display intro message

set pastetoggle=<F6>                " Toggle paste mode

set tags=./tags;

set diffopt+=vertical

" neovim
if has('nvim')
    let g:python_host_prog = $HOME . '/.python2_neovim/bin/python'
    let g:python3_host_prog = $HOME . '/.python3_neovim/bin/python'
    set inccommand=nosplit          " Live search and replace

    " Make escape work in the Neovim terminal.
    tnoremap <Esc> <C-\><C-n>
    " Start terminal in insert mode
    "autocmd BufEnter term://* startinsert

endif
" }

" Startup {
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
" }

" Vim UI {
    if &t_Co > 2 || has("gui_running")
        syntax on                           " syntax highlighting
        " set t_Co=256                        " 256 colors
        set t_8f=[38;2;%lu;%lu;%lum       " 24 bit colors
        set t_8b=[48;2;%lu;%lu;%lum

        let g:one_allow_italics = 1         " italic comments in 'one'
        let g:two_firewatch_italics=1       " italic comments in 'two'
        let g:gruvbox_italic=1              " italic comments in 'gruvbox'

        let g:nofrils_heavycomments = 1     " make comments stand out
        let g:nofrils_strbackgrounds = 1    " make strings stand out

        " colorscheme frign
        colorscheme monotone-terminal
        " colorscheme distilled
    endif

    if has("gui_running")
        "set macligatures
        set guifont=Fira\ Code:h10
        set linespace=3
        set noicon
        "set macmeta
        set guioptions-=r
        set guioptions-=L
        set guioptions-=T
    endif
" }}}

" Keyboard Mapping {{{
let mapleader = ","                   " map leader

" Edit vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Clear search highlight
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Tab through parans, etc.
map <tab> %

" Hard-wrap paragraphs of text
nnoremap <leader>q gqip

" Map code completion to , + tab
imap <leader><tab> <C-x><C-o>

" Use better regexp
nnoremap / /\v
vnoremap / /\v

" Bubble single lines (kicks butt)
" http://vimcasts.org/episodes/bubbling-text/
nmap <leader>k ddkP
nmap <leader>j ddp

" Bubble multiple lines
vmap <leader>k xkP`[V`]
vmap <leader>j xp`[V`]

" Select pasted text
nnoremap <leader>v V`]
"
" sudo-trick.. Save precious changes as root, fuck yeah
cnoremap w!! w !sudo tee % >/dev/null

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Resolve symlink in order to use fugitive
nnoremap <Leader>L :<C-u>execute 'file '.fnameescape(resolve(expand('%:p')))<bar>
            \ call fugitive#detect(fnameescape(expand('%:p:h')))<CR>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call theming#SynStack()<CR>
" }}}

" Navigation {{{
" Easy buffer/window/tab navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <leader>l :ls<CR>:b<space>
noremap <M-k> :bn<cr>
noremap <A-k> :bn<r>
noremap ∆ :bn<cr>
noremap k :bn<cr>
noremap ‹ :bp<cr>
noremap j :bp<cr>
noremap <M-j> :bp<cr>
noremap <A-j> :bp<cr>

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
" }}}

" Copy/Pasting {{{
" Copy/paste
noremap <leader>p mz:r!pbpaste<cr>`z
noremap <leader>y :.w !pbcopy<CR><CR>
vnoremap <leader>y :w !pbcopy<CR><CR>

" Copy to X CLIPBOARD
map <leader>cc :w !xsel -i -b<CR><CR>
map <leader>cp :w !xsel -i -p<CR><CR>
map <leader>cs :w !xsel -i -s<CR><CR>
" Paste from X CLIPBOARD
map <leader>pp :r!xsel -p<CR><CR>
map <leader>ps :r!xsel -s<CR><CR>
map <leader>pb :r!xsel -b<CR><CR>
" }}}

" Plugin: ale {{{
let g:ale_sign_column_always = 0
let g:ale_fixers = {
    \ 'terraform': ['terraform'],
    \ }
" let g:ale_fix_on_save = 1
" }}}

" Plugin: tabular {{{
autocmd VimEnter *
            \ if exists(":Tabularize") |
                \ nmap <leader>a= :Tabularize /=<CR> |
                \ vmap <leader>a= :Tabularize /=<CR> |
                \ nmap <leader>a: :Tabularize /:\zs<CR> |
                \ vmap <leader>a: :Tabularize /:\zs<CR> |
            \ endif
" }}}

" Plugin: fzf {{{
nnoremap ; :Buffers<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>r :Tags<CR>
" }}}

" Plugin: deoplete {{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
" Auto close scratch window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" TAB-complete
set completeopt+=noinsert,noselect,preview
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" }}}

" Plugin: tagbar {{{
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
" }}}

" Plugin: vim-markdown {{{
let g:vim_markdown_folding_disabled=0
" }}}

" Plugin: polyglot {{{
let g:polyglot_disabled = ['go']
" }}}

" Plugin: gitgutter {{{
let g:gitgutter_enabled = 0
nmap <leader>G :GitGutterToggle<CR>
" }}}

" Plugin: vim-signify {{{
let g:signify_realtime = 1
let g:signify_vcs_list = ['git']
" }}}

" Plugin: vimwiki {{{
let wiki_1 = {}
let wiki_1.path = '~/data/vimwiki'
let wiki_1.template_path = '~/data/vimwiki/templates'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = '~/data/vimwiki.work'
let wiki_2.template_path = '~/data/vimwiki.work/templates'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let g:vimwiki_custom_wiki2html = '~/data/vimwiki/wiki2html.py'
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_folding = 'expr'
" }}}

" Plugin: vim-go {{{
let g:go_fmt_command = "goimports"
" }}}

silent! source ~/.vimrc.local
