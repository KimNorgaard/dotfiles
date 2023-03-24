augroup hidelistchartoninsert
  autocmd!
  autocmd InsertEnter * :set listchars-=trail:⌴ | set listchars-=eol:¬
  autocmd InsertLeave * :set listchars+=trail:⌴ | set listchars+=eol:¬
augroup END
