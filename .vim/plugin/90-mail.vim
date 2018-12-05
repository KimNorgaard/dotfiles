augroup ft_mail
  autocmd!
  autocmd CursorMoved,CursorMovedI *temp/mutt-* if line('.') < 8 | setlocal fo-=a | else | setlocal fo+=a | endif
  autocmd BufRead *temp/mutt-* execute "normal /^$/\n"
  autocmd BufRead *temp/mutt-* execute "normal o"
  autocmd BufRead *temp/mutt-* execute ":startinsert | \n"
augroup END
