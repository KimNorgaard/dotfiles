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



set statusline=
set statusline+=%6*%(%m%r%h%w\ %)%*        " modified, ro, help, preview
set statusline+=%5*%{expand('%:h')}/       " relative path
set statusline+=%1*%t%*                    " file name
set statusline+=%6*%{&paste?\"\ PASTE\ \":\"\ \"}%* " paste
set statusline+=%<                            " truncate if needed
set statusline+=%#warningmsg# " warning color
set statusline+=%{TrailingSpaceWarning()}
set statusline+=%*
set statusline+=\ 
set statusline+=%#warningmsg# " warning color
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%=                         " align right

set statusline+=%{&ft!=\"\"?&ft.\"\ \":\"\"} " file type
set statusline+=%{&fenc!=\"\"?&fenc.\"\ \":&enc.\"\ \"}   " file encoding
set statusline+=%{&ff!=\"\"?&ff:\"\"}                     " file format

set statusline+=\ 

"set statusline+=%2*buf:%-3n%* " buffer number
"set statusline+=\ 
"set statusline+=%2*win:%-3.3{WindowNumber()}%* " window number

set statusline+=%03c " column
set statusline+=-
set statusline+=%03v " virtual column
set statusline+=\ 
set statusline+=%3p%% " pct

hi User1 guifg=White
hi StatusLine guibg=DarkGrey ctermfg=White guifg=White ctermbg=None

