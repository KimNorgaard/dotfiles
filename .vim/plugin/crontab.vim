augroup crontab
    autocmd!
    autocmd BufEnter /private/tmp/crontab.* setlocal backupcopy=yes
augroup END
