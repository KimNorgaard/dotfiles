" vim: set sw=4 ts=4 sts=4 et tw=78 foldlevel=0 foldmethod=marker:
" Kim Nørgard <jasen@jasen.dk>

if !has('nvim')
    set nocompatible
endif

if has('vim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Plugin Loading {{{
call plug#begin('~/.vim/plugged')

if has('nvim')
    Plug 'Shougo/deoplete.nvim'        " completion
    Plug 'zchee/deoplete-jedi', {'for': 'python'}   " python completion
    Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'} " go completion
else
    Plug 'davidhalter/jedi-vim', {'for': 'python'}  " python completion
endif

Plug 'neomake/neomake'                 " linting, making

"Plug 'MarcWeber/vim-addon-mw-utils'    " required by snipmate
"Plug 'garbas/vim-snipmate'             " snippets
"Plug 'honza/vim-snippets'              " actual snippets

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

Plug 'tpope/vim-surround'              " parentheses, brackets, quotes!
Plug 'tpope/vim-repeat'                " let plugins use '.'
Plug 'tpope/vim-fugitive'              " git
Plug 'tpope/vim-endwise'               " auto-add endings
Plug 'airblade/vim-gitgutter'          " git in the gutter

Plug 'sheerun/vim-polyglot'            " language support galore
Plug 'rodjek/vim-puppet', {'for': 'puppet'}  " puppet
Plug 'KimNorgaard/ansible-vim'         " ansible
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}  " markdown

Plug 'tomtom/tlib_vim'                 " tcomment dependency
Plug 'tomtom/tcomment_vim'             " comments

Plug 'majutsushi/tagbar'               " browse tags
Plug 'godlygeek/tabular'               " tabularize text
Plug 'ervandew/supertab'               " use <TAB> for insert completions

" This should die, really. It makes nvim startup slow.
" I only use virtualenv and pep8-indentation.
Plug 'klen/python-mode', {'for': 'python'}

Plug 'vim-scripts/ingo-library'        " SyntaxRange dependency
Plug 'vim-scripts/SyntaxRange'         " filetype within regions of buffer

Plug 'kien/ctrlp.vim'                  " fancy file-finder
Plug 'jlanzarotta/bufexplorer'         " fancy buffer-handler

Plug 'pangloss/vim-simplefold'         " smarter folding

Plug 'fatih/vim-go'

Plug 'NLKNguyen/papercolor-theme'      " papercolor
Plug 'rakr/vim-one'                    " vim-one color-schemes

call plug#end()
" }}}

