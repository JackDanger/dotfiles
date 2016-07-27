if exists("ftplugin_did_load_gitcommit")
  finish
endif
let ftplugin_did_load_gitcommit = 1
" Always start on the first line of a git commit message
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

