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
set statusline+=%F%(\ [%M%R%H%W%{&paste?\",PASTE\":\"\"}%{TrailingSpaceWarning()}]%)%<\ %=
"               | |    | | | | | |                                                | |   |
"               | |    | | | | | |                                                | |   +-- align right
"               | |    | | | | | |                                                | +-- truncate
"               | |    | | | | | |                                                +-- end item group
"               | |    | | | | | |
"               | |    | | | | | |
"               | |    | | | | | |
"               | |    | | | | | +-- paste mode indication
"               | |    | | | | +-- begin evaluation
"               | |    | | | +-- preview flag
"               | |    | | +-- help flagin
"               | |    | +-- readonly flag
"               | |    +-- modified flag
"               | +-- begin item group
"               +-- full path to file in the buffer

set statusline+=%(%{&ft}\ %)%03c-%03v\ %04l/%04L\ %3p%%
"               | |       | |    |     |    |     |
"               | |       | |    |     |    |     +-- percent
"               | |       | |    |     |    +-- lines
"               | |       | |    |     +-- current line
"               | |       | |    +-- virtual column
"               | |       | +-- column
"               | |       +-- end item group
"               | +-- file type
"               +-- begin item group