" General Settings {{{
    filetype plugin indent on         " load plugins and indent

    set termguicolors
    set notimeout                     " don't timeout on mappings
    set ttimeout                      " do timeout on terminal key codes
    set ttimeoutlen=10                " key code timeout
    set timeoutlen=500                " mapped key sequence timeout

    set hidden                        " switch between buffers without saving

    set shiftwidth=2                  " one tab = two spaces (autoindent)
    set softtabstop=2                 " one tab = two spaces (tab key)
    set tabstop=2                     " one tab = two columns
    set expandtab                     " never use hard tabs

    set autoindent                    " keep indenting on <CR>
    set smartindent                   " be smart about indentation

    set wrap                          " wrap long lines
    set textwidth=80                  " wrap after 80 columns
    set colorcolumn=+1                " highlight 81st column
    set linebreak                     " break on what looks like boundaries
    set showbreak=↳\                  " shown at the start of a wrapped line
    set formatoptions=qrn1

    set incsearch                     " Jump while searching
    set ignorecase                    " Case insensitive searches
    set smartcase                     " Ignore 'ignorecase' when uppercase is
                                      " used
    set hlsearch                      " Highlight searches
    set showmatch                     " Show matching brackets while typing
    set gdefault                      " Append /g to replace regex

    set foldenable                    " Enable code folding
    "set foldlevelstart=0
    set foldlevel=100
    set foldmethod=indent

    set splitbelow                    " Split windows below current window.
    set modeline                      " Check modeline in beginning of file

    set complete=.,w,b,u,t
    set completeopt=longest,menuone,preview
    set wildmode=longest,list,full    " complete longest common prefix first
    set wildignore+=.*.sw*,__pycache__,*.pyc " ignore junk files
    set wildmenu                      " show a menu of completions like zsh
    set omnifunc=syntaxcomplete#Complete

    set backupdir=~/.vim/tmp/backup//
    set directory=~/.vim/tmp/swap//
    set backup
    set undodir=~/.vim/tmp/undo       " persistent undo storage
    set undofile                      " persistent undo on
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
        " pretend this is xterm.  it probably is anyway, but if term is left
        " as `screen`, vim doesn't understand ctrl-arrow.
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
    set matchtime=5                 " ms to show the matching paren for
                                    " showmatch

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
    if !has('nvim')
      set encoding=utf-8            " best default encoding
    endif
    setglobal fileencoding=utf-8    " ...
    set nobomb                      " do not write utf-8 BOM!
    set fileencodings=utf-8,iso-8859-1
                                    " order to detect Unicodeyness
    set shortmess+=I                " Don't display intro message

    set pastetoggle=<F6>            " Toggle paste mode

    set tags=./tags;

    set diffopt+=vertical


    " neovim
    if has('nvim')
        let g:python_host_prog = $HOME . '/src/neovim2/bin/python'
        let g:python3_host_prog = $HOME . '/src/neovim3/bin/python'
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
        set t_Co=256                        " 256 colors

        let g:nofrils_heavycomments = 1     " make comments stand out
        let g:nofrils_strbackgrounds = 1    " make strings stand out
        colorscheme nofrils-dark
        "colorscheme paramount
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

" Plugin: tabular {{{
autocmd VimEnter *
    \ if exists(":Tabularize") |
        \ nmap <leader>a= :Tabularize /=<CR> |
        \ vmap <leader>a= :Tabularize /=<CR> |
        \ nmap <leader>a: :Tabularize /:\zs<CR> |
        \ vmap <leader>a: :Tabularize /:\zs<CR> |
    \ endif
" }}}

" Plugin: nerdtree {{{
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
" }}}

" Plugin: ctrlp {{{
  let g:ctrlp_max_files = 50000
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_dotfiles = 1
  let g:ctrlp_lazy_update = 100
  "let g:ctrlp_custom_ignore = {
  "  \ 'dir':  '\v[\/](\.git|venv)$'
  "  \ }
" }}}

" Plugin: deoplete {{{
  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  " Auto close scratch window
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  " TAB-complete
  set completeopt+=noinsert,noselect
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  imap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  imap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" }}}

" Plugin: nerdcommenter {{{
  let g:NERDCustomDelimiters = {
      \ 'puppet': { 'left': '#', 'leftAlt': '/*', 'rightAlt': '*/' }
      \ }
" }}}

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

" Plugin: neosnippet {{{
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}

" Plugin: snipmate {{{
  let g:snipMate = get(g:, 'snipMate', {})
  let g:snipMate.scope_aliases = {}
  let g:snipMate.scope_aliases['mkd'] = 'markdown,mkd'
" }}}

" Plugin: pymode {{{
  let g:pymode_python = 'python3'
  let g:pymode_lint = 0
  let g:pymode_folding = 1
  let g:pymode_rope = 0
  let g:pymode_breakpoint = 0
  let g:pymode_runcode = 0
" }}}

" Plugin: syntastic {{{
  let g:syntastic_puppet_puppetlint_args='--no-80chars-check --no-class_inherits_from_params_class-check'
  " use python-mode, not syntastic
  let g:syntastic_ignore_files = ['\.py$']
" }}}

" Plugin: neomake {{{
  "autocmd! BufWritePost *.py Neomake
  autocmd! FileType python autocmd BufWritePost * Neomake
" }}}

" Plugin: polyglot {{{
  let g:polyglot_disabled = ['ansible', 'markdown', 'python', 'python-compiler']
" }}}

" Plugin: gitgutter {{{
    let g:gitgutter_enabled = 0
    nmap <leader>G :GitGutterToggle<CR>
