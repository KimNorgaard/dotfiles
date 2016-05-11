" Free from: https://github.com/Greduan/dotfiles/blob/76e16dd8a04501db29989824af512c453550591d/vim/after/plugin/statusline.vim#L3-L42

" Define all the different modes
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \}

" Find out current buffer's size and output it.
function! FileSize() "{{{
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return 'null'
    endif

    if (exists('mbytes'))
        return mbytes . 'MB'
    elseif (exists('kbytes'))
        return kbytes . 'KB'
    else
        return bytes . 'B'
    endif
endfunction "}}}

function! Mode()
  "redraw
  let l:mode = mode()
  if mode ==# "n" | exec 'hi User1 ctermfg=White'
    elseif mode ==# "i" | exec 'hi User1 ctermfg=Cyan'
    elseif mode ==# "R" | exec 'hi User1 ctermfg=Red'
    elseif mode ==# "v" | exec 'hi User1 ctermfg=Yellow'
    elseif mode ==# "V" | exec 'hi User1 ctermfg=Yellow'
    elseif mode ==# "" | exec 'hi User1 ctermfg=Yellow'
  endif
  return g:currentmode[mode]
endfunction

let &stl=''
"let &stl.='%1* %{toupper(g:currentmode[mode()])} %0*'
let &stl.='%1* %{toupper(Mode())} %0*'
let &stl.='>'
let &stl.=' '                   " separator
let &stl.='%{&paste?"PASTE > ":""}'
let &stl.='%{exists("b:git_dir")?fugitive#head()." > ":""}'  " git branch
let &stl.='%([%M%R%H%W] %)'        " modified, read-only, help, preview
let &stl.='%<'                  " truncate
let &stl.='%t'                  " short file name

let &stl.='%='                  " align right
let &stl.=' '                   " separator

let &stl.='%{&ft!=""?&ft." < ":""}'              " file type
let &stl.='%{&fenc!=""?&fenc."":&enc.""}'    " file encoding
let &stl.='%{&ff!=""?"[".&ff."]":""}'              " file format
"let &stl.='%{FileSize()}'       " Output buffer's file size
"let &stl.=']'                   " closing bracket
let &stl.=' '                   " separator
let &stl.='%03c'                  " column
let &stl.='-'                   " separator
let &stl.='%03v'                  " virtual column
let &stl.=' '                   " separator
let &stl.='%3p%%'              " pct

hi User1 guifg=White
hi StatusLine guibg=DarkGrey ctermfg=White guifg=White ctermbg=None
