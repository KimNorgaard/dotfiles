function! TrailingSpaceWarning()
    if !exists("b:statline_trailing_space_warning")
        let lineno = search('\s$', 'nw')
        if lineno != 0
            let b:statline_trailing_space_warning = ',TRL: '.lineno
        else
            let b:statline_trailing_space_warning = ''
        endif
    endif
    return b:statline_trailing_space_warning
endfunction

" recalculate when idle, and after saving
autocmd CursorHold,BufWritePost * unlet! b:statline_trailing_space_warning

set statusline=
" buffer name
set statusline+=%f
" %Y - file type
" %M - modified flag
" %R - readonly flag
" %H - help flag
" %W - preview flag
set statusline+=%(\ [%Y%M%R%H%W%{&paste?\",PASTE\":\"\"}%{TrailingSpaceWarning()}]%)
" %< - truncate
" %= - right align (ruler)
" %l - line number
" %c - colum number
" %V - virtual column number
" %P - percent
set statusline+=%<\ %=%-14.(%l,%c%V%)\ %P
