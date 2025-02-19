" When editing a file, always jump to the last known cursor position.
"autocmd BufReadPost *
"            \ if line("'\"") > 0 && line("'\"") <= line("$") |
"            \   exe "normal g`\"" |
"            \ endif