" }}}

" Plugin: vim-go {{{
    let g:go_fmt_command = "goimports"
" }}}

" text files {{{
    augroup ft_text
        au!
        autocmd FileType text setlocal textwidth=78
    augroup END
" }}}

" eyaml {{{
    augroup ft_eyaml
        au!
        au BufRead,BufNewFile *.eyaml setfiletype yaml
    augroup END
" }}}

" Crontab {{{
    augroup crontab
        au!
        au BufEnter /private/tmp/crontab.* setl backupcopy=yes
    augroup END
" }}}

" General Editing {{{
    " When editing a file, always jump to the last known cursor position.
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

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
" }}}

" Puppet {{{
    augroup ft_puppet
        au!
        au FileType puppet setlocal isk+=:
        au Filetype puppet setlocal foldmethod=marker
        au Filetype puppet setlocal foldmarker={,}
    augroup END
" }}}

" Perl {{{
    augroup ft_perl
        au!
        au Filetype perl setlocal foldmethod=marker
        au Filetype perl setlocal foldmarker={,}
    augroup END
" }}}

" Ruby {{{
    augroup ft_ruby
        au!
        au Filetype ruby setlocal foldmethod=syntax
    augroup END
" }}}

" Ansible {{{
    augroup ft_ansible
        au!
        au Filetype ansible setlocal keywordprg=ansible-doc\ \-s
    augroup END
" }}}

" Mutt {{{
    augroup ft_mail
        au!
        autocmd BufRead,BufNewFile *temp/mutt-* setfiletype mail
        autocmd BufRead,BufNewFile *temp/mutt-* setlocal fo+=aw
        autocmd BufRead,BufNewFile *temp/mutt-* setlocal spell
        autocmd BufRead *temp/mutt-* execute "normal /^$/\n"
        autocmd BufRead *temp/mutt-* execute ":startinsert"
    augroup END
" }}}

" Statusline {{{
    function! WindowNumber()
        return tabpagewinnr(tabpagenr())
    endfunction

    function! TrailingSpaceWarning()
        if !exists("b:statline_trailing_space_warning")
            let lineno = search('\s$', 'nw')
            if lineno != 0
                let b:statline_trailing_space_warning = '[trailing:'.lineno.']'
            else
                let b:statline_trailing_space_warning = ''
            endif
        endif
        return b:statline_trailing_space_warning
    endfunction

    " recalculate when idle, and after saving
    augroup statline_trail
        autocmd!
        autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
    augroup END

    function! LinterErrFlag()
        if exists("*SyntasticStatuslineFlag")
            return SyntasticStatuslineFlag()
        else
            return neomake#statusline#LoclistStatus()
        endif
    endfunction

    set statusline=
    set statusline+=%(%m%r%h%w\ %)               " modified, ro, help, preview
    set statusline+=%{expand('%:h')}/            " relative path
    set statusline+=%t                           " file name
    set statusline+=\ 
    set statusline+=%{&paste?\"PASTE\ \":\"\"}   " paste
    set statusline+=%<                           " truncate if needed
    set statusline+=%#warningmsg#%{TrailingSpaceWarning()}%*
    set statusline+=\ 
    set statusline+=%#warningmsg#%{LinterErrFlag()}%*
    set statusline+=%=                           " align right
    set statusline+=%{&ft!=\"\"?&ft.\"\ \":\"\"} " file type
    set statusline+=%{&fenc!=\"\"?&fenc.\"\ \":&enc.\"\ \"}   " file encoding
    set statusline+=%{&ff!=\"\"?&ff:\"\"}                     " file format
    set statusline+=\ 
    set statusline+=b:%-3n                      " buffer number
    set statusline+=\ 
    set statusline+=w:%-3.3{WindowNumber()}     " window number
    set statusline+=%03c                        " column
    set statusline+=-
    set statusline+=%03v                        " virtual column
    set statusline+=\ 
    set statusline+=%3p%%                       " pct
" }}}

silent! source ~/.vimrc.local
