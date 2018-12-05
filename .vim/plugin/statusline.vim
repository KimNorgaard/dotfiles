function TrailingSpaceWarning()
    if !exists("b:statline_trailing_space_warning")
        let lineno = search('\s$', 'nw')
        if lineno != 0
            let b:statline_trailing_space_warning = '[TRL: '.lineno.']'
        else
            let b:statline_trailing_space_warning = ''
        endif
    endif
    return b:statline_trailing_space_warning
endfunction

" recalculate when idle, and after saving
autocmd CursorHold,BufWritePost * unlet! b:statline_trailing_space_warning

set statusline=
set statusline+=%(%m%r%h%w\ %)               " modified, ro, help, preview
set statusline+=%t                           " file name
set statusline+=\ 
set statusline+=%{&paste?\"PASTE\ \":\"\"}   " paste
set statusline+=%<                           " truncate if needed
set statusline+=%#warningmsg#%{TrailingSpaceWarning()}%*
set statusline+=\ 
set statusline+=%=                           " align right
set statusline+=%{&ft!=\"\"?&ft.\"\ \":\"\"} " file type
set statusline+=%03c                        " column
set statusline+=-
set statusline+=%03v                        " virtual column
set statusline+=\ 
set statusline+=%3p%%                       " pct
